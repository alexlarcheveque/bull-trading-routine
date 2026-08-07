# portfolio.md
# Updated 2026-08-07 11:08 CT by midday routine.

## Account
- equity: 6874.66
- cash: 186.42
- buying_power: 19349.72
- day_pnl_pct: +0.24  # vs last_equity 6858.02

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -0.60              |

## Notes
2026-08-07 midday: **0 exits.** BMY $64.29 (live 16:07:39Z print) vs entry $64.678846 =
**-0.60%** — nowhere near the +/-100% FULL YOLO bands. Grok 6h scan found no concrete negative
news; the only BMY-adjacent item is *positive* (Replimune RP1 won FDA accelerated approval
08-06 in combination with BMY's Opdivo). Thesis intact → hold. Day P&L **+0.24%** vs the
-100% daily cap — clear, no halt. No unfilled orders outstanding.

**⚠️ BMY'S TIME STOP IS STILL DUE TODAY AND MIDDAY DID NOT FIRE IT** — `routines/midday.md:19`
and `strategy.md:121-122` both scope the time stop to end-of-day. Midday held to its mandate.
That leaves today's EOD run as the *only* remaining gate before the weekend. See research-log.

2026-08-07 market-open: **0 buys, 0 sells.** Market open and healthy (`trading_blocked: false`).

**BMY held — no exit rule fired at market-open.** -1.22% is nowhere near the +/-100% FULL YOLO
bands. Thesis intact: Grok's only 24h negative is an Aug 6 report that BMY and AstraZeneca are
*not* in merger talks (debunking an Aug 3 rumor). We never underwrote that merger — the entry
thesis is the 07-30 Q2 beat ($2.04 vs $1.59) + FY26 guide raise, which is untouched.

**⚠️ BMY'S TIME STOP IS DUE TODAY (target_exit 2026-08-07) AND MARKET-OPEN DID NOT FIRE IT.**
`routines/market-open.md:29` explicitly carves the time stop out ("enforced in end-of-day, not
here"), and `strategy.md:122` agrees; only `decision.md:21` includes it in the market-open step.
Given the conflict, market-open followed decision.md's own tiebreaker — do nothing, log the
ambiguity for the weekly review — rather than unilaterally applying recommendation #4 from the
08-06 EOD note, which that note marked "NOT applied, needs a human."

**TODAY'S EOD RUN IS THE ONLY THING STANDING BETWEEN BMY AND A WEEKEND OF UNMANAGED DRIFT.**
EOD has failed **20 of 59 runs (~34%)**, in two modes (late start past close; died mid-run).
Today is **Friday** — a miss costs three calendar days, not one. **If the 08-07 EOD run misses,
Monday 2026-08-10 market-open must fire the overdue BMY sell** (KMX 06-26 / PENG 07-16 /
CCK 07-30 precedent).

**LNG (score 8) passed its freshness re-check and was still not bought.** It opened **$264.06**
vs the hard gap ceiling **$267.50** — band consumed +3.65% against the 5% bar, ~1.35pp of
headroom. Pre-market had flagged that ceiling as the most likely way the candidate would die;
it cleared. The sole blocker was **`max_concurrent_positions: 1` with BMY still open.**
(The first two quote polls returned a stale Aug 6 close print of $265.41 — the ALB 08-06
discipline held and we re-polled to a genuine 08-07 timestamp before scoring.)

**Fifth consecutive session where a >= 6 candidate was produced and the position cap bound:**
08-05 ADM 10, 08-06 ALB 9 / YOU 8 / TAK 7, 08-07 LNG 8. Research is generating qualifying
candidates faster than a 1-position book absorbs them, and EOD's ~34% miss rate compounds it by
holding names past their time stop. This deserves a real verdict at the weekly review, not
another line in the blocked cohort.

**STANDING (unchanged from 08-06 EOD, still NOT applied — needs a human):**
1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted).
2. Move EOD earlier in `~/Library/LaunchAgents/com.bull-trading.end-of-day.plist` — 12:55 gives
   a 5-minute buffer; 12:40 would have absorbed all 11 late starts.
3. Drop `ProcessType Background` from that plist (invites launchd throttling/deferral).
4. Add a time-stop backstop to market-open.md so EOD stops being a single point of failure —
   today is precisely the scenario that motivates it.
