# portfolio.md
# Updated 2026-08-10 16:00 by end-of-day routine.

## Account
- equity: 7392.84
- cash: -26.04
- day_pnl_pct: +6.87  # vs last_equity 6917.30 — settled at the 16:00 ET close

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +6.89              |

## Notes

2026-08-10 eod: **0 exits, 0 time-stops. RDNT held into the close at +6.89%.**

Ran on time and completed — `is_open: true` at 15:55:30 ET, work done, settled snapshot
taken at the 16:00:03 ET close rather than journaling a pre-close mark.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| time stop | exit 2026-08-17 (5 sessions out) | today >= target_exit | no |
| expiry guard | n/a — `asset_class: us_equity` | within 2 trading days | n/a |
| profit target | +6.89% | +100% (`per_trade_target_pct`) | no |
| stop loss | +6.89% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok: **NO NEWS** ×10 classes | concrete named event | no |
| weekly loss cap | WTD +6.87% | -100% (`weekly_loss_cap_pct`) | no |

**Weekly cap: today is Monday, so WTD == day P&L.** Monday's opening equity is Friday's
close ($6,917.30); equity closed $7,392.84 = **+6.87% WTD** against a -100% cap. No flatten,
no `PAUSED` marker.

**Thesis check enumerated 10 disqualifying classes** — guidance cut/withdrawal, CMS/
reimbursement or payor reversal, lawsuit/investigation/short report, restatement or filing
delay, exec departure, offering/dilution, analyst downgrade, breach, halt, recall/facility
closure — with M&A rumor/denials and non-downgrade PT changes explicitly excluded, and
demanded a literal NO NEWS per class. Returned **NO NEWS on all ten**, citing the company IR
release and earnings-reaction coverage; the Q2 call was held today 10:30 ET and produced
nothing disqualifying. Grok 1/1 first-try, 8/8 across the session.

**The +6.89% is a MARK, not a result — the verdict belongs to 2026-08-17.** RDNT went in at
exactly the score-6 threshold with **novelty 1** (a +15.2% six-session run-up into the print,
including +6.2% Friday closing at the session high on 2.8x median volume) and **cleanliness 0**
(GAAP net income halved YoY $0.10 vs $0.19, adj EPS **-14.7% YoY**, cash interest expense guide
**raised** $45-50M → $48-53M against a ~1% guidance bump). Today is the second wave the thesis
explicitly predicted; it is not evidence the quality concerns were wrong. Do not let a green
close become the weekly review's proof that a threshold entry was a good entry.

**🟠 `no_margin` breach persists — cash -$26.04, carried into the overnight.** Unfixable by
EOD for the same structural reason midday cited: `alpaca.sh sell` closes full positions only,
so the only available lever was liquidating a +6.89% position that is 100% of the book to cure
a $26 overdraft. Third routine in a row to log it without a fix. **Second overrun of the 98%
haircut by a near-identical fill: PENG 07-08 +2.6%, RDNT today +2.58%** — the rule was derived
*from* PENG and sized to exactly the move that caused it, so it has zero margin against a repeat.

**Tonight is the exact shape of the failure this morning cleaned up.** RDNT is 100% of equity
with a live time stop from here on. The BMY overdue stop sold at today's open existed only
because the 08-07 EOD fired 5 minutes *after* the close and could not act — then carried a
three-day weekend at 97.3% of equity. EOD has now failed 21 of 60 runs (~35%). This run
completing does not retire that risk; it postpones it by one session.

**STANDING — 7th consecutive escalation, still NOT applied, all need a human:**
1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, along with
   untracked AGENTS.md, .agents/, _raw/, _edited/, .env.bak.broken,
   memory/guardrails.md.conservative.bak).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest value, absorbs every late
   start on record including the 08-07 10m18s deferral.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key is
   what licenses the deferral.
4. Add the time-stop backstop line to `routines/market-open.md`. strategy.md documents the
   overdue carve-out; market-open.md still says time stops are "enforced in end-of-day, not
   here." The two files contradict each other and today's sell worked only because strategy.md
   was read first.
5. `alpaca.sh` lacks limit-order support (MRK 07-21 no-bid) and any partial-close path (why
   the -$26.04 cannot be cured intraday).
6. **Widen the entry haircut 98% → 96%, or size on the ask.** At 96%: 94 sh = $6,796, leaving
   ~$118 cash instead of -$26.04.
