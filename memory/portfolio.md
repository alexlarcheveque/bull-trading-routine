# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99296.49
- cash: 79011.47
- buying_power: 174683.75
- day_pnl_pct: +0.02
- last_updated: 2026-05-28T08:34-0500 (market-open pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| A      | 9   | 134.23      | 2026-05-28 | 2026-06-11  | -0.15              |
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | -1.66              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -4.98              |
| SMTC   | 30  | 165.00      | 2026-05-27 | 2026-06-10  | -2.64              |
| WDAY   | 38  | 130.40      | 2026-05-22 | 2026-06-05  | -4.15              |

## Pending orders
- A buy 27 remaining shares (order b73867cc-df71-424f-a61b-5a5ffcb1b7a7, status: partially_filled). 9 of 36 shares filled @ $134.23. Midday routine must check order and append trade-log when full fill confirmed.

## Risk flags
- NVDA at -4.98% — stop trigger at $208.30 (current $212.82, gap $4.52). Monitor closely.
- WDAY at -4.15% — stop trigger at $121.27 (current $124.99, gap $3.72). Watch.
- SMTC at -2.64% — stop trigger at $153.45 (current $160.64, gap $7.19). Recovered from yesterday's -5%; comfortable buffer.
- A at -0.15% — partial fill (9/36 shares); remaining order working. Midday must confirm fill.
- CAVA at -1.66% — thesis intact; no action needed.
