# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99741.22
- cash: 90124.74
- buying_power: 189865.96
- day_pnl_pct: -0.14
- last_updated: 2026-05-21T08:32-0500 (market-open pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | -6.50              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | +1.28              |

## Notes
- CAVA: -6.50% unrealized — approaching -7% stop ($76.69). Midday routine must re-evaluate.
- NVDA: entered at open on Q1 FY27 beat-and-raise; Q2 guide $91B vs $87B consensus.
