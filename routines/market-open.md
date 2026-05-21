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
- Compute return: `(current - entry) / entry * 100`.
- Apply exit rules from `memory/strategy.md`:
  - return >= +12% → SELL (profit target)
  - return <= -7% → SELL (stop loss)
  - thesis broken (check today's Grok output via a quick `./scripts/grok.sh "Any material negative news on $TICKER in last 24h?"`) → SELL
  - (time stop is enforced in end-of-day, not here)

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

Read today's watchlist from `memory/research-log.md`. Take rows with score >= 7,
sorted descending by score.

For each candidate (in order, until you hit `max_new_positions_per_day`):

1. `PRICE=$(./scripts/alpaca.sh quote <TICKER> | jq -r .trade.p)`
2. `EQUITY=$(./scripts/alpaca.sh account | jq -r .equity)`
3. `QTY=$(awk -v e="$EQUITY" -v p="$PRICE" 'BEGIN{printf "%d", (e * 0.05) / p}')` — 5% sizing (matches `target_position_pct`)
4. `./.claude/skills/bull/preflight-check.sh <TICKER> buy $QTY $PRICE`
   - If exit non-zero: skip this candidate, log the rejection reason from preflight's stderr to research-log.md. Move to next candidate.
5. `ORDER_JSON=$(./scripts/alpaca.sh buy <TICKER> $QTY)` — capture the response so you have the order id.
6. `ORDER_ID=$(echo "$ORDER_JSON" | jq -r .id)` — extract the id, then poll the **specific order** for fill:
   ```
   for i in 1 2 3 4 5 6 7 8 9 10; do
     STATUS=$(./scripts/alpaca.sh order "$ORDER_ID" | jq -r .status)
     [ "$STATUS" = "filled" ] && break
     [ "$STATUS" = "canceled" ] || [ "$STATUS" = "rejected" ] || [ "$STATUS" = "expired" ] && break
     sleep 3
   done
   FILL_PRICE=$(./scripts/alpaca.sh order "$ORDER_ID" | jq -r .filled_avg_price)
   ```
   Do **NOT** use `orders open` — filled orders leave the `open` status, so polling that endpoint will loop forever. Always fetch the specific order id, with a bounded retry count (max 10 × 3s = 30s).
   If after 30s the order is still not `filled`, log the final status to `memory/research-log.md` and move on; do not block the routine.
7. Append to `memory/trade-log.md`:
   `YYYY-MM-DD HH:MM | TICKER | BUY | QTY | FILL_PRICE | score=<S> catalyst=<short> | <S> | $(date -v+14d +%Y-%m-%d)`

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
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| ...    | ... | ...         | ...        | ...         | ...                |
```

`equity / cash / buying_power` come from `./scripts/alpaca.sh account`.
Open positions come from `./scripts/alpaca.sh positions`. Cross-reference `entry_date`
and `target_exit` from `memory/trade-log.md` (latest BUY row per ticker).

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
