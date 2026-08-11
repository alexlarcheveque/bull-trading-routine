# portfolio.md
# Updated 2026-08-11 08:48 CT by market-open routine.

## Account
- equity: 7354.26
- cash: -26.22
- buying_power: 20560.46
- day_pnl_pct: -0.52  # vs last_equity 7392.66

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +6.34              |

## Notes

2026-08-11 market-open: **0 exits, 0 entries.** No orders sent, so no preflight was invoked
and `memory/trade-log.md` is unchanged.

Ran late — `is_open: true` at **09:47 ET, 17 minutes after the 09:30 open**. Nothing was
time-sensitive today (no exit fired, no entry was permitted), so the lateness cost nothing —
but it would have mattered on a day with an overdue time stop, and it is the same class of
launchd deferral as the standing EOD escalation.

### Exit gates — RDNT (the only position)

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| time stop | exit 2026-08-17 (4 sessions out) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |
| expiry guard | n/a — `asset_class: us_equity` | within 2 trading days | n/a |
| profit target | +6.34% | +100% (`per_trade_target_pct`) | no |
| stop loss | +6.34% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok: **NO NEWS** ×10 classes | concrete named event | no |

Thesis check re-ran yesterday's 10-class enumeration (guidance cut, CMS/payor reversal,
lawsuit/investigation/short report, restatement or late filing, exec departure, offering/
dilution, analyst downgrade, breach, halt, closure/recall/FDA), with M&A rumor-or-denial and
non-downgrade PT changes explicitly excluded and a literal `NO NEWS` demanded per class.
**All ten returned NO NEWS.** Grok 1/1 first-try.

### Entry gates — blocked twice over, independently

| gate | value | threshold | blocks? |
|------|-------|-----------|---------|
| `max_concurrent_positions` | 1 open (RDNT) | 1 | **yes** |
| watchlist top score | 5 (NVDA) | >= 6 (strategy.md) | **yes** |
| `max_new_positions_per_day` | 0 used | 1 | no |
| daily loss cap | -0.52% | -100% (`daily_loss_cap_pct`) | no |
| weekly loss cap | +6.01% WTD | -100% (`weekly_loss_cap_pct`) | no |

Two independent blocks, which is worth stating precisely: **pre-market already concluded
nothing qualified**, so the capacity cap cost us nothing today. NVDA scored 5 on a 0/2
confirmation — the tape had a full session to price the $500B financing headline and sold it
(-2.88% on ~1.14x volume). Sitting out on the axis where the market disagreed with the
catalyst is the rubric working, not the rubric being timid. Had a 6+ appeared, `max_concurrent_positions: 1`
would have forced a real choice between skipping it and liquidating RDNT early — that cost
remains live and unpaid, not retired.

**WTD is +6.01% against Monday's opening equity ($6,917.30), not a realized result.** RDNT is
100% of the book and its verdict belongs to 2026-08-17. The mark has now been green in three
consecutive journals; it is still the same at-threshold entry (score 6, **novelty 1**,
**cleanliness 0** — adj EPS -14.7% YoY, cash interest expense guide raised). Do not let
accumulated green marks retroactively validate the entry.

### 🟠 `no_margin` still breached — cash -$26.22, 5th consecutive routine

Unchanged from pre-market (-$26.22) because no orders were sent. Structurally uncurable by any
routine while `alpaca.sh sell` closes full positions only and the only position is 100% of
equity: the sole lever is liquidating a +6.34% winner to cure a $26 overdraft. Needs the
partial-close path (escalation #5) or the wider entry haircut (#6).

### Ops carry-forward — 9th consecutive escalation, still unapplied

Market-open can apply none of these; re-listed so the count stays honest.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist`.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the
   two files still contradict each other. **Today this routine again resolved it by reading
   strategy.md first**; the contradiction has now survived four overdue-stop precedents.
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions — logged 08-10, near-missed a raw-7 ACHR entry
   08-11. Fix the script **and** the Step 3 instruction in `routines/pre-market.md`.
