# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99509.05
- cash: 85169.54
- buying_power: 179728.59
- day_pnl_pct: +0.08
- last_updated: 2026-05-27T09:30-0500 (market-open pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | +0.05              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -5.67              |
| WDAY   | 38  | 130.40      | 2026-05-22 | 2026-06-05  | -4.33              |

## Pending orders
| order_id | ticker | side | qty | status | submitted |
|----------|--------|------|-----|--------|-----------|
| 1ca88290-2610-4920-8105-93a362b2db6d | SMTC | BUY | 30 | new (not filled at routine end) | 2026-05-27 09:30 |

## Risk flags
- NVDA at -5.67% — stop trigger at $208.30 (current $211.275). Midday must re-evaluate.
- WDAY at -4.33% — stop trigger at $121.27 (current $124.755). Monitor.
- SMTC pending order: midday must check fill and append trade-log entry if filled.
