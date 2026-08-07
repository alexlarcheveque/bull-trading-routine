# portfolio.md
# Updated 2026-08-07 13:10 CT by end-of-day routine (DEGRADED — ran after the close).

## Account
- equity: 6915.22
- cash: 186.42
- buying_power: 19586.32
- day_pnl_pct: +0.83  # vs last_equity 6858.02

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | +0.03              |

## Notes

2026-08-07 EOD: **DEGRADED — bail-out taken, no orders placed or possible.** launchd
fired **13:05:18 PDT = 16:05 ET**, five minutes *after* the 16:00 ET close, so
`clock.is_open` was already `false` at routine start. 21st failed EOD in 60 runs (~35%),
same mode as 08-06: the 12:55 trigger buys a 5-minute cushion and launchd deferred the
job 10m18s.

**🔴 BMY'S TIME STOP WAS DUE TODAY AND IS UNFIRED GOING INTO A THREE-DAY WEEKEND.**
104 shares = **$6,728.80 = 97.3% of equity**, unmanaged with no stop until Monday
2026-08-10 09:30 ET. Every gate behaved correctly and every gate deferred to EOD —
market-open (`market-open.md:29` carve-out), midday (`midday.md:19`), then EOD couldn't
act. No routine misbehaved; the design put one gate with a ~35% miss rate in front of an
overdue-today time stop.

**➡️ MONDAY 2026-08-10 MARKET-OPEN MUST FIRE THE OVERDUE BMY SELL. This requires no
human decision.** On Monday `target_exit 2026-08-07` is strictly in the *past*; the
market-open carve-out only defers stops due *today*, and both `market-open.md` Step 1 and
`decision.md:20-21` cover an overdue one. Precedent: KMX 06-26 / PENG 07-16 / CCK 07-30 —
all three closed positive, which is luck, not process. This is the fourth time.

Day P&L +0.83% vs the -100% cap — clear, no halt. WTD inside `weekly_loss_cap_pct`, no
flatten. Safety-net stop/target/thesis re-check could not use live quotes (market shut);
the 16:00 close print $64.70 is +0.03% vs entry, nowhere near the ±100% bands — only the
time stop was ever going to fire today.

**LNG (score 8) blocked again — fifth consecutive session the position cap bound**
(08-05 ADM 10, 08-06 ALB 9 / YOU 8 / TAK 7, 08-07 LNG 8). LNG cleared its $267.50 gap
ceiling at $264.06 this morning; sole blocker was `max_concurrent_positions: 1` with BMY
open. Missed time stops extend the blockage — BMY has now consumed the entire book two
sessions past where it should have been released. LNG 7-day scoring runs through
2026-08-14.

**STANDING — third consecutive escalation, still NOT applied, needs a human.**
Items 2 and 3 would have prevented today outright. Out of EOD's mandate to self-apply
(EOD trades and journals; it does not rewrite its own scheduler or routine specs):
1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — absorbs every late start on
   record including today's 10m18s. Highest value, lowest risk.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — it is
   what licenses launchd's deferral.
4. Add a time-stop backstop to `market-open.md` so EOD is not a single point of failure.
