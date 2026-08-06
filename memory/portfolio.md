# portfolio.md
# Updated 2026-08-06 13:05 PDT by end-of-day routine (DEGRADED — see notes).

## Account
- equity: 6858.02
- cash: 186.42
- buying_power: 19426.16
- day_pnl_pct: +0.79  # vs last_equity 6803.94

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -0.82              |

## Notes
2026-08-06 EOD: **DEGRADED RUN — no enforcement pass executed.** 0 exits, 0 time-stops.

launchd fired end-of-day at **13:00:33 PDT** instead of the scheduled 12:55. The market
closed at 13:00:00 PDT, so `clock.is_open` was already `false` and the routine's bail-out
tripped 33 seconds too late. Time stop, expiry guard, and the stop/target/thesis safety net
all skipped.

**Nothing was lost today.** No exit was due: BMY's time stop is 08-07 (tomorrow, not today),
no options are held so the expiry guard is n/a, -0.82% is nowhere near the -100% stop /
+100% target, and midday confirmed the thesis intact. Weekly cap clear: WTD -1.89% vs the
07-31 close $6,990.11, cap 100%.

BMY closed **$64.15 vs entry $64.678846 = -0.82%**, recovering from the -1.77% midday mark.
Day P&L is **+0.79%** (equity $6,858.02 vs last_equity $6,803.94) — the position marked back
up into the close. Six sessions held, thesis (Q2 beat $2.04 vs $1.59 + FY26 guide raise)
untouched.

**STANDING — CORRECTED ROOT CAUSE.** The prior note blamed the uncommitted `caffeinate` fix
for the EOD misses. That is only half right, and the half it gets wrong is the half that hit
today. Full log audit, 59 EOD runs, **20 failures (~34%)**, two distinct modes:

- **Late start past close (11 runs):** 06-26, 06-29, 06-30, 07-01, 07-07, 07-08, 07-20,
  07-23, 07-24, 07-30, 08-06. launchd defers the 12:55 job; anything past 13:00:00 PDT lands
  after the close and force-bails. **`caffeinate` does NOT fix this mode** — it only holds the
  machine awake *during* a run, it cannot make launchd fire on time.
- **Died mid-run (9 runs):** 05-14, 05-18, 05-29, 06-11, 06-25, 07-02, 07-03, 07-13, 07-15.
  Started on time, no END line — process killed when the machine slept. **This is the mode
  `caffeinate -is` actually fixes**, and it is the mode behind all three overdue sells
  (06-25→KMX 06-26, 07-15→PENG 07-16, 07-29→CCK 07-30).

**EOD is a single point of failure for the time stop** — `routines/market-open.md:29` and
`routines/midday.md:23` both explicitly defer time stop + expiry guard to EOD. A ~34% miss
rate on the only routine that enforces exits is the standing structural risk in this system.

**TOMORROW 2026-08-07 IS BMY'S TIME-STOP DAY.** Both failure modes are live. If the 08-07 EOD
run misses, **Monday 2026-08-10 market-open must fire the overdue BMY sell** (KMX/PENG/CCK
precedent — all three landed positive, but that is luck, not process).

Recommended (NOT applied — outside EOD's remit, needs a human):
1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted).
2. Move EOD earlier in `~/Library/LaunchAgents/com.bull-trading.end-of-day.plist` — 12:55
   gives a 5-minute buffer; 12:40 would have absorbed all 11 late starts.
3. Drop `ProcessType Background` from that plist (invites launchd throttling/deferral).
4. Add a time-stop backstop to market-open.md so EOD stops being a single point of failure.
