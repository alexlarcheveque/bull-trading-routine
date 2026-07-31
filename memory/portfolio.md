# portfolio.md
# Updated 2026-07-31 06:36 by market-open routine.

## Account
- equity: 6898.59
- cash: 186.43
- buying_power: 19539.77
- day_pnl_pct: -0.21  # vs last_equity 6913.03

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -0.22              |

## Notes
2026-07-31 open: BOUGHT 104 BMY @ $64.678846 (order bfff9d35, filled in one poll cycle,
-0.06% under the $64.72 quote). Score 7: Q2 EPS $2.04 vs $1.59 est + FY26 guidance raise
(rev $46-47.5B→$49-50B, EPS $6.05-6.35→$6.75-7.00), day-2 second-wave entry per CCK
07-22 precedent. Mega-cap (~$132B) → shares only, no call path (07-17 rule). Gap sanity
check passed: quoted $64.72 < $65.62 ceiling (+2.6% cumulative vs pre-catalyst close
$63.10, inside the 1-4% mega drift band). Sized with 98% haircut: floor(0.98 × 6913.03
÷ 64.72) = 104 sh, ~$6,727 notional, cash remaining $186.43. Book now FULL (1/1).
Time stop 2026-08-07 (Friday) — EOD cron reliability matters that day; caffeinate fix
still uncommitted. No exits this morning (book was empty at the bell). Day -0.21%.
