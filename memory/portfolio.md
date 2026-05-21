# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99726.79
- cash: 90124.74
- buying_power: 189851.53
- day_pnl_pct: -0.16
- last_updated: 2026-05-21T09:50-0700 (manual fix after market-open hang)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | -3.79              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -1.74              |

## Notes
NVDA entered today via market-open cron (first fully-automated entry). Routine
hung in an `until` poll loop after the order filled — order is fine, but the
loop polled `orders open` for a `filled` status that never appears there.
Routine prompt needs a fix; see Step 6 of market-open.md.
