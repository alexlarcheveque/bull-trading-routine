# portfolio.md
# Updated 2026-08-14 11:03 CT (12:03 ET) by midday routine.

## Account
- equity: 7422.42
- cash: -26.22
- buying_power: 20751.31
- day_pnl_pct: +0.36  # vs last_equity 7395.54

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +7.32              |

## Notes

2026-08-14 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. RDNT marked 77.59 vs 72.30 entry = **+7.32%**, up from +6.90% at the 09:31 ET
market-open mark. Market value $7,448.64 on $7,422.42 equity — still **100.4% of the book**.

### 🟢 RUN QUALITY: ON TIME — clock read 12:03:09 ET, ~3 min after the 12:00 ET trigger

Second consecutive live confirmation of **escalation #8**: the plist fires 09:00 PDT =
**12:00 ET / 11:00 CT**, not the `12:00 PM Central / 1:00 PM Eastern` claimed in
`routines/midday.md:1`. The header is the wrong artifact — do NOT move the plist to match it.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +7.32% | +100% (`per_trade_target_pct`) | no |
| stop loss | +7.32% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |

Instrument detected live off Alpaca `asset_class: us_equity` — shares path, `quote`/`sell`.
Time stop (08-17) and expiry guard are end-of-day's, not midday's; neither is due today.

Same 10-class enumeration as 08-11 through 08-14-open (guidance cut, recall, litigation,
CMS/regulatory adverse decision, exec departure, rating **downgrade only**, restatement,
dilution/offering, short report, contract/payer-network loss), demanding a literal `NO NEWS`
per class. All ten clean, **Grok 1/1 first-try**, verdict THESIS INTACT. At ±100% the price
gates are unreachable, so thesis-broken remains the **only exit gate that can fire** before
the 08-17 time stop.

### Step 2 — daily loss cap: not hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **+0.36%** | -100% (`daily_loss_cap_pct`) | none |

No `cancel-all`, no `notify.sh` alert, no halt marker written to `memory/research-log.md`.
Weekly P&L **+7.30%** (vs Mon 08-10 open $6,917.30) — logged for continuity, not a midday gate.
The cap is decorative at 100%; the binding constraint remains `max_concurrent_positions: 1`,
which market-open already enforced this morning. No slot opens before **08-17**.

Intraday gain since the open: equity $7,393.62 → $7,422.42 (**+$28.80**), entirely RDNT
mark-to-market (77.29 → 77.59). Nothing actionable — the stop is 100 points away.

### ⚠️ Last midday before the 08-17 time stop — and a weekend sits in between

Today's EOD is the last routine of the week. RDNT's `target_exit` is **Monday 2026-08-17** at
**100.4% of equity**, so the position carries a full weekend and the stop is due on the first
EOD of next week. Per strategy.md a stop due *today* still defers to end-of-day, so 08-17 EOD
owns it; only if that run misses does the **08-18 market-open** pick it up under the overdue
carve-out — which would be the **5th** such instance after KMX 06-26, PENG 07-16, CCK 07-30,
BMY 08-10. EOD has missed **21 of 61 runs (~34%)**, and 08-07 → 08-10 was this exact shape.
Escalations #2/#3 exist to prevent it and their deadline is now **two sessions out**.

### 🟢 Data note — IEX quote feed recovered since the open

`alpaca.sh quote RDNT` returned `t=2026-08-14T15:56:44Z` (11:56 ET, ~6 min lag) — normal IEX
behaviour, **not** the ~17.5-hour-stale print that escalation #9 recorded at this morning's bell.
So #9 looks specific to the 09:30 open, not an all-session condition. Keeping it on the list:
the run that matters (an 08-18 market-open forced sale of RDNT at 100% of equity) would happen
at exactly the bell where it does reproduce. Marks above use `positions.current_price` (77.59);
`trade.p` was 77.865 = +7.70%, and neither is within 92 points of a gate.

### 🟠 `no_margin` still breached — cash -$26.22, 17th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+7.32% winner to cure a $26 overdraft. Needs the partial-close path (escalation #5) or the wider
entry haircut (#6).

### Ops carry-forward — 20th consecutive escalation, still unapplied

Midday can apply none of these (exits and notifications only). Re-listed so the count stays
honest. Nothing new today.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change, and **its
   deadline is 08-17**. RDNT's time stop lands Monday at 100% of equity; EOD has missed 21 of 61 runs.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key licenses
   the deferral that produces the 3-4 minute late starts. Same deadline as #2.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live on 08-18 if EOD misses 08-17.**
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. Worked around with Yahoo for a 3rd session on 08-14 pre-market.
8. **`routines/midday.md:1` header is wrong by an hour** — **re-confirmed live this run** (fired
   12:03 ET, header claims 1:00 PM ET). Docs-only fix — do NOT "correct" the plist to match.
9. **IEX `quote` feed is stale at the 09:30 open** (`trade.p` carried yesterday's 15:59 ET print
   across 3 polls on 08-14 market-open). Scoped narrower this run: the feed is normal by midday,
   so this is an open-bell condition. Prefer `positions.current_price` for marks at the bell, and
   expect slow fills on any open-bell order.

---

2026-08-14 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked,
`memory/trade-log.md` unchanged. RDNT marked 77.29 vs 72.30 entry = **+6.90%**, down from
+7.47% at last night's close. Market value $7,419.84 on $7,393.62 equity — still **100.4% of
the book**.

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:13 ET, 13 seconds after the bell

**Fourth consecutive on-time market-open** (08-11 through 08-14). The market-open plist has now
gone a full week without a miss while EOD deferred twice in the same week. Same one-line split,
same fix: escalations #2/#3 stay at the top and **their deadline is the next session**.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +6.90% | +100% (`per_trade_target_pct`) | no |
| stop loss | +6.90% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |
| time stop | exit 2026-08-17 (next session) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |

Instrument detected live off Alpaca `asset_class: us_equity` — shares path, `quote`/`sell`, no
expiry guard applicable. Same 10-class enumeration as 08-11 through 08-13 (guidance cut, recall,
litigation, CMS/regulatory adverse decision, exec departure, rating **downgrade only**,
restatement, dilution/offering, short report, contract/payer-network loss), demanding a literal
`NO NEWS` per class. All ten clean, **Grok 1/1 first-try**, verdict THESIS INTACT.

At ±100% the price gates are unreachable, so thesis-broken stays the **only exit gate that can
fire** before the time stop.

### ⚠️ The 08-17 time stop is now ONE session away — and it is EOD's to enforce

RDNT's `target_exit` is **Monday 2026-08-17**, at **100.4% of equity**. Today is the last routine
before it. Restating the arithmetic plainly:

- If Monday's EOD runs on time, it sells RDNT and this is a non-event.
- If Monday's EOD defers or misses — **it has missed 21 of 61 runs (~34%)** — the position carries
  past its stop, and the **08-18 market-open** picks it up under the strategy.md overdue carve-out.
  That would be the **5th** such instance after KMX 06-26, PENG 07-16, CCK 07-30, BMY 08-10.

The 08-07 → 08-10 BMY failure is the exact template: EOD fired after the close, could not act, and
a 97.3%-of-equity position carried a three-day weekend. Monday is a Monday again. Escalations #2
and #3 were filed to prevent precisely this and have gone **19 routines** unapplied.

### Step 2 — halt checks: capacity cap fired

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| daily P&L | **-0.03%** | -100% (`daily_loss_cap_pct`) | no |
| weekly P&L | **+6.89%** (vs Mon 08-10 open $6,917.30) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **1** | 1 (`max_concurrent_positions`) | **YES** |

Both loss caps are decorative at 100%. The **capacity cap is the binding constraint** and it
halted entries on its own.

### Step 3 — entries: none, and blocked twice over

Pre-market scored **0 tradeable candidates against a threshold of 6** (top score 5:
AMAT/BMY/WDAY/RDDT). Threshold and cap both said no, independently — **seventh consecutive
session**. Still **coincidence, not vindication**: the cap has not been tested by a qualifying
name since it was set, so its cost is unpaid, not retired. No slot opens before **08-17**.

Worth flagging for the weekly review: pre-market logged BMY as *"scores 6 at novelty 3; recorded
for audit"* but ranked it **5**. That is a judgment call about an approval that was widely
anticipated, and it did not change today's outcome (the cap blocked entries regardless) — but it
is the second BMY scoring dispute in the log and belongs in the review, not in a routine.

### 🟡 Data note — IEX trade feed stale through the open

`alpaca.sh quote RDNT` returned `t=2026-08-13T19:59:20Z` (yesterday's 15:59 ET print) on **three
polls over 15 seconds**. The mark used above (77.29) is Alpaca's own `positions.current_price`,
not the stale `trade.p` (77.345). Same staleness that made the 08-10 BMY exit sit `new` for
~3.3 minutes. Harmless today because no order was sent and the gates are ±100% — but **if Monday's
EOD misses and 08-18 market-open has to sell RDNT at 100% of equity, this is the condition it will
sell into.** Not currently on the escalation list; adding it as **#9**.

### 🟠 `no_margin` still breached — cash -$26.22, 16th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+6.90% winner to cure a $26 overdraft. Needs the partial-close path (escalation #5) or the wider
entry haircut (#6).

### Ops carry-forward — 19th consecutive escalation, still unapplied

Market-open can apply none of these; re-listed so the count stays honest. **#9 is new.**

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change, and **its
   deadline is the next session**. RDNT's time stop lands Monday 08-17 at 100% of equity; EOD has
   missed 21 of 61 runs.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key licenses
   the deferral that produces the 3-4 minute late starts. Same deadline as #2.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live on 08-18 if EOD misses 08-17.**
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. Worked around with Yahoo for a 3rd session on 08-14 pre-market.
8. **`routines/midday.md:1` header is wrong by an hour** — confirmed live 08-13 midday (fired
   12:02 ET, header claims 1:00 PM ET). Docs-only fix — do NOT "correct" the plist to match.
9. **NEW — IEX `quote` feed is stale at the 09:30 open** (`trade.p` carried yesterday's 15:59 ET
   print across 3 polls today). Exit/entry logic that reads `.trade.p` at the bell is reading a
   ~17.5-hour-old price. Prefer `positions.current_price` for marks, and expect slow fills on any
   open-bell order.

---

2026-08-13 end-of-day: **0 time-stops, 0 exits, 0 orders.** No preflight invoked,
`memory/trade-log.md` unchanged. RDNT marked 77.70 vs 72.30 entry = **+7.47%**, up from
+6.02% at the 12:02 ET midday mark and +7.03% at the open. Market value $7,458.24 on
$7,432.02 equity — still **100.4% of the book**.

### 🟢 RUN QUALITY: ON TIME — clock read 15:55:12 ET, at the 15:55 ET trigger

**First on-time EOD after two consecutive degraded runs** (08-12 started 15:58, 08-07 fired
after the close). One clean run does not retire escalations #2/#3 — the plist still carries
`ProcessType Background`, which is what licenses the deferral. **08-17 is the run that
matters**: RDNT's time stop is EOD's to enforce, at 100% of equity, on a Monday.

### Step 1 — time stops + expiry guard: nothing due

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| time stop | exit 2026-08-17 (2 sessions out) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |
| expiry guard | n/a — no options open | within 2 trading days of expiry | n/a |
| profit target (safety net) | +7.47% | +100% (`per_trade_target_pct`) | no |
| stop loss (safety net) | +7.47% | -100% (`per_trade_stop_pct`) | no |
| thesis broken (safety net) | Grok **NO NEWS ×10 classes** | concrete named event | no |

Instrument detected live off Alpaca `asset_class: us_equity` — shares path, `quote`/`sell`,
no expiry guard applicable. Same 10-class enumeration as 08-11 through 08-13-midday (guidance
cut, recall, litigation, CMS/regulatory adverse decision, exec departure, rating **downgrade
only**, restatement, dilution/offering, short report, contract/payer-network loss), demanding a
literal `NO NEWS` per class. All ten clean, **Grok 1/1 first-try**, verdict THESIS INTACT.

At ±100% the price gates are unreachable, so thesis-broken stays the **only exit gate that can
fire** before the 08-17 time stop.

### Step 2 — weekly loss cap: not hit

| check | value | cap | action |
|-------|-------|-----|--------|
| weekly P&L | **+7.44%** (vs Mon 08-10 open $6,917.30) | -100% (`weekly_loss_cap_pct`) | none |
| daily P&L | **+0.97%** | -100% (`daily_loss_cap_pct`) | none |

No flatten, no `notify.sh` alert, no `PAUSED` marker written to `memory/research-log.md`.
Intraday recovery off the midday low: $7,334.58 → $7,432.02 (**+$97.44**), entirely RDNT
mark-to-market (76.65 → 77.70), reversing the morning give-back and closing above the open.

### Step 3/4 — EOD email sent

Resend id `b8c92ada-d210-4659-a1fa-e1fd07d656b1`, one attempt, delivered. Body in
`/tmp/bull-eod.txt`. Pre-market scanned **11 candidates, 0 reached the threshold of 6** (top
score 5: CRWV/SMCI/NBIS/HLIT/HRB/CAVA, all rejected on novelty). **Sixth consecutive session**
where the entry threshold and the capacity cap agree — still **coincidence, not vindication**;
the cap has not been tested by a qualifying name since it was set.

### 🟠 `no_margin` still breached — cash -$26.22, 14th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+7.47% winner to cure a $26 overdraft. Needs the partial-close path (escalation #5) or the wider
entry haircut (#6).

### Ops carry-forward — 17th consecutive escalation, still unapplied

EOD can apply none of these (exits, journaling and notification only). Re-listed so the count
stays honest. Nothing new today; **#2/#3 now have a deadline**: 08-17.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change. **RDNT's
   08-17 time stop is EOD's to enforce**, it is 100% of equity, and EOD has missed 21 of 60 runs.
   08-17 is a Monday: the first EOD of next week, the exact shape of the 08-07 failure that forced
   the 08-10 BMY cleanup at market-open. Today's on-time run does not retire this.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key licenses
   the deferral that produces the 3-4 minute late starts.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live on 08-18 if EOD misses 08-17.**
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. Characterized with a root cause on 08-13 pre-market.
8. **`routines/midday.md:1` header is wrong by an hour** — confirmed live 08-13 midday (fired
   12:02 ET, header claims 1:00 PM ET). Docs-only fix — do NOT "correct" the plist to match.

---

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
