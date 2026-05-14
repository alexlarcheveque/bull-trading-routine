# portfolio.md
# Rewritten end-to-end by market-open.md and end-of-day.md every run.
# Source of truth is Alpaca (./scripts/alpaca.sh positions); this file is the
# rendered snapshot the next routine reads.

## Account
- equity: 100000
- cash: 100000
- buying_power: 200000
- day_pnl_pct: 0.00
- last_updated: 2026-05-13T23:35-04:00 (initial seed)

## Open positions
| ticker | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|-----|-------------|------------|-------------|--------------------|
| —      | —   | —           | —          | —           | —                  |

## Notes
First run: no positions yet. Pre-market.md runs first and writes a watchlist;
market-open.md reads that watchlist and opens positions which will appear here.
