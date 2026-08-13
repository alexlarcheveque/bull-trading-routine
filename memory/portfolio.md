# portfolio.md
# Updated 2026-08-13 11:02 CT (12:02 ET) by midday routine.

## Account
- equity: 7334.58
- cash: -26.22
- buying_power: 20501.33
- day_pnl_pct: -0.36  # vs last_equity 7360.98

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +6.02              |

## Notes

2026-08-13 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. RDNT marked 76.65 vs 72.30 entry = **+6.02%**, down from +7.03% at the 09:31 ET
market-open mark. Market value $7,360.80 on $7,334.58 equity — still **100.4% of the book**.

### 🟢 RUN QUALITY: ON TIME — clock read 12:02:06 ET, ~2 min after the 12:00 ET trigger

Confirms **escalation #8 empirically**: the live plist fires 09:00 PDT = **12:00 ET / 11:00 CT**,
not the `0 12 * * 1-5 (12:00 PM Central / 1:00 PM Eastern)` claimed in `routines/midday.md:1`.
The header is the wrong artifact — do NOT move the plist to match it.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +6.02% | +100% (`per_trade_target_pct`) | no |
| stop loss | +6.02% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |

Instrument detected live off Alpaca `asset_class: us_equity` — shares path, `quote`/`sell`.
Time stop (08-17) and expiry guard are end-of-day's, not midday's; neither is due today.

Same 10-class enumeration as 08-11/08-12/08-13-open (guidance cut, recall, litigation,
CMS/regulatory adverse decision, exec departure, rating **downgrade only**, restatement,
dilution/offering, short report, contract/payer-network loss), demanding a literal `NO NEWS`
per class. All ten clean, **Grok 1/1 first-try**. At ±100% the price gates are unreachable, so
thesis-broken remains the **only exit gate that can fire** before the 08-17 time stop.

### Step 2 — daily loss cap: not hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-0.36%** | -100% (`daily_loss_cap_pct`) | none |

No `cancel-all`, no `notify.sh` alert, no halt marker written to `memory/research-log.md`.
Weekly P&L **+6.03%** (vs Mon 08-10 open $6,917.30) — logged for continuity, not a midday gate.
The cap is decorative at 100%; the binding constraint remains `max_concurrent_positions: 1`,
which market-open already enforced this morning. No slot opens before **08-17**.

Intraday give-back since the open: equity $7,402.26 → $7,334.58 (**-$67.68**), entirely RDNT
mark-to-market (77.38 → 76.65). Nothing actionable — 106 points of stop headroom remain.

### 🟠 `no_margin` still breached — cash -$26.22, 13th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+6.02% winner to cure a $26 overdraft. Needs the partial-close path (escalation #5) or the wider
entry haircut (#6).

### Ops carry-forward — 16th consecutive escalation, still unapplied

Midday can apply none of these (exits and notifications only). Re-listed so the count stays
honest. Nothing new today; **#8 is now live-confirmed** rather than inferred.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change. **RDNT's
   08-17 time stop is EOD's to enforce**, it is 100% of equity, and EOD has missed 21 of 60 runs.
   08-17 is a Monday: the first EOD of next week, the exact shape of the 08-07 failure that forced
   the 08-10 BMY cleanup at market-open.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key licenses
   the deferral that produces the 3-4 minute late starts.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live on 08-18 if EOD misses 08-17.**
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. Characterized with a root cause on 08-13 pre-market.
8. **`routines/midday.md:1` header is wrong by an hour** — **confirmed live this run** (fired
   12:02 ET, header claims 1:00 PM ET). Docs-only fix — do NOT "correct" the plist to match.

---

2026-08-13 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked,
`memory/trade-log.md` unchanged. RDNT marked 77.38 vs 72.30 entry = **+7.03%**, up from
+6.42% at last night's close. Market value $7,428.48 on $7,402.26 equity — the position is
**100.4% of the book**.

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:16 ET, 16 seconds after the bell

**Third consecutive on-time market-open** (08-11, 08-12, 08-13), against two consecutive
degraded EODs. The split is now 3–2 in the same week and points at the same one-line fix:
the market-open plist behaves, the EOD plist defers. Escalations #2/#3 stay at the top.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +7.03% | +100% (`per_trade_target_pct`) | no |
| stop loss | +7.03% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |
| time stop | exit 2026-08-17 (2 sessions out) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |

Instrument detected live off Alpaca `asset_class: us_equity`, not off this file — shares path,
`quote`/`sell`, no expiry guard applicable.

Same 10-class enumeration as 08-11/08-12 (guidance cut, recall, litigation, CMS/regulatory
adverse decision, exec departure, rating **downgrade only**, restatement, dilution/offering,
short report, contract/payer-network loss), demanding a literal `NO NEWS` per class. All ten
clean, **Grok 1/1 first-try**. At ±100% the price gates are unreachable, so this remains the
**only exit gate that can actually fire** before the 08-17 time stop.

### Step 2 — halt checks: capacity cap fired

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| daily P&L | **+0.56%** | -100% (`daily_loss_cap_pct`) | no |
| weekly P&L | **+7.01%** (vs Mon 08-10 open $6,917.30) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **1** | 1 (`max_concurrent_positions`) | **YES** |

Both loss caps are decorative at 100% — only a near-total wipeout reaches them. The **capacity
cap is the binding constraint** and it halted entries on its own.

### Step 3 — entries: none, and blocked twice over

Pre-market scored **0 tradeable candidates against a threshold of 6** (top score 5, shared by
CRWV/SMCI/NBIS/HLIT/HRB/CAVA — all rejected on **novelty**, their moves spent on 08-12). So
today the threshold and the cap **both** said no, independently.

**Fifth consecutive session** of that agreement, and — as logged on 08-10 through 08-12 — it is
still **coincidence, not vindication**. The cap has not been tested by a qualifying name since
it was set. Its cost stays unpaid, not retired. No slot opens before **08-17**.

### 🟠 `no_margin` still breached — cash -$26.22, 12th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+7.03% winner to cure a $26 overdraft. Needs the partial-close path (escalation #5) or the wider
entry haircut (#6).

### Ops carry-forward — 15th consecutive escalation, still unapplied

Market-open can apply none of these; re-listed so the count stays honest. Nothing new today.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change. **RDNT's
   08-17 time stop is EOD's to enforce**, it is 100% of equity, and EOD has missed 21 of 60 runs.
   08-17 is a Monday: the first EOD of next week, the exact shape of the 08-07 failure that forced
   the 08-10 BMY cleanup at market-open.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key licenses
   the deferral that produces the 3-4 minute late starts.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live on 08-18 if EOD misses 08-17.**
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. Characterized with a root cause on 08-13 pre-market.
8. **`routines/midday.md:1` header is wrong by an hour.** It claims `0 12 * * 1-5 (12:00 PM
   Central / 1:00 PM Eastern)`; the live plist fires 09:00 PDT = **12:00 ET / 11:00 CT**. Docs-only
   fix — do NOT "correct" the plist to match the comment, the plist is the right one.
