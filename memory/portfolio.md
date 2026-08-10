# portfolio.md
# Updated 2026-08-10 09:05 by midday routine.

## Account
- equity: 7333.32
- cash: -26.04
- day_pnl_pct: +6.01  # vs last_equity 6917.30 — a MARK, not realized P&L

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +6.03              |

## Notes

2026-08-10 midday: **0 exits. RDNT held.** Last $76.68 vs entry $72.30 = **+6.06%**, inside
the ±100% FULL YOLO band on both sides, so neither the target nor the stop is live — at these
thresholds price alone can essentially never trigger a midday exit; thesis is the only real
midday gate. Grok returned an explicit **NO NEWS** against the enumerated disqualifying classes
(guidance cut, recall, lawsuit, CMS/reimbursement reversal, exec departure, restatement,
dilution, downgrade, breach, halt), with coverage still pointing at Sunday's Q2 beat. No sell.

Day P&L **+6.01%** vs the -100% daily cap — no halt, nothing to log. `trading_blocked: false`.
`max_new_positions_per_day: 1` was consumed by RDNT at the open; midday never opens anyway.

**The +6.06% is a mark, not a result** — RDNT is 100% of the book and 4 sessions from its
2026-08-17 time stop. Worth noting the entry thesis explicitly priced this move as *already
partly consumed*: score 6 came with novelty 1 on a +15.2% six-session run-up, and cleanliness
0 (adj EPS -14.7% YoY, interest-expense guide raised). Today's move is the second wave the
thesis called for; it is not evidence the quality concerns were wrong.

**🟠 `no_margin` breach unchanged — cash still -$26.04.** Not fixable at midday: `alpaca.sh
sell` closes full positions only, and selling RDNT outright to cure a $26 overdraft would
liquidate a +6% winner over a rounding error. Stays queued for weekly review (widen the entry
haircut 98% → 96%, or size on the ask). Unchanged from the market-open entry below.

2026-08-10 market-open: **1 sell, 1 buy. The overdue BMY stop fired as required.**

**✅ BMY OVERDUE TIME STOP CLEARED.** 104 shares sold @ $64.695577 avg, ret **+0.03%**
vs entry $64.678846 (realized **+$1.74**). `target_exit 2026-08-07` was strictly in the
past, so the market-open carve-out did not apply and no human decision was needed —
exactly as the 08-07 EOD note and today's pre-market note both directed. 4th instance
after KMX 06-26 / PENG 07-16 / CCK 07-30; all four closed positive, still luck rather
than process. The three-day-weekend exposure at 97.3% of equity ended flat.

**Open-print data outage delayed the sell ~3.3 minutes.** At 09:30:15 ET both BMY and
RDNT returned Friday's 15:59:59 close print as the latest trade. The sell was submitted
09:31:08 into that gap and sat `new` through 30 polls; the feed caught up ~09:32:25 and
the order drip-filled 58 → 104, completing 09:35:19. Worth noting the routine's bounded
10-poll/30s fill loop would have abandoned this order as "unfilled" had it not been the
gating trade — the extended poll was a judgment call, not spec.

**RDNT entered at threshold — gap check passed on the decisive test.** Score 6 = entry
threshold exactly. The pre-market note made the open print decisive: >= $75.87 (+5% over
the $72.26 reference) would have consumed the freshness band, dropped novelty to 0 and
killed the trade. RDNT opened ~$73.11 and was **$71.78 (-0.66%)** at the size step —
nowhere near the ceiling, so the score held. Call path was ineligible: `option-chain RDNT
call` returned **0 contracts** at runtime (not just 0 in the 3-7 DTE window), so shares.

**🟠 `no_margin` BREACH — cash is -$26.04.** Sized 96 shares against a $70.48 quote using
the 98% haircut ($6,766 notional vs $6,914.76 equity), but the market order filled at
**$72.30 = +2.58% above the sizing quote**, for $6,940.80 — $26.04 more cash than existed.
**This is the second time the 2% haircut has been overrun by an opening fill on a gapping
catalyst name, and the two are near-identical: PENG 2026-07-08 filled +2.6%, today +2.58%.**
The haircut rule (strategy.md, added 07-10 weekly review) was written *from* the PENG
incident and sized to exactly the move that caused it, leaving no margin for a repeat.

Not corrected intra-session, following PENG precedent (logged, fixed at weekly review):
`alpaca.sh sell` closes full positions only — there is no partial-sell path, and trimming
1 share would have meant adding one mid-routine. Flagged for the human instead:

- **Widen the entry haircut 98% → 96%** (or size on the ask, not the last trade). A 2%
  buffer against a fill distribution whose two observed tail events are +2.58% and +2.6%
  is not a buffer. 96% would have sized 94 shares = $6,796 and left ~$118 cash.

Halt checks all clear at entry time: day P&L -0.04% vs the -100% cap, 0 open positions
after the BMY exit vs `max_concurrent_positions: 1`, fresh week so no WTD cap pressure,
`trading_blocked: false`. `max_new_positions_per_day: 1` consumed by RDNT.

**STANDING — fourth consecutive escalation, still NOT applied, needs a human.** Today
consumed the BMY overdue stop that items 2-4 exist to prevent, but nothing was fixed:
1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — absorbs every late start on record.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist`.
4. Add a time-stop backstop to `market-open.md` so EOD is not a single point of failure.
   (Today this worked *because strategy.md documents the overdue carve-out* — market-open.md
   itself still says time stops are "enforced in end-of-day, not here." The two files
   disagree; the routine spec should be brought in line.)
