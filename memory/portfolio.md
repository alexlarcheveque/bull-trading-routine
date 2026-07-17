# portfolio.md
# Updated 2026-07-17 06:39 by market-open routine.

## Account
- equity: 80036.86
- cash: 1461.86
- buying_power: 5847.44
- day_pnl_pct: -12.74

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| MRK260724C00130000 | call | 449 | 2.01 | 2026-07-17 | 2026-07-24 | -12.94 |

## Notes
2026-07-17 market-open: BUY 449x MRK 07-24 $130 calls @ $2.01 (premium $90,249, order e3e48485, filled in <30s). Score 8 — FDA approval of Lipfendra, first oral PCSK9 inhibitor. Call path: spot $129.26, only expiry in 3-7 DTE window is 07-24 (7 DTE); strike 130 = nearest at/above spot; ask $2.04 → 449 contracts under 100% premium cap; filled $2.01. Preflight OK. No exits (book was flat). Halt checks clear at entry time (day 0%, week ~-7.5%, 0/1 positions). day_pnl_pct -12.74 is the immediate mark of the position at bid $1.75 vs $2.01 ask-side entry — mostly bid-ask spread on a fresh fill, not a price move. NOTE for EOD: target_exit = expiry date (07-24); expiry guard (sell within 2 trading days of expiry) will force exit by ~07-22 — earlier than the time stop. UNH (also 8) was the fallback, not taken (1/1 daily cap).
