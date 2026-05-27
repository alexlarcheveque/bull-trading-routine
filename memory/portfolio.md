# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99390.67
- cash: 80219.54
- buying_power: 179610.21
- day_pnl_pct: -0.04
- last_updated: 2026-05-27T12:00-0500 (midday pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | +1.47              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -6.38              |
| SMTC   | 30  | 165.00      | 2026-05-27 | 2026-06-10  | -3.90              |
| WDAY   | 38  | 130.40      | 2026-05-22 | 2026-06-05  | -3.47              |

## Pending orders
None.

## Risk flags
- NVDA at -6.38% — stop trigger at $208.30 (current $209.70, gap $1.40). CRITICAL — EOD must re-evaluate.
- SMTC at -3.90% — stop trigger at $153.45 (current $158.56). Initial position, monitoring.
- WDAY at -3.47% — stop trigger at $121.27 (current $125.87). Monitor.
