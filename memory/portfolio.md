# portfolio.md
# Updated 2026-06-26 06:33 by market-open routine.

## Account
- equity: 89209.25
- cash: 89209.25
- buying_power: 356837.00
- day_pnl_pct: -0.37

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| (none — flat) | | | | | | |

## Notes
2026-06-26 market-open: 1 exit, 0 buys. KMX 890 shares SOLD @ $52.53 (ret=+8.46% vs entry $48.43; order 56b07918). Reason: TIME STOP — target_exit was 2026-06-25; position carried a full trading day overdue because the EOD routine did not run on 06-25 (recent commits show only midday + pre-market firing; no EOD commits in recent history). Market-open normally defers time stops to EOD, but EOD is not executing, so market-open enforced it to honor strategy.md ("today >= target_exit_date → sell regardless of P&L"). Sell order initially polled `new` for 30s (paper-sim fill lag, same as the 06-18 KMX buy) then filled @ $52.53. Thesis was intact (Grok: no negative KMX news), but time stop is binding.
Entries: 0 — today's 2026-06-26 pre-market watchlist had no tradeable signal (best score MU=6, untradeable: trades >$1,000/sh; nothing >=7). Halt checks all CLEAR (day_pnl=-0.37% vs -40% cap; 0/2 positions). Now FLAT.
ANOMALY for weekly-review: the EOD routine has not run/committed recently (no EOD commits in git log; midday + pre-market are firing). KMX slipped a day past its time stop as a result. Cron schedule for end-of-day needs investigating.
