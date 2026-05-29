# portfolio.md
# Updated 2026-05-28 23:16 manually (options schema migration).

## Account
- equity: 99275.95
- cash: 75404.71
- buying_power: 174680.66
- day_pnl_pct: 0

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| A | equity | 36 | 133.745278 | 2026-05-28 | 2026-06-11 | -8.03 |
| CAVA | equity | 60 | 82.461667 | 2026-05-20 | 2026-06-03 | -4.79 |
| NVDA | equity | 22 | 223.98 | 2026-05-21 | 2026-06-04 | -3.87 |
| SMTC | equity | 30 | 165 | 2026-05-27 | 2026-06-10 | 1.21 |
| WDAY | equity | 38 | 130.4 | 2026-05-22 | 2026-06-05 | 0.61 |

## Notes
Schema migrated for options. All 5 current positions are SHARES, grandfathered under
their original 14-day targets (opened before the 7-day aggressive rule). New positions
use max_hold_days=7. target_exit dates back-filled from trade-log.
