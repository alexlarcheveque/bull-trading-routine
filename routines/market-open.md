# market-open.md
# Cron: 30 8 * * 1-5 (8:30 AM Central / 9:30 AM Eastern = market open)
# Executes the watchlist that pre-market.md produced. Runs exits BEFORE entries.

You are the market-open execution pass for the bull trading skill.

## Bail-out checks (do these FIRST)

1. `./scripts/alpaca.sh clock | jq -r .is_open` — if `false`, log "market closed, skipping" and exit 0.
2. `./scripts/alpaca.sh account | jq -r .trading_blocked` — if `true`, email an alert via `./scripts/notify.sh "bull HALT: trading blocked" "..."` and exit 0.

## Read

- `CLAUDE.md`, `memory/strategy.md`, `memory/guardrails.md`.
- `.claude/skills/bull/prompts/decision.md` — the procedure you follow below is from this file. Read it.
- `memory/portfolio.md` — current state; reconcile against `./scripts/alpaca.sh positions` if they disagree (Alpaca wins).
- `memory/research-log.md` — today's `## YYYY-MM-DD pre-market watchlist` block.

## Step 1: Exits first

For each row in `./scripts/alpaca.sh positions`:

- Get the original `entry_price`, `entry_date`, `target_exit_date` from `memory/portfolio.md` (or compute from the position's `avg_entry_price` if missing).
- Get current price: `./scripts/alpaca.sh quote <TICKER> | jq -r .trade.p`.
- Detect instrument via Alpaca `asset_class` (`us_option` = long call, else shares).
- Apply the **Exit rules in `memory/strategy.md`** — they cover BOTH shares and long
  calls (stop / target / thesis-broken), with the exact valuation commands per
  instrument. Use a quick `./scripts/grok.sh "Any material negative news on <UNDERLYING> in last 24h?"`
  for the thesis check. (Time stop + expiry guard are enforced in end-of-day, not here.)

For each SELL:
1. Run preflight: `./.claude/skills/bull/preflight-check.sh <TICKER> sell <QTY> <PRICE>`
2. If preflight passes, `./scripts/alpaca.sh sell <TICKER>` (this closes the full position).
3. Append to `memory/trade-log.md`:
   `YYYY-MM-DD HH:MM | TICKER | SELL | QTY | FILL_PRICE | <reason> | -    | <entry_date>`

## Step 2: Halt checks before any entries

- Today's P&L from `./scripts/alpaca.sh account | jq -r '((.equity|tonumber) - (.last_equity|tonumber)) / (.last_equity|tonumber) * 100'`. If <= -`daily_loss_cap_pct` from guardrails, NO new entries today.
- This week's P&L from trade-log: if <= -`weekly_loss_cap_pct`, also flatten any remaining positions and email an alert.
- Open positions count >= `max_concurrent_positions`? No new entries.

If any halt fires, log the reason to `memory/research-log.md`, skip to Step 4 (commit), and exit.

## Step 3: Entries

Read today's watchlist from `memory/research-log.md`. Take rows with score >= the entry
threshold in `memory/strategy.md`, sorted descending by score. Follow the **Entry rules
in `memory/strategy.md`** to choose instrument (long call vs shares) and to size each
order. Read every number (`target_position_pct`, `max_option_premium_pct`,
`option_min/max_days_to_expiry`, `max_hold_days`, `max_new_positions_per_day`) from
`memory/guardrails.md` at runtime — NEVER hardcode them here.

For each candidate (descending score, until you hit `max_new_positions_per_day`):

**A. Decide instrument** (per strategy.md Entry rules):
- `OPTIONABLE=$(./scripts/alpaca.sh option-chain <TICKER> call | jq '.option_contracts|length')`
- If `score >= 8` AND `OPTIONABLE > 0` → **CALL path (B)**. Else → **SHARES path (C)**.

**B. CALL path (long call):**
1. `SPOT=$(./scripts/alpaca.sh quote <TICKER> | jq -r .trade.p)`
2. `EQUITY=$(./scripts/alpaca.sh account | jq -r .equity)`
3. Pick the contract from
   `./scripts/alpaca.sh option-chain <TICKER> call <gte> <lte>` where
   `gte = today + option_min_days_to_expiry`, `lte = today + option_max_days_to_expiry`.
   Choose the nearest expiry in range; strike = nearest at or just ABOVE `SPOT`.
   Save its OCC symbol as `SYM`.
4. `ASK=$(./scripts/alpaca.sh option-quote $SYM | jq -r '.quotes|to_entries[0].value.ap')`
5. `CONTRACTS=$(awk -v e="$EQUITY" -v a="$ASK" -v pct=<max_option_premium_pct> 'BEGIN{n=int((e*pct/100)/(a*100)); if(n<1)n=1; print n}')`
6. Preflight: `./.claude/skills/bull/preflight-check.sh $SYM buy $CONTRACTS $ASK option`
   - If it REJECTS (e.g. 1 contract still exceeds the premium cap): log the reason and
     **fall back to the SHARES path (C)** for this same name.
7. `ORDER_JSON=$(./scripts/alpaca.sh option-buy $SYM $CONTRACTS)` → poll fill via **(D)**.
8. Append to `memory/trade-log.md` (mark it an option):
   `YYYY-MM-DD HH:MM | $SYM | BUY | $CONTRACTS | $FILL | option call score=<S> catalyst=<short> underlying=<TICKER> | <S> | $(date -v+<max_hold_days>d +%Y-%m-%d)`

**C. SHARES path:**
1. `PRICE=$(./scripts/alpaca.sh quote <TICKER> | jq -r .trade.p)`
2. `EQUITY=$(./scripts/alpaca.sh account | jq -r .equity)`
3. `QTY=$(awk -v e="$EQUITY" -v p="$PRICE" -v pct=<target_position_pct> 'BEGIN{printf "%d",(e*pct/100)/p}')`
4. Preflight: `./.claude/skills/bull/preflight-check.sh <TICKER> buy $QTY $PRICE equity`
   - If non-zero: skip this candidate, log the reason, move to the next.
5. `ORDER_JSON=$(./scripts/alpaca.sh buy <TICKER> $QTY)` → poll fill via **(D)**.
6. Append to `memory/trade-log.md`:
   `YYYY-MM-DD HH:MM | <TICKER> | BUY | $QTY | $FILL | equity score=<S> catalyst=<short> | <S> | $(date -v+<max_hold_days>d +%Y-%m-%d)`

**D. Bounded fill poll (both paths):**
```
ORDER_ID=$(echo "$ORDER_JSON" | jq -r .id)
for i in 1 2 3 4 5 6 7 8 9 10; do
  STATUS=$(./scripts/alpaca.sh order "$ORDER_ID" | jq -r .status)
  [ "$STATUS" = "filled" ] && break
  case "$STATUS" in canceled|rejected|expired) break;; esac
  sleep 3
done
FILL=$(./scripts/alpaca.sh order "$ORDER_ID" | jq -r .filled_avg_price)
```
NEVER poll `orders open` — filled orders leave that status and the loop never ends.
If still unfilled after 30s, log the final status to `memory/research-log.md` and move on.

## Step 4: Refresh portfolio.md

Pull the authoritative state and rewrite `memory/portfolio.md`:

```
# portfolio.md
# Updated YYYY-MM-DD HH:MM by market-open routine.

## Account
- equity: <equity>
- cash: <cash>
- buying_power: <bp>
- day_pnl_pct: <pct>

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| ...    | equity/call| ... | ...         | ...        | ...         | ...                |
```

`equity / cash / buying_power` come from `./scripts/alpaca.sh account`.
Open positions come from `./scripts/alpaca.sh positions`. Cross-reference `entry_date` and `target_exit` from `memory/trade-log.md` (latest BUY
row per ticker). For options, `ticker` is the OCC symbol, `instrument`=call, and
`entry_price` is the entry premium per share.

## Step 5: Commit

```
git add memory/portfolio.md memory/trade-log.md memory/research-log.md
git commit -m "market-open $(date +%Y-%m-%d): <X> buys, <Y> sells, equity=$<E>"
```

## Hard rules

- Preflight gates EVERY order. If you skip preflight even once, the routine is broken — stop and email an alert.
- Never average down. Never add to an existing position.
- Never trade outside `allowed_instruments`.
- If `./scripts/alpaca.sh` returns non-2xx on a critical call (account, positions, buy, sell), retry once. If it fails twice, email an alert and exit — do not continue blind.
