# portfolio.md
# Updated 2026-08-05 11:10 CT by midday routine.

## Account
- equity: 6820.58
- cash: 186.42
- buying_power: 19492.84
- day_pnl_pct: -3.10  # vs last_equity 7038.98

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -1.37              |

## Notes
2026-08-05 MIDDAY: 0 exits. BMY reconciled against Alpaca (104 sh, asset_class=us_equity → shares
path). $63.79 = -1.37% vs entry $64.678846. Target +100% / stop -100% (FULL YOLO) both nowhere
near. Time stop 2026-08-07 is EOD's job, not midday's, and is not due anyway.

Thesis check per Grok: NOT broken. The only BMY coverage in the last 6h is continued cleanup of the
AstraZeneca merger denial ("There is no deal... there never was a deal to be done, and there are no
discussions"). No guidance cut, recall, lawsuit, regulatory reversal, or exec departure. This is the
same non-thesis item the market-open note already dispositioned: the merger chatter started 08-02,
two sessions AFTER our 07-31 entry on the Q2 beat ($2.04 vs $1.59) + FY26 guide raise, so its
removal deflates a premium we never underwrote. Per the hard rule, "uncertain" is not a sell —
only concrete named negative news is, and there is none.

Drift note: the position gave back another ~0.9pt since the 08:40 open pass (-0.47% → -1.37%) and
equity is now $6,820.58, WTD -2.43% vs Friday 07-31 close $6,990.11. Still a slow bleed, not a
break. Halt checks CLEAR: daily -3.10% vs -100% cap; no cancel-all, no notify, no halt marker.

2026-08-05 MARKET-OPEN: 0 sells, 0 buys. Market open, trading_blocked=false.

BMY HOLD — no exit rule fired. $64.375 = -0.47% vs entry $64.678846. Target +100% / stop -100%
both nowhere near. Time stop 2026-08-07 is NOT due (today 08-05, 2 sessions left). Thesis check
per Grok: no material negative news on BMY fundamentals in the last 24h.

**THE WATCH CONDITION RESOLVED — the second branch, not the first.** On 2026-08-05 a senior
source told Reuters there are "no discussions" between AstraZeneca and BMY: "There is no deal
between AstraZeneca and BMS. There never was a deal to be done." The FT 08-02 ~$400B tie-up
report and the Reuters 08-03 confirmation are now explicitly denied. So the ATKR cash-deal-ceiling
logic never applied — there was never a firm offer, a price, or a structure. The chatter died,
exactly the downside branch the 08-04 EOD note flagged.

Why this is NOT "thesis broken" (rule 3): our 07-31 entry thesis was the Q2 beat ($2.04 vs $1.59)
plus the FY26 guide raise (rev $49-50B, EPS $6.75-7.00). The merger speculation started 08-02 —
two sessions AFTER we bought — so it was never part of the thesis. Its removal is not a hit to
forward cash flows; it just deflates a premium we never underwrote. The 08-04 note called the
+2.13% "borrowed" and it has now been repaid: the position sits at -0.47%, essentially back to
entry. Fundamentals intact → HOLD to the Friday time stop.

**ADM (score 10) BLOCKED — position cap, not a research failure.** Today's pre-market watchlist
produced the highest score this book has ever recorded: ADM at 10/10 (Q2 adj EPS $1.84 vs $1.44
+27.8%, FY26 EPS guide raised to $5.15-5.60 from $4.15-4.70, a second raise; novelty 3 with only
+3.43% priced in; confirmation 2 on 1.40x ADV; cleanliness 1). It was NOT entered because
`max_concurrent_positions: 1` and BMY occupies the only slot. Entry rules do not permit rotating
out of a position that has not triggered an exit condition — opportunity cost is not one of the
four exit rules (stop / target / thesis / time stop). Per decision.md ("if anything is ambiguous,
do nothing and log the ambiguity"), we held and logged.

Halt checks all CLEAR (and none would have mattered — the position cap bound first):
daily -2.23% vs -100% cap; WTD -1.55% vs Friday 07-31 close $6,990.11, cap -100%.

STANDING: BMY time stop lands Friday 2026-08-07. The EOD cron has 5 misses to date and the
caffeinate fix in `scripts/run-routine.sh` is STILL uncommitted (now also joined by untracked
AGENTS.md, .agents/, _raw/, _edited/). If the 08-07 EOD run misses, Monday 2026-08-10 market-open
must fire the overdue sell (KMX 06-26 / PENG 07-16 / CCK 07-30 precedent — all three overdue
sells still landed positive, but that is luck, not process).

FOR THE WEEKLY REVIEW — the real finding of this session: a 10-score candidate was blocked by a
flat, decaying position that had 2 sessions left on its clock. `max_concurrent_positions: 1` is
the binding constraint on this book, and it is the one guardrail still set to a value that
contradicts "FULL YOLO" everywhere else in guardrails.md (every other knob is 100). Worth deciding
deliberately: either (a) raise the cap so a top-decile catalyst is never blocked by a stale
position, or (b) add an explicit, bounded rotation rule to strategy.md's exit list — e.g. allow
exit when a watchlist name outscores the open position by >= N AND the open position is within M
sessions of its time stop AND is flat-to-red. Today ADM(10) vs BMY(7-at-entry, -0.47%, 2 sessions
left) would have cleared both. Do NOT bolt this on mid-week — it is an exit-rule change and
belongs in the weekly review with the ATKR/MRK precedent set in view.
