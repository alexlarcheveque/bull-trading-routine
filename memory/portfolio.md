# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99666.91
- cash: 75404.71
- buying_power: 175071.62
- day_pnl_pct: +0.39
- last_updated: 2026-05-28T15:55-0500 (end-of-day pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| A      | 36  | 133.745278  | 2026-05-28 | 2026-06-11  | +1.75              |
| CAVA   | 60  | 82.461667   | 2026-05-20 | 2026-06-03  | -4.93              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -4.51              |
| SMTC   | 30  | 165.00      | 2026-05-27 | 2026-06-10  | +0.96              |
| WDAY   | 38  | 130.40      | 2026-05-22 | 2026-06-05  | +0.02              |

## Pending orders
- None.

## Risk flags
- CAVA at -4.93% — stop trigger $76.69 (current $78.40, gap $1.71). CLOSEST to stop. Deteriorated from -2.77% at midday. Pre-market must re-evaluate thesis Friday AM.
- NVDA at -4.51% — stop trigger $208.30 (current $213.88, gap $5.58). Recovered slightly vs yesterday's close.
- A at +1.75% — performing well, new position today (full 36-share fill confirmed).
- SMTC at +0.96% — positive on position; continued recovery from yesterday's close.
- WDAY at +0.02% — essentially flat; strong intraday recovery (+4.76% today) from prior deep negative.
