# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99630.98
- cash: 75404.71
- buying_power: 175035.69
- day_pnl_pct: +0.35
- last_updated: 2026-05-28T12:00-0500 (midday pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| A      | 36  | 133.745278  | 2026-05-28 | 2026-06-11  | +1.19              |
| CAVA   | 60  | 82.461667   | 2026-05-20 | 2026-06-03  | -2.77              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -5.25              |
| SMTC   | 30  | 165.00      | 2026-05-27 | 2026-06-10  | +1.57              |
| WDAY   | 38  | 130.40      | 2026-05-22 | 2026-06-05  | -2.18              |

## Pending orders
- None.

## Risk flags
- NVDA at -5.25% — stop trigger at $208.30 (current $212.23, gap $3.93). Closest to stop. Monitor closely.
- WDAY at -2.18% — stop trigger at $121.27 (current $127.56, gap $6.29). Recovering from -4.15% at open.
- CAVA at -2.77% — thesis intact; Q1 beat-and-raise catalyst still valid. No action needed.
- A at +1.19% — full 36-share fill confirmed (avg $133.745278); performing well above entry.
- SMTC at +1.57% — strong intraday recovery (+6.6% today), now positive on position.
