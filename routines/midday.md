# midday.md
# Cron: 0 12 * * 1-5 (12:00 PM Central / 1:00 PM Eastern)
# Defense only. Cuts losers and broken-thesis positions intraday.
# Does NOT open new positions — that's market-open.md's job.

You are the midday risk pass. Be cheap and decisive.

## Bail-out

`./scripts/alpaca.sh clock | jq -r .is_open` — if `false`, exit 0.

## Read

- `memory/strategy.md` — exit rules.
- `memory/guardrails.md` — daily_loss_cap_pct.
- `memory/portfolio.md` and `./scripts/alpaca.sh positions` — reconcile, Alpaca wins.

## Step 1: Per-position exit check

For each open position, detect the instrument via Alpaca `asset_class`
(`us_option` = long call, else shares), then apply the **Exit rules in
`memory/strategy.md`** (stop / target / thesis-broken — both instruments).
Time stop + expiry guard are end-of-day's job, not midday's.

1. Current value:
   - shares: `./scripts/alpaca.sh quote <TICKER> | jq -r .trade.p`
   - option: `./scripts/alpaca.sh option-quote <OCC> | jq -r '.quotes|to_entries[0].value.bp'` (bid)
2. Entry: from `memory/portfolio.md` (shares: entry_price; option: entry premium),
   or the position's `avg_entry_price`.
3. Return %: `(current - entry) / entry * 100`.
4. Trigger (thresholds from strategy.md / guardrails.md — never hardcode):
   - shares: return <= -`per_trade_stop_pct` → SELL; return >= +`per_trade_target_pct` → SELL.
   - option: return <= -`option_stop_pct` → SELL; return >= +`option_target_pct` → SELL.
   - thesis broken (either): `./scripts/grok.sh "Any material negative news on <UNDERLYING> in the last 6 hours? Be specific — guidance cut, recall, lawsuit, regulatory reversal, key exec leaving."` — if Grok returns something concrete, SELL.

For each SELL (instrument-aware):
- shares:  `./.claude/skills/bull/preflight-check.sh <TICKER> sell <QTY> <PRICE> equity` then `./scripts/alpaca.sh sell <TICKER>`
- option:  `./.claude/skills/bull/preflight-check.sh <OCC> sell <QTY> <PREMIUM> option` then `./scripts/alpaca.sh option-sell <OCC>`
- Append the close to `memory/trade-log.md` (for options, record the exit premium as fill_price).

## Step 2: Daily loss cap

```
DAY_PNL=$(./scripts/alpaca.sh account | jq -r '((.equity|tonumber) - (.last_equity|tonumber)) / (.last_equity|tonumber) * 100')
```

If `DAY_PNL <= -daily_loss_cap_pct`:
- Cancel any open orders: `./scripts/alpaca.sh cancel-all`
- Email alert: `./scripts/notify.sh "bull DAILY LOSS CAP HIT" "Day P&L: $DAY_PNL%. Trading halted until end-of-day."`
- Write a halt marker line to `memory/research-log.md`.

(We do NOT flatten everything at the daily cap — only the weekly cap forces flatten. Daily cap just stops new buys for the rest of the day, which market-open already enforced this morning. Midday's job is to make sure the cap is logged and surfaced.)

## Step 3: Commit

```
git add memory/portfolio.md memory/trade-log.md memory/research-log.md
git commit -m "midday $(date +%Y-%m-%d): <N> exits, day_pnl=<P>%"
```

## Hard rules

- Never open positions from midday. Exits and notifications only.
- Preflight gates every sell.
- If Grok is uncertain about "thesis broken", do NOT sell. Only sell on concrete, named negative news.
