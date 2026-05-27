# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99276.00
- cash: 80219.54
- buying_power: 179495.54
- day_pnl_pct: -0.15
- last_updated: 2026-05-27T15:55-0500 (EOD pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | +0.02              |
| NVDA   | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -5.10              |
| SMTC   | 30  | 165.00      | 2026-05-27 | 2026-06-10  | -5.02              |
| WDAY   | 38  | 130.40      | 2026-05-22 | 2026-06-05  | -4.55              |

## Pending orders
None.

## Risk flags
- NVDA at -5.10% — stop trigger at $208.30 (current $212.56, gap $4.26). Recovered from midday low $209.70; monitor.
- SMTC at -5.02% — stop trigger at $153.45 (current $156.72, gap $3.27). Post-earnings drift; watch closely.
- WDAY at -4.55% — stop trigger at $121.27 (current $124.47, gap $3.20). Gap tightening; watch.
- CAVA at +0.02% unrealized (+2.69% today) — comfortable buffer; no action needed.
