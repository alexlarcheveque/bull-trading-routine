# portfolio.md
# Updated 2026-08-06 08:40 CT by market-open routine.

## Account
- equity: 6908.46
- cash: 186.42
- buying_power: 19567.39
- day_pnl_pct: +1.54  # vs last_equity 6803.94

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -0.07              |

## Notes
2026-08-06 MARKET-OPEN: 0 sells, 0 buys. Market open, trading_blocked=false.

BMY HOLD — no exit rule fired. $64.69 at the open pass = **+0.02% vs entry $64.678846**; it has
since ticked to $64.635 (-0.07%). Reconciled against Alpaca (104 sh, asset_class=us_equity →
shares path). Target +100% / stop -100% (FULL YOLO) both nowhere near. Time stop 2026-08-07 is
NOT due — today is Thursday 08-06, one session left (Fri 08-07) — and time stop is EOD's job,
not market-open's. No options in the book → expiry guard n/a.

Thesis check per Grok: **NOT broken — NONE.** Query explicitly excluded M&A speculation and
analyst actions: no guidance cut, restatement, recall, failed trial, CRL, adverse ruling,
litigation loss, exec departure, or credit downgrade. The only BMY coverage in the window is
continued cleanup of the 08-05 AstraZeneca merger *denial* plus an analyst upgrade — both
excluded by construction. The 07-31 entry thesis (Q2 beat $2.04 vs $1.59 + FY26 guide raise) is
untouched.

**The three-session fade has fully round-tripped.** 08-03 +4.61% → 08-04 +2.13% → 08-05 -1.62%
→ 08-06 open -0.07%. The position is now flat to entry after a full merger-chatter pop-and-repay
cycle. One session to the Friday time stop.

**POSITION CAP BOUND FOR THE THIRD CONSECUTIVE SESSION.** Halt checks:
- daily +1.54% vs -100% cap → CLEAR
- WTD -1.17% vs Friday 07-31 close $6,990.11, cap -100% → CLEAR
- **open positions 1 >= `max_concurrent_positions: 1` → NO NEW ENTRIES. This is the halt that fired.**

Per market-open.md, a fired halt means log the reason, commit, and exit — no entries evaluated.
Today's watchlist had three names clear the >=6 threshold (ALB 9, YOU 8, TAK 7) and all three
were blocked. Cohort now: ADM (08-05), ALB/YOU/TAK (08-06).

**ALB — the cap and the freshness gate agreed, by accident.** ALB was scored novelty 3 on an
after-hours print of $120.12 (+1.08% vs the $118.84 close), i.e. an almost entirely unconsumed
5% band. It **opened at $127.635 = +7.40% vs the 08-05 close and +6.26% above the after-hours
print the score was built on.** Had the slot been free, this routine would have bought a name
whose freshness band was already fully consumed — 7.40% against a 5% bar — because the score
was computed on a stale overnight quote. The position cap blocked a trade the freshness rule
would itself have rejected if it had been measured at the open. **This is a scoring-input
defect, not a cap argument, and the weekly review should treat it separately: novelty must be
re-measured against the opening print, not the after-hours print, before any order is sent.**

Blocked-cohort reference prices marked at this open pass, for the weekly review's 7-day scoring:
**ALB $127.635, YOU $56.41, TAK $17.19.** (Pre-market scoring references were ALB $120.12,
YOU ~$56.75 area, TAK $17.45.) TAK opened $17.19, *below* the $17.45 after-hours print — the
pre-market note's ADR/Tokyo caveat ("the second wave may be arbitraged away before the bell")
called it correctly.

STANDING: BMY time stop lands **tomorrow, Friday 2026-08-07**. The EOD cron has 5 misses to date
and the caffeinate fix in `scripts/run-routine.sh` is STILL uncommitted (joined by untracked
AGENTS.md, .agents/, _raw/, _edited/). If the 08-07 EOD run misses, **Monday 2026-08-10
market-open must fire the overdue BMY sell** (KMX 06-26 / PENG 07-16 / CCK 07-30 precedent — all
three overdue sells landed positive, but that is luck, not process).
