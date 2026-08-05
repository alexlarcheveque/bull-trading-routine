# portfolio.md
# Updated 2026-08-05 15:05 CT by end-of-day routine.

## Account
- equity: 6804.46
- cash: 186.42
- buying_power: 19311.14
- day_pnl_pct: -3.33  # vs last_equity 7038.98

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -1.62              |

## Notes
2026-08-05 EOD: 0 exits, 0 time-stops. Equity $6,804.46, day -3.33%, all-time -93.20% vs $100k start.

BMY HOLD. Closed $63.63 = -1.62% vs entry $64.678846. Time stop 2026-08-07 NOT due — today is
Wednesday 08-05, two sessions left (Thu 08-06, Fri 08-07). No options in the book → expiry guard
n/a. Safety-net re-check of the midday rules: target +100% no, stop -100% no, thesis INTACT per
Grok (8h window, explicitly excluding M&A speculation/denial and analyst actions — no guidance cut,
restatement, recall, failed trial, CRL, adverse ruling, litigation loss, exec departure, or credit
downgrade).

Third straight fade: $64.375 at the open (-0.47%) → $63.63 at the close (-1.62%). Both the 08-03
(+4.61%) and 08-04 (+2.13%) merger-chatter pops are now fully repaid and the position sits below
entry. Slow bleed, not a break — the 07-31 entry thesis (Q2 beat $2.04 vs $1.59 + FY26 guide raise)
is untouched.

Weekly loss cap: WTD -2.66% vs Friday 07-31 close $6,990.11, cap -100% → CLEAR. No flatten, no
PAUSED marker.

**ADM POSTSCRIPT — the position cap was worth +5.19% today.** ADM opened $81.85 and closed $77.60
= -5.19% intraday. The score-10 candidate that `max_concurrent_positions: 1` blocked this morning
would be down ~5.2% tonight. This morning's note called the cap "the binding constraint on the
entire book" and asked the weekly review to raise it or add a rotation rule; today's tape argues
the other side. One session is not evidence either way, but the weekly review must see both halves
of the question, not just the open note's framing.

**FRESHNESS GATE — 4 DQs today, all 4 SAVES** (scored vs the pre-market price we refused to pay):
ANET $219.49 → $197.13 = -10.19% SAVE (large); INSP $63.63 → $60.11 = -5.53% SAVE; PLTR $160.11 →
$158.47 = -1.02% SAVE; CAT $879.78 → $871.66 = -0.92% SAVE. Running record ≈ 5 misses / 10 saves.
ANET was logged this morning as "a direct re-run" of the PLTR case that embarrassed the gate on
08-04 (+11.37% after DQ) and it ran the opposite way by 10 points. PLTR itself is the caution:
DQ'd 08-04 at $145.87 → closed $162.46 (MISS), DQ'd again 08-05 at $160.11 → closed $158.47 (SAVE).
Same name, same gate, opposite verdicts on consecutive days — weight the cohort, not the anecdote,
including yesterday's anecdote that drove yesterday's recommendation.

EOD email sent (Resend e95a163d). EOD cron RAN on time.

STANDING: BMY time stop lands Friday 2026-08-07. The EOD cron has 5 misses to date and the
caffeinate fix in `scripts/run-routine.sh` is STILL uncommitted (joined by untracked AGENTS.md,
.agents/, _raw/, _edited/). If the 08-07 EOD run misses, Monday 2026-08-10 market-open must fire
the overdue sell (KMX 06-26 / PENG 07-16 / CCK 07-30 precedent — all three overdue sells landed
positive, but that is luck, not process).

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
