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

For each open position:

1. Current price: `./scripts/alpaca.sh quote <TICKER> | jq -r .trade.p`
2. Entry price: from `memory/portfolio.md` (or position's `avg_entry_price`).
3. Return %: `(current - entry) / entry * 100`.
4. Trigger:
   - return <= -7% → SELL (stop loss)
   - return >= +12% → SELL (profit target)
   - thesis broken: `./scripts/grok.sh "Any material negative news on $TICKER in the last 6 hours? Be specific — guidance cut, recall, lawsuit, regulatory reversal, key exec leaving."` — if Grok returns something concrete, SELL.

For each SELL:
- `./.claude/skills/bull/preflight-check.sh <TICKER> sell <QTY> <PRICE>`
- `./scripts/alpaca.sh sell <TICKER>`
- Append to `memory/trade-log.md`.

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
