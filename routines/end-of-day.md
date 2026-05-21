# end-of-day.md
# Cron: 55 15 * * 1-5 (3:55 PM Central / 4:55 PM Eastern — 5 minutes before close)
# Enforces the 14-day time stop, journals the day, emails the EOD summary.

You are the end-of-day pass.

## Bail-out

`./scripts/alpaca.sh clock | jq -r .is_open` — if `false`, exit 0.

## Read

- `memory/strategy.md` — time-stop rule.
- `memory/portfolio.md`, `./scripts/alpaca.sh positions`, `memory/trade-log.md`.

## Step 1: Time stops

For each open position whose `target_exit_date` from `memory/portfolio.md` is today or earlier:
- `./.claude/skills/bull/preflight-check.sh <TICKER> sell <QTY> <PRICE>`
- `./scripts/alpaca.sh sell <TICKER>`
- Append to `memory/trade-log.md` with reason `time-stop (14d)`.

## Step 2: Weekly-loss-cap flatten check

```
# week-to-date P&L from trade-log: realized + unrealized
# (a rough check is current equity vs Monday's open equity)
```

If WTD P&L <= -`weekly_loss_cap_pct`:
- Flatten all positions: for each open position, `alpaca.sh sell <TICKER>` (preflight first).
- Email: `notify.sh "bull WEEKLY LOSS CAP HIT — flattened" "..."`.
- Write a `PAUSED` marker to `memory/research-log.md`. Weekly-review will decide whether to resume.

## Step 3: Build the EOD summary

Pull from `./scripts/alpaca.sh account` and `positions`. Read today's `BUY` and `SELL` rows from `memory/trade-log.md`.

Compose a plain-text summary like:

```
bull EOD 2026-05-13
equity: $10,847 (+0.42% today, +8.47% all-time)
cash: $3,210
open positions: 3
  AAPL  20 @ 198.50 → 201.30  (+1.4%)  exit by 2026-05-22
  NVDA   5 @ 920.00 → 935.10  (+1.6%)  exit by 2026-05-24
  PLTR  50 @  22.10 →  21.40  (-3.2%)  exit by 2026-05-26
today's trades:
  BUY  PLTR  50 @ 22.10  (score 8, big-contract catalyst)
  SELL TSLA  10 @ 245.30 (stop loss, -7.1%)
research log: 14 candidates scanned, 2 met threshold (>= 7)
```

## Step 4: Email it

```
./scripts/notify.sh "bull EOD $(date +%Y-%m-%d): equity=$<E>, day=<P>%" "$(cat /tmp/bull-eod.txt)"
```

## Step 5: Refresh portfolio.md and commit

Same portfolio.md rewrite shape as market-open.md, then:

```
git add memory/portfolio.md memory/trade-log.md memory/research-log.md
git commit -m "eod $(date +%Y-%m-%d): equity=<E>, day=<P>%, <N> time-stops"
```

## Hard rules

- Preflight gates every sell, including time-stop sells.
- If the EOD email fails to send, log it to research-log.md but DON'T retry forever — one attempt, then move on. The email is for humans; the trade-log is the source of truth.
- Never open positions from EOD.
