# portfolio.md
# Updated 2026-07-21 08:40 by market-open routine.

## Account
- equity: 1454.98
- cash: 1454.98
- buying_power: 5819.92
- day_pnl_pct: -87.16

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| MRK260724C00130000 | call | 449 | 2.01 | 2026-07-17 | 2026-07-24 | -100.0 |

## Notes
2026-07-21 market-open: **MRK call hit the -100% premium stop** (bid $0.00, spot $124.975 vs strike 130, 3 DTE). Market close rejected twice by Alpaca (no bid in book — "reenter with a limit"). A day LIMIT sell-to-close for all 449 contracts is **WORKING at $0.05** (order 61cab386-f81e-455f-8b52-a80cb69de452, preflight passed; started $0.15, laddered down). Position shown above because it has NOT yet filled — book remains 1/1, which blocked today's CCK entry (score 7). Alert emailed.
⚠️ Standing orders: midday TODAY — check order 61cab386; if filled, append SELL row to trade-log and free the book; if unfilled, ladder to $0.01. EOD 2026-07-22 — expiry-guard close is MANDATORY (07-24 expiry); use a LIMIT (market close gets rejected with no bid), never ride into expiry.
