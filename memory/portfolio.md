# portfolio.md
# Updated 2026-08-06 11:10 CT by midday routine.

## Account
- equity: 6797.70
- cash: 186.42
- buying_power: 19567.39
- day_pnl_pct: -0.09  # vs last_equity 6803.94

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -1.77              |

## Notes
2026-08-06 MIDDAY: 0 exits. Market open, 0 open orders.

BMY HOLD — no exit rule fired. $63.535 vs entry $64.678846 = **-1.77%**. Reconciled against
Alpaca (104 sh, `asset_class=us_equity` → shares path; market_value $6,609.20, unrealized
-$117.40). Stop -100% / target +100% (FULL YOLO) both nowhere near — a -1.77% drawdown is
1.8% of the way to a stop that only fires on a total wipeout.

Thesis check per Grok: **NOT broken — NONE.** The query named the disqualifying events
explicitly (guidance cut, restatement, recall, failed trial, FDA CRL, adverse ruling, litigation
loss, exec departure, credit downgrade, halt) and excluded M&A speculation/denials and analyst
actions by construction. Grok found nothing concrete in the 6-hour window; the only BMY coverage
is a MarketScreener piece re-confirming there are **no** AstraZeneca discussions and a MarketBeat
consensus-rating note — both excluded categories. The 07-31 entry thesis (Q2 beat $2.04 vs $1.59
+ FY26 guide raise) is untouched for the sixth consecutive session.

**The round-trip continued lower, but slowly.** 08-03 +4.61% → 08-04 +2.13% → 08-05 -1.62% →
08-06 open -0.07% → midday **-1.77%**. Intraday the name is -0.15% vs the $63.63 prior close,
so today's loss is a drift, not a break. The merger-chatter pop from early week is now fully
repaid and then some.

**Equity fell $110.76 from the 08:40 open pass ($6,908.46 → $6,797.70) with no trades.** That
is entirely BMY marking down — the open pass captured a $64.69 print, midday is $63.535 on the
same 104 shares. Day P&L is only -0.09% because `last_equity` ($6,803.94) is the 08-05 close,
not this morning's intraday high-water mark. Worth stating plainly: the +1.54% "day" figure in
the open-pass note was a transient mark, not a gain the book ever locked.

Halt checks, all clear:
- daily -0.09% vs `daily_loss_cap_pct: 100` → CLEAR (not remotely close)
- WTD -2.75% vs Friday 07-31 close $6,990.11, `weekly_loss_cap_pct: 100` → CLEAR
- 0 open orders → nothing to cancel

No options in the book → expiry guard n/a. Time stop and expiry guard are EOD's job; midday does
not evaluate them.

**STANDING — this is the operative risk, not the -1.77%.** BMY's time stop lands **tomorrow,
Friday 2026-08-07**. The EOD cron has 5 misses to date and the caffeinate fix in
`scripts/run-routine.sh` is STILL uncommitted (alongside untracked AGENTS.md, .agents/, _raw/,
_edited/, .env.bak.broken, memory/guardrails.md.conservative.bak). If the 08-07 EOD run misses,
**Monday 2026-08-10 market-open must fire the overdue BMY sell** (KMX 06-26 / PENG 07-16 /
CCK 07-30 precedent — all three overdue sells landed positive, but that is luck, not process).
