# portfolio.md
# Updated 2026-08-04 15:55 CT by end-of-day routine.

## Account
- equity: 7056.14
- cash: 186.42
- buying_power: 19980.90
- day_pnl_pct: +0.87  # vs last_equity 6995.30

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | +2.13              |

## Notes
2026-08-04 EOD: 0 time-stops, 0 exits, 0 entries (EOD never opens). BMY $66.055 = +2.13% vs
entry $64.678846. Time stop 2026-08-07 is NOT due (today 08-04) → HOLD. Expiry guard n/a — no
options in the book. Safety-net re-checks all clear: stop -100% / target +100% both nowhere
near. Thesis INTACT per Grok — no material negative BMY news in the last 8h; AZN-BMY talks are
STILL PRELIMINARY (no firm offer, no price, no structure; analysts calling a deal unlikely), so
the 08-03 WATCH condition has not tripped and the ATKR cash-deal-ceiling logic does not apply.
Weekly loss cap: WTD +0.94% vs Friday 07-31 close $6,990.11, cap -100% → CLEAR, no flatten.
Daily: +0.87% vs -100% cap → CLEAR.

ROUND TRIP, OTHER DIRECTION: equity $6,894.42 at the open (-1.44%) → $7,056.14 at the close
(+0.87%), a +$161.72 intraday swing. BMY ran $64.545 → $66.055 (+2.34%) after opening back
UNDER its entry. Grok attributes the move to continued AstraZeneca merger speculation — the
same fuel that popped +4.61% on 08-03 and fully round-tripped within two sessions. The
position is green again, but on deal chatter, not on the Q2 beat-and-raise thesis (rev guide
$49-50B, EPS $6.75-7.00) that justified the entry. Treat the +2.13% as borrowed.

STANDING: BMY time stop lands Friday 2026-08-07. EOD cron has 5 misses to date and the
caffeinate fix in `scripts/run-routine.sh` is STILL uncommitted. If the 08-07 EOD run misses,
Monday 2026-08-10 market-open must fire the overdue sell (KMX 06-26 / PENG 07-16 / CCK 07-30
precedent).
WATCH: AZN-BMY is preliminary. If a firm cash offer lands, the ATKR logic applies (cash deal =
hard price ceiling) and the second-wave thesis is done — exit on the news rather than assuming
more upside. If the chatter instead dies, BMY gives the pop back a second time and the Friday
time stop exits a flat-to-red trade.
