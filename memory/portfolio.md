# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 99894.60
- cash: 95052.30
- buying_power: 194946.90
- day_pnl_pct: -0.11
- last_updated: 2026-05-20T15:55-0500 (end-of-day pass)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| CAVA   | 60  | 82.4617     | 2026-05-20 | 2026-06-03  | -2.16              |

## Notes
Manual entry: human override of the 150k volume floor on CAVA. Hypothetical
score 9 (Q1 beat-and-raise). Preflight passed — volume floor lives in the
pre-market rubric, not in guardrails. Time stop 2026-06-03.
