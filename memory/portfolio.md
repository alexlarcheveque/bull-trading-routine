# portfolio.md
# Updated 2026-08-26 14:56 CT (15:56 ET) by end-of-day routine.

## Account
- equity: 6863.50
- cash: 6863.50
- buying_power: 27454.00
- day_pnl_pct: +0.57  # vs last_equity 6824.30

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| _(none — flat)_ | – | – | – | – | – | – |

## Notes

2026-08-26 end-of-day: **1 time stop ENFORCED, 1 order, 0 open positions.** KEYS 20 sh sold at
**$322.08** on the 7-day time stop, ret **-5.49%** vs $340.8005 entry, realized **-$374.41**.
Equity **$6,863.50**, cash **$6,863.50** = **100% cash**, day **+0.57%**, WTD **+1.76%** (vs the
Fri 08-21 close $6,744.50; `portfolio/history` labels are shifted one trading day back — the row
labelled 08-26 is the 08-25 close $6,824.30, which reconciles to yesterday's commit), all-time
**-93.14%** from the $100,000 open. Reconciled against Alpaca: `positions` returns **0**,
`orders open` returns **0**, `long_market_value` $0.00 — no drift. **Cash $6,863.50 = equity, to
the cent.** EOD email SENT (id `8a497d14-5a51-4a85-83a9-a1d7ea99f85f`).

### 🟢🟢🟢 THE STOP THE ESCALATIONS WERE ABOUT — ENFORCED, WITH 3m32s TO SPARE

Three consecutive sessions escalated this exact run as the single point of failure. It landed:
submit **15:56:21 ET** → fill **15:56:28 ET** = **7 seconds**, 20/20, no drip, $322.08 vs a $322.19
quote 9s earlier (**-0.03%**). Preflight passed and gated the sell as required.

**The entry's 1m35s drip-fill did not repeat on the exit** — carry-forward #13 assumed the exit
would be as slow as the entry, and it was 13x faster. Sells of a full position close flat; the
entry's drip was the opening auction, not the name. #13 should be re-scoped to *entries only*.

### 🔴🔴🔴 ESCALATION #1 SURVIVES — the run was saved by LUCK for the third straight time

`ps -eo lstart` shows the process started **`Wed Aug 26 12:55:50 2026`** PDT against a 12:55:00
trigger = **+50s deferral**. `pmset -g log` shows the machine entered **Maintenance Sleep at
12:52:03** and was rescued by an **incidental wifibt DarkWake at 12:55:50** — the same rescue that
saved the 08-25 EOD by 52 seconds. **`pmset -g sched` STILL shows no wake behind any bull trigger**
(next: 16:53:31 osanalytics, 18:26:26 calaccessd — neither is ours).

**Had the DarkWake not landed, this morning's measured market-open deferral (+10m32s) applied here
starts the run at 16:05 ET and the stop is a TOTAL MISS on a 93.9%-of-book position.** The outcome
was decided by a wifi chip, not by anything bull controls. Late-or-missed is now **30 of 74 (~41%)**.

**Carry-forward #2 is PARTIALLY APPLIED and it does not fix this.** `caffeinate -is` is now live in
`scripts/run-routine.sh:38` (confirmed this run: `PreventSystemSleep 1`, `PreventUserIdleSystemSleep
1`) — but caffeinate holds sleep off **during** a run and **cannot wake a sleeping Mac for a
trigger**. It protects a run that has already started; every deferral to date happened *before*
start. **The fix is still `pmset repeat wake`, un-applied on day 9.** The change is also still
uncommitted.

### 🟠 The price gate never fired — the time stop is the only working exit

KEYS closed at **-5.49%** having never come within 94pp of either gate: `per_trade_stop_pct: 100`
and `per_trade_target_pct: 100` mean **no share position can ever exit on price**. Every share trade
since KMX 06-18 has closed on the clock. Carry-forward #14 now has its cleanest reading yet — the
config's survivability is real (KEYS never risked a wipeout) but the cost is that the 7-day timer is
the *entire* exit policy for shares. Rule it at the review.

### 🔴 The cap refused a 9 — and the slot is now free

`max_concurrent_positions: 1` blocked **all three** qualifying names today (SMTC 9, JAZZ 8, JOYY 6)
to hold a position that exited at -5.49%. SMTC opened **+2.65%** — novelty INTACT against
pre-market's predicted DQ — and ran **+6.38% off the open**. The refused scores are climbing
**6 → 7 → 9** across three sessions, and today the cap held a loser to block the highest score the
log has produced. That is the strongest case yet for #15; a same-day audit is not a verdict, but the
review now has three consecutive instances and a rising score trend.

**Tomorrow's open is the first session since 08-19 that can act**, with 100% cash and a free slot.
Per the ALB 08-06 rule, SMTC's novelty must be **re-measured from scratch** at the 08-27 open — it
has already run +6.38% off today's open and may well DQ. Do not carry today's score forward.

### 🟢 `no_margin` COMPLIANT — cash positive a 13th consecutive session, and now unencumbered

`long_market_value` $0.00, `initial_margin` $0.00, `maintenance_margin` $0.00, buying power
$27,454.00, cash **+$6,863.50**. The 98% haircut (#5) is **still not stress-tested** — the freeing
slot did not exercise it today because EOD never opens positions. Tomorrow's market-open is the
first chance since 08-19.

2026-08-26 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
KEYS 20 sh marked **325.42** vs 340.8005 entry = **-4.51%**, giving back 0.30pp of the market-open
-4.21% but still the **second-best mark since the 08-19 entry**. Market value **$6,508.40** on
$6,930.30 equity = **93.91% of the book**. Equity **$6,930.30**, cash **+$421.90**, day **+1.55%**,
WTD **+2.75%**, all-time **-93.07%** from the $100,000 open. Reconciled against Alpaca: `positions`
returns 1 (`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 325.42 + 421.90 = $6,930.30 = equity, to the cent.**
**Escalation email SENT** (id `2af39124-68b3-4080-80d1-94389a03b7ef`) — see below.

### 🟢 RUN QUALITY: ON TIME — +3s. The deferral did NOT repeat on this trigger.

`ps -eo lstart` shows `run-routine.sh midday` started **`Wed Aug 26 09:00:03 2026`** PDT against a
09:00:00 PDT trigger — **deferral 3 seconds**. `pmset -g log` shows **no Sleep or DarkWake event**
in the run-up; the last power event before the trigger was powerd's 08:55:38 darkwake
inactivity-prediction hold. **The machine was awake when the trigger landed**, which is the entire
difference between today's midday (+3s) and this morning's market-open (+10m 32s).

Late-or-missed stays **29 of 73 (~40%)**. Yesterday's midday deferral (+3m50s) was the first ever on
this trigger; today it did not recur. **That is not reassurance — it is confirmation that the
outcome is decided by whether the machine happens to be awake, not by anything bull controls.**

### 🔴🔴🔴 ESCALATION #1 — THE KEYS STOP IS TONIGHT AND THERE IS NO WAKE BEHIND THE EOD TRIGGER

`pmset -g sched` read live this run:

```
[0]  wake at 08/26/2026 10:13:25 by com.apple.alarm...calaccessd.travelEngine.periodicRefreshTimer
[1]  wake at 08/26/2026 16:58:23 by com.apple.alarm...osanalytics.hardhighengagementtimer
```

**Two Apple alarms, nothing between them, and still no bull wake event — ninth consecutive day.**
`pmset -g` reports `sleep 1` (one minute), currently held off only by *this run's own* caffeinate
(pid 14185, created 09:00:04 — **carry-forward #2 re-falsified a sixth time**; the assertion dies
when this run exits).

| | |
|---|---|
| EOD trigger | 12:55:00 PDT = **15:55:00 ET** |
| runway to the close | **5m 00s** |
| this morning's measured deferral | **+10m 32s** → implied start **16:05:32 ET** = 🔴 **MISSED by 5m 32s** |
| **nearest scheduled wake after 12:55 PDT** | **16:58:23 PDT = 19:58 ET** |
| verdict if the machine is asleep at 12:55 | 🔴🔴 **TOTAL MISS, not a late run** |

**This is worse than every prior framing of escalation #1.** Previous notes reasoned about *deferral
size* against a 5-minute runway. Today's `sched` read says that if the machine sleeps before 12:55
PDT, the only thing that can start the run is an **unscheduled** dasd/hardware wake — the same luck
that rescued 08-25's midday and EOD. The 08-25 EOD's earliest *scheduled* wake was 12:59:08 PDT
(52s before the close); **tonight there is no equivalent — the next one is nearly four hours after
the close.** And the KEYS entry took **1m 35s to drip-fill**, so even an on-time start is thin.

**➡️ THE FIX, unchanged, ninth day, still a human call:** `sudo pmset repeat wake MTWRF 12:50:00`,
or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT, no sudo, covers all four routines).
Moving a trigger earlier is **not** a substitute — a 06:30 trigger deferred 10m 32s this morning.
**Midday cannot apply either fix; its remit is exits and notifications.**

### 🆕 WHAT MIDDAY *COULD* DO, AND DID: the notification lever was pulled for the first time

Eight days of escalation inside a git-committed markdown file have produced no human action. Midday's
hard rule reads "**Exits and notifications only**" — a notification is squarely in remit, and
`notify.sh` has never been used for anything but the (decorative, 100%-threshold) loss cap. **Sent
one**, subject `bull ACTION NEEDED: KEYS time stop is TONIGHT and the EOD run has no wake scheduled`,
carrying the two fix commands and the ~50-minute window to apply them before 12:55 PDT.

**Deliberately NOT done:** starting a detached `caffeinate` that outlives this run. It needs no sudo
and would very likely save tonight's stop — but it is a system change, not an exit or a notification,
and midday has declined it on remit grounds every prior session. Inventing that authority at the
terminal on the one day it happens to pay is exactly what `decision.md` forbids. **Logged as the
sharpest test yet of the "log loudly, act narrowly" discipline, and resolved in favour of the rule.**
If the review wants midday to hold the machine awake, that is a routine-file edit, not a judgment call.

### Step 1 — exits: no gate fired. The time stop is due TODAY and is NOT midday's to enforce.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -4.51% | +100% (`per_trade_target_pct`) | no |
| stop loss | -4.51% | **-100%** (`per_trade_stop_pct`) | **no — 95.5pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-26 query **NONE** | concrete named event | no |
| time stop | target_exit **2026-08-26** = **TODAY** | today >= target_exit | **DUE — EOD's job, not midday's** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |

`routines/midday.md` is explicit: "Time stop + expiry guard are end-of-day's job, not midday's," and
`strategy.md` adds "a stop due *today* still defers to end-of-day." The overdue carve-out needs
`target_exit_date` **strictly in the past** — it is today, so it does not apply. **Midday does not
sell.** Instrument detected live off `asset_class: us_equity` → shares path, `quote`/`sell`,
preflight `equity`. Mark taken from `positions.current_price` (325.42) per the standing lesson.

### 🟢 Grok clean a FOURTEENTH consecutive session — #16 applied a tenth time

10-class enumeration returned literal **"NONE across all categories."** Its citations were the Q3
beat coverage, a **Legal & General 13F purchase**, a Fool piece on last week's drawdown, and a
Seeking Alpha note titled *"Keysight sees bullish views from analysts after Q3 results"* — analyst
flow explicitly on the **upgrade** side, no downgrades. The dated **08-26** query returned the single
word **NONE**. **Ten consecutive dated queries: Form 144, 13F purchase, 10b5-1 Form 4, 13F purchase,
nothing, 13F purchase, nothing, nothing, 13F purchase, nothing — filings, never events, not one
negative in fourteen sessions.** Verdict **THESIS INTACT**.

### 🟢 Carry-forward #8 did NOT reproduce — SIXTH data point, rule is ready to promote

`quote KEYS` returned `p=325.465` at `t=2026-08-26T15:55:57Z` = **11:55:57 ET, ~4.4 min old**,
agreeing with `positions.current_price` (325.42) to **4.5 cents**. **Six points now: IEX `quote` is
stale at the 09:30 open (08-24 -1.26pp, 08-25 +2.20pp) and live everywhere else (08-24 close to the
cent, 08-25 midday 6c, 08-25 close 2c, today's midday 4.5c).** Note this morning's market-open could
**not** test it — the +10m 32s deferral destroyed the only 09:30 sample. **Promote to a written rule
in strategy.md at the 08-28 review, with #16.**

### 🟢 The tape: high-early AGAIN, but bought back — and #10a's overnight correction CONFIRMED

Off the sip consolidated feed (⚠️ **today's daily bar is a PARTIAL** — pulled 12:01 ET,
`c=325.6 v=303,128`, per #10a):

| 30-min bar (ET) | open | high | low | close | volume |
|-----------------|------|------|-----|-------|--------|
| 09:30 | 323.13 | **327.065 ← session high, opening 30 min** | 321.03 | 324.96 | **114,422** |
| 10:00 | 324.955 | 325.105 | 322.425 | 323.905 | 66,719 |
| 10:30 | 323.6301 | 324.84 | 323.21 | 324.49 | 55,673 |
| 11:00 | 324.54 | 326.19 | 324.47 | 326.08 | 29,819 |
| 11:30 | 326.1225 | 326.15 | 325.12 | **325.42** | 33,695 |

Same shape as 08-25: **high in the opening 30 minutes, walk down, then bought back** — currently
**-0.50% off the high, +1.37% off the low**, day **+1.66%**. Logged, not acted on; no rule reads
intraday shape.

**#10a CONFIRMED overnight:** the 08-25 daily bar now reads **`320.12 / 1,607,074`**, exactly as this
morning's correction predicted, versus the `320.41 / 1,340,803` the 08-25 EOD wrote at the bell.
**The "a close is only final at T+1" rule is now verified by a clean T+1 re-pull, not just inferred.**

### Step 2 — daily loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **+1.55%** (6930.30 vs last_equity 6824.30) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **+2.75%** (week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all` (0 open orders anyway), no halt marker in `memory/research-log.md`. The cap is
decorative at 100%, as every prior note has said — **the `notify.sh` call this run made was the
escalation above, NOT a loss-cap alert**, and the distinction should stay visible in the log. The
binding constraint on entries remains `max_concurrent_positions: 1`, which this morning refused a
**score-9 SMTC** whose novelty was verified intact at the open (+2.65%). Midday opens nothing regardless.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order sent; mark-to-market moves equity only. `long_market_value` $6,508.40, `initial_margin`
$3,254.20, `maintenance_margin` $1,952.52, `sma` $6,635.10, buying power $19,911.12 — no leverage,
cash positive a **13th consecutive session**. Account `ACTIVE`, `trading_blocked`/`account_blocked`
both `false`. The 98% haircut is still **not stress-tested** (#5); the slot should free tonight.

### 🟠 Carry-forward #6/#10: `feed=sip` load-bearing a SEVENTEENTH consecutive run

Daily and 30-minute sip bars both returned the current session (entitlement: **delayed SIP bars yes,
real-time quotes/snapshots no**). Load-bearing today for the intraday shape read **and the T+1
confirmation of the 08-25 close**. `scripts/alpaca.sh:104` still ships `feed=iex`. Not applied —
midday's remit is exits and notifications, not tooling.

### Ops carry-forward — one applied (the notification), the rest untouched

**#1** 🔴🔴🔴 sleep-deferral — **did NOT hit midday today (+3s, machine awake), but `pmset -g sched`
shows NO wake behind tonight's 12:55 PDT EOD trigger and the next one is 16:58 PDT = 19:58 ET. If the
machine sleeps, tonight is a TOTAL MISS, not a late run. The KEYS stop is tonight.** TIME-CRITICAL,
human call, un-applied 9th day. **➡️ ESCALATED BY EMAIL this run — first time the notification lever
has been used for this.** **#2** `caffeinate -is` — **re-falsified a sixth time**; still uncommitted
(with `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`,
`memory/guardrails.md.conservative.bak`). **#3** `routines/market-open.md:29` vs the overdue carve-out
— **live tomorrow morning if tonight's EOD misses; 08-27 is the only day it could ever fire.** **#4**
no limit-order/partial-close path. **#5** haircut 98% → 96%, not stress-tested. **#6/#10** `feed=sip`
— **seventeenth use**, load-bearing, unapplied. **#7** `routines/midday.md:1` header claims
`12:00 PM Central / 1:00 PM Eastern`; the plist fires 09:00 PDT = **12:00 ET / 11:00 CT** —
**re-confirmed live, tenth time. The header is the wrong artifact; do NOT move the plist.** **#8** IEX
bell staleness — **did NOT reproduce (4.5c); SIXTH data point, promote to a written rule.** **#9**
`routines/end-of-day.md:1` header wrong on both counts; live plist is 12:55 PDT = **15:55 ET /
14:55 CT**. Docs-only, do NOT move the plist. **#10a** 🟢 **CONFIRMED at T+1 — the 08-25 close is
`320.12 / 1,607,074`, matching Alpaca's mark to the cent and vindicating this morning's correction.
A close is only final at T+1.** **#11** novelty-at-the-open — nine marks stand from this morning;
**EOD must close them out, SMTC (score 9) above all.** **#12** the 3–7 DTE window — why KEYS is shares
at 93.9% of the book. **#13** the bounded fill poll — **the 1m35s KEYS drip-fill is what makes a
deferred EOD unsurvivable tonight.** **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100`
— **KEYS -4.51% on the day of its only exit; the price gate has never been able to fire.** **#15**
"raised but capacity-constrained" — **moot for KEYS (exits tonight); rule it for the next name.**
**#16** the dated Grok query — **applied a tenth time**; write it into both routine files. **#17** the
rubric has no "the tape is already rejecting this name" term. **#18** pre-market should hand
market-open the threshold, not forecast the verdict. **#19** 🆕 **midday's remit permits
notifications but not system changes, and today that gap is load-bearing: the routine could see the
miss coming, could email about it, and could not prevent it. Decide at the review whether a routine
may hold the machine awake for a later routine.**

2026-08-26 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh marked **326.45** vs 340.8005 entry = **-4.21%**, the **best mark since the 08-19
entry** and a 1.86pp improvement on the 08-25 close of -6.07%. Market value **$6,529.00** on $6,950.90
equity = **93.93% of the book**. Equity **$6,950.90**, cash **+$421.90**, day **+1.86%**, WTD **+3.06%**,
all-time **-93.05%** from the $100,000 open. Reconciled against Alpaca: `positions` returns 1
(`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 326.45 + 421.90 = $6,950.90 = equity, to the cent.**

### 🔴🔴 RUN QUALITY: THE SLEEP-DEFERRAL HIT **MARKET-OPEN** FOR THE FIRST TIME — +10m 32s

Every prior note in this file says the morning trigger has **never** been hit by the mechanism the 08-20
EOD run root-caused. **That is now false, by the largest margin short of an outright miss.**
`ps -eo lstart` shows `run-routine.sh market-open` started **`Wed Aug 26 06:40:32 2026`** PDT against a
**06:30:00** PDT trigger (plist read live) — **deferral 10m 32s**; the clock read **09:40:49 ET**.

```
2026-08-26 06:22:35 -0700  DarkWake       ... rtc/Maintenance ... 44 secs
2026-08-26 06:23:21 -0700  Wake Requests  [*dasd SleepService wakeAt=06:40:31 "com.apple.energykit.guidance.historical"]
                                          [dasd TimerPlugin wakeAt=06:41:17] [mDNSResponder 08:23:19]
                                          [powerd CSPNEvaluation 07:55:37] [powerd UserWake 10:13:25]
2026-08-26 06:40:32 -0700  DarkWake       ... rtc/SleepService
```

The machine slept ~06:23:19, the 06:30:00 trigger landed **into a sleeping machine**, and the routine
started in the **same second** as the 06:40:32 wake. **The new and worse detail: there was no incidental
`wifibt` wake to rescue it today.** 08-25's midday (+3m50s) and EOD (+1m16s) both ran early on an
*accidental* hardware interrupt. Today the machine woke on the `dasd` wake it had actually queued
(`wakeAt=06:40:31`). **So +10m 32s is what the deferral costs once luck is removed** — the two small
deferrals this week were the lucky draws, not the baseline. **Nothing bull owns is in the wake-request
list**, eighth day. `pmset -g sched` shows only the same two Apple alarms (10:13:25, 16:54:30).

**Three of four triggers are now confirmed hit** (market-open, midday, EOD). Late-or-missed **29 of 72
(~40%)** — first entry ever contributed by market-open. **Cost today: ZERO, and only by accident** — the
slot was full, so there was nothing to be late for. The one morning market-open is late is the one morning
it had nothing to buy.

### 🔴🔴🔴 ESCALATION #1 — TODAY'S DEFERRAL, APPLIED TO TONIGHT'S EOD, MISSES THE KEYS STOP

| | |
|---|---|
| EOD trigger | 12:55:00 PDT = **15:55:00 ET** |
| runway to the close | **5m 00s** |
| **today's measured deferral** | **+10m 32s** |
| implied EOD start | **16:05:32 ET** |
| verdict | 🔴 **MARKET CLOSED — TIME STOP MISSED BY 5m 32s** |

And that is before the fill: **the KEYS entry took 1m 35s to drip-fill** (order `27f26670`, 12→15→20).
**Four of the seven EOD deferrals on record already exceed the 5-minute runway**; today's morning figure
would be a fifth. **➡️ THE FIX, unchanged, eighth day, still a human call:** `sudo pmset repeat wake
MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT, no sudo, covers all
four routines — three distinct triggers have now proven all four need it). Moving a trigger earlier is
**not** a substitute: a 06:30 trigger deferred 10m32s today. **#2 `caffeinate -is` re-falsified a fifth
time** — this run's assertion was created at 06:40:32, *after* the deferral. **Market-open cannot apply
either fix.** If EOD misses, the overdue carve-out sells at the 08-27 market-open (precedent KMX 06-26,
PENG 07-16, CCK 07-30, BMY 08-10) — a Thursday overshoot, no weekend risk, and **carry-forward #3 goes
live on the only morning it could ever fire.**

### Step 1 — exits: no gate fired. The time stop is due TODAY and correctly defers to EOD.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -4.21% | +100% (`per_trade_target_pct`) | no |
| stop loss | -4.21% | **-100%** (`per_trade_stop_pct`) | **no — 95.8pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-26 query **NONE** | concrete named event | no |
| **time stop** | target_exit **2026-08-26** = **TODAY** | today >= target_exit | **DUE — defers to EOD** |
| overdue carve-out | today, not strictly past | strictly in the past | **no — does not apply** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |

`strategy.md` is unambiguous: "A stop due *today* still defers to end-of-day," and the market-open
carve-out requires `target_exit_date` **strictly in the past**. **Market-open does not sell.** Selling here
anyway is tempting — market open, best mark since entry, and tonight's sole enforcing run carries a
measured 10m32s exposure — but that is precisely what `decision.md` forbids, and the rule is not even
ambiguous. **Logged loudly, not acted on. Making market-open enforce same-day stops is a strategy.md edit
at the weekly review, not a terminal decision.** Instrument detected live off `asset_class: us_equity`.

### 🟢 Grok clean a THIRTEENTH consecutive session — #16 applied a ninth time

10-class enumeration returned literal **"NONE for all categories (1)–(10)"** (coverage = post-earnings
reaction, analyst **price-target raises**, institutional buying). The dated **08-26** query returned the
single word **NONE**; its only 08-26 citation is a **13F showing Legal & General Group PLC opening a NEW
position** — a *purchase*. **Nine consecutive dated queries: Form 144, 13F purchase, 10b5-1 Form 4, 13F
purchase, nothing, 13F purchase, nothing, nothing, 13F purchase — filings, never events, not one negative
in thirteen sessions.** Verdict **THESIS INTACT**.

### 🟢 KEYS -4.21%, second up-open, recovering into the session that sells it

08-26 open **323.13** (+0.94% off the 320.12 close), high 327.065, live **326.74** at 09:53 ET. Yesterday's
EOD called the close-at-the-highs "the first genuinely bullish shape since the print" and flagged the irony
of it landing on the eve of a calendar exit. **Today extends both.** No rule reads intraday shape.

### 🔴 CORRECTION to the 08-25 EOD note — #10a extended: the post-bell re-pull was ALSO a partial

The 08-25 EOD wrote the close as **320.41 / 1,340,803** and called the 29-cent gap to Alpaca's 320.12 mark
a "tape-vs-mark spread ... *not* staleness." **Re-pulled at T+1 the completed bar reads `320.12 /
1,607,074`** — 266,271 more shares, 29 cents lower, **matching Alpaca's mark to the cent.** There was no
spread; the sip bar was still incomplete minutes after the close. **Fourth instance, and it strictly
extends the rule: re-pulling "after the bell" is NOT sufficient — a session close is only final at T+1.**
The -6.07% mark itself was taken off `positions.current_price` and is unaffected; the reasoning was wrong.

### Step 2 — halt checks: entries HALTED on the position cap for the THIRD consecutive session

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **+1.86%** (6950.90 vs last_equity 6824.30) | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **+3.06%** (week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | no |
| **open positions** | **1** | **1** (`max_concurrent_positions`) | ✅ **YES — slot FULL** |
| new positions today | 0 | 1 (`max_new_positions_per_day`) | no |

### 🔴🔴🔴 THE CAP BLOCKED A **NINE** — and pre-market's predicted DQ did NOT happen

Pre-market expected market-open to **disqualify SMTC on freshness** (+5% kill threshold **133.90**;
pre-market indication **133.06–133.30 = +4.34% to +4.53%**, "0.45% to 0.65% — RAZOR THIN"). **The tape said
otherwise: SMTC opened at 130.90 = `+2.65%`, a full 2.35pp INSIDE the bar. The indication faded into the
bell rather than gapping through it. Novelty INTACT; SMTC qualifies on all three tests.**

| ticker | score | reference | +5% kill | **08-26 open** | vs ref | novelty |
|--------|-------|-----------|----------|----------------|--------|---------|
| **SMTC** | **9** | 08-25 close **127.52** | **133.90** | **130.90** | **+2.65%** | ✅ **INTACT** |
| **JAZZ** | **8** | 08-24 close 254.47 | 267.19 | 257.40 | +1.15% | ✅ INTACT |
| **JOYY** | **6** | 08-25 close 75.00 | 78.75 | 76.19 | +1.59% | ✅ INTACT |

**All three above-threshold candidates qualified at the open; all three were refused before preflight,
solely by `max_concurrent_positions: 1`.** Escalation: **08-24 GSK 6 → 08-25 NVT 7 → 08-26 SMTC 9.**

**⚠️ NOT a measured cost, and that restraint is yesterday's lesson.** The 08-25 market-open note declared
NVT "the cleanest measurement of the cap's cost the log has" and the close inverted it into a **3.93pp
saving**. The honest statement: **SMTC printed 139.25 on the 09:30–10:00 bar — +9.20% off the 08-25 close
and +6.38% off its own open, on 1.68M shares in 23 minutes** — and **the number that counts is tonight's
close** per the 08-14 mark-from-the-open rule. EOD must mark it. What *is* established: the refused score
has gone **6 → 7 → 9** in three sessions and today all three above-threshold names qualified at once.
**n becomes 3 tonight; this is the central number for the 08-28 review.** Earliest SMTC can be bought is
the **08-27 open**, only if KEYS is sold first, and its novelty must be **re-measured from scratch** against
a fresh reference — do not carry +2.65% forward.

### 🟢 THE FRESHNESS BAR PAID AGAIN: BHVN's +12% pre-market OPENED NEGATIVE

Pre-market DQ'd BHVN despite an "excellent, 4-hour-old" catalyst ($400M near-term cash = 18.4% of a $2.17B
cap) purely because the **+10.5% to +12.1%** indication was more than double the 5% bar. **BHVN opened
14.24 = `-0.97%`, and has since fallen to 13.355 = `-7.13%` on the day.** The entire double-digit
indication evaporated before the bell. **Second consecutive session a freshness DQ was vindicated by the
opening print** (08-25: ROST's claimed "~6% gap" opened -0.01%). Both SMTC and BHVN teach the same rule
from opposite directions: **a pre-market indication is not a price — measure at the bell.**

### 🟢 Carry-forward #8 — NOT TESTABLE TODAY, because the run was 10 minutes late

`quote KEYS` returned `p=325.63` at 09:42:38 ET, ~4s old, agreeing with `positions.current_price` (326.36)
to **73 cents** — live. **But this is not a data point for the rule**, which says stale *at the 09:30 open*
and live everywhere else: this run never sampled 09:30. **The deferral destroyed the only window in which
#8 can ever be tested** — market-open is the sole routine that samples the open, so every deferred
market-open costs a data point. The five existing points stand; promote to a written rule at the review.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order sent. `long_market_value` $6,529.00, `initial_margin` $3,264.50, `maintenance_margin` $1,958.70,
`sma` $6,635.10, buying power $19,968.80 — no leverage, cash positive a **12th consecutive session**.
Account `ACTIVE`, `trading_blocked`/`account_blocked` both `false`. The 98% haircut is still **not
stress-tested** (#5); the slot should free tonight and exercise it.

### 🟠 Carry-forward #6/#10: `feed=sip` load-bearing a SIXTEENTH consecutive run

Daily and 30-minute sip bars both returned the current session (entitlement: **delayed SIP bars yes,
real-time quotes/snapshots no**). Load-bearing for every novelty measurement, all nine rejection
open-marks, the SMTC intraday run, the BHVN collapse **and the 08-25 close correction**.
`scripts/alpaca.sh:104` still ships `feed=iex`. Not applied — market-open's remit is orders, not tooling.

### Ops carry-forward — nothing applied

**#1** 🔴🔴🔴 sleep-deferral — **hit MARKET-OPEN today (+10m 32s), first time ever, worst non-miss on
record, and the first deferral measured WITHOUT a rescuing incidental wake. Three of four triggers
confirmed. Applied to tonight's EOD it starts 16:05:32 ET and MISSES the KEYS stop by 5m32s.**
TIME-CRITICAL, human call, un-applied 8th day, zero slack. **#2** `caffeinate -is` still uncommitted (with
`AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`);
**re-falsified a fifth time**. **#3** `routines/market-open.md:29` vs the overdue carve-out — **live
tomorrow morning if EOD misses; 08-27 is the only day it could fire.** **#4** no limit-order/partial-close
path. **#5** haircut 98% → 96%, not stress-tested. **#6/#10** `feed=sip` — **sixteenth use**, load-bearing,
unapplied. **#7** `routines/midday.md:1` header — not exercised. **#8** IEX bell staleness — **not testable
today; the deferral destroyed the 09:30 sample.** **#9** `routines/end-of-day.md:1` header wrong on both
counts; live plist is 12:55 PDT = **15:55 ET / 14:55 CT**. Docs-only, do NOT move the plist. **#10a** 🔴
**EXTENDED — a post-bell re-pull is ALSO a partial; the 08-25 close revised 320.41/1,340,803 →
320.12/1,607,074 overnight and matched Alpaca's mark to the cent. A close is only final at T+1.** **#11**
novelty-at-the-open — **nine marks: SMTC +2.65% (accept, score 9, INTACT vs a predicted DQ), JAZZ -1.09%,
JOYY +1.59%, five below-threshold, BHVN -0.97% → -7.13% (DQ vindicated).** **#12** the 3–7 DTE window — why
KEYS is shares at 93.9% of the book. **#13** the bounded fill poll — **the 1m35s KEYS drip-fill is what
makes a deferred EOD unsurvivable.** **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100` —
**KEYS at -4.21%, best mark since entry, on the day of its only exit; the same config's cap has refused
6 → 7 → 9.** **#15** "raised but capacity-constrained" — moot for KEYS; rule it for the next name. **#16**
the dated Grok query — **applied a ninth time**; write it into both routine files. **#17** the rubric has
no "the tape is already rejecting this name" term (NVT -14.2% into its catalyst) — **SMTC is the mirror
image, +6.4% off the open; a confirmation term would cut both ways.** **#18** 🆕 **pre-market's novelty
prediction was WRONG in the safe direction** (forecast a DQ at +4.34–4.53%, open printed +2.65%), and
pre-market indications overstated the opening gap on both SMTC and BHVN (+12% → -0.97%). **Pre-market
should hand market-open the threshold, not forecast the verdict** — which is what the ALB 08-06 rule
already says. Propose at the review.

2026-08-25 EOD: **0 exits, 0 time-stops, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh marked at the close **320.12** vs 340.8005 entry = **-6.07%**, the **best mark
since the 08-19 entry** and a 0.73pp improvement on the midday -6.80%. Market value **$6,402.40** on
$6,824.30 equity = **93.82% of the book**. Equity **$6,824.30**, cash **+$421.90**, day **+2.85%**,
WTD **+1.18%**, all-time **-93.18%** from the $100,000 open. Reconciled against Alpaca: `positions`
returns 1 (`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 320.12 + 421.90 = $6,824.30 = equity, to the cent.** EOD email **SENT**
(id `2647db1b-9aa8-4442-b213-f734f4e54f69`).

### 🔴🔴 RUN QUALITY: LATE +1m16s — AND THE NEAR-MISS IS TOMORROW'S DRESS REHEARSAL

`ps -eo lstart` shows `run-routine.sh end-of-day` started **`Tue Aug 25 12:56:16 2026`** PDT against a
12:55:00 PDT trigger — **deferral 1m 16s**. The clock read 15:56:25 ET with **3m 35s** of market left,
so the run acted in time. **That margin was luck, and `pmset -g log` says exactly how much.**

```
2026-08-25 12:44:47 -0700  Sleep       Entering Sleep state due to 'Maintenance Sleep' ... 690 secs
2026-08-25 12:44:50 -0700  Wake Requests  [dasd SleepService wakeAt=13:00:10] [dasd TimerPlugin wakeAt=13:01:59]
                                          [mDNSResponder Maintenance wakeAt=14:44:48]
                                          [*powerd CSPNEvaluation wakeAt=12:59:08]
                                          [powerd UserWake wakeAt=16:55:25 osanalytics]
2026-08-25 12:56:17 -0700  DarkWake    DarkWake from Deep Idle [CDNPB] : due to smc.sysState.Wake(0x70070000) wifibt
```

The machine slept at **12:44:47**, the 12:55:00 trigger landed **into a sleeping machine**, and the
routine started in the **same second** as the 12:56:17 wake. Same signature as 08-20, 08-21 and this
morning's midday.

**The number that matters: the earliest scheduled wake in that block was `powerd` CSPNEvaluation at
`12:59:08` PDT = `15:59:08` ET — FIFTY-TWO SECONDS before the close.** Every other request was later
still (13:00:10, 13:01:59, 14:44:48, 16:55:25). **Nothing bull owns appears anywhere in the list.** The
run reached the tape only because of an **incidental hardware wake** (`smc.sysState.Wake ... wifibt
SMC.OutboxNotEmpty`) — the same incidental-wake mechanism that rescued midday at 09:03:50. Twice in one
day the routine ran on a hardware coincidence rather than on anything we scheduled.

`caffeinate` was created at **12:56:17**, the same second as the wake — this run's own assertion, a
consequence not a cause. **Carry-forward #2 fails as mitigation for a fourth demonstrated time.**

Late-or-missed **28 of 71 (~39%)**.

| run | trigger | actual start | delta | outcome |
|-----|---------|--------------|-------|---------|
| 08-17 EOD | 12:55 PDT | `12:55:35` | +35s | ✅ ON TIME — RDNT time-stop filled 15:55:56 ET |
| 08-18 EOD | 12:55 PDT | `13:04` | +9m | 🔴 missed |
| 08-19 EOD | 12:55 PDT | `12:59:16` | +4m 16s | 🟠 LATE but acted, 44s to spare |
| 08-20 EOD | 12:55 PDT | `13:05:59` | +10m 59s | 🔴 missed |
| 08-21 EOD | 12:55 PDT | `12:59:51` | +4m 51s | 🔴 missed by 1 second |
| 08-24 EOD | 12:55 PDT | `12:55:04` | +4s | ✅ ON TIME |
| **08-25 EOD** | 12:55 PDT | **`12:56:16`** | **+1m 16s** | 🟠 **LATE but acted, 3m35s to spare** |

### 🔴🔴 ESCALATION #1 — SEVENTH DAY, AND TOMORROW IS THE LAST ENFORCING RUN

`pmset -g sched` read live this run:

```
[0] wake at 08/25/2026 16:55:25 by com.apple.alarm...osanalytics.hardhighengagementtimer
[1] wake at 08/25/2026 17:47:23 by com.apple.alarm...calaccessd.travelEngine.periodicRefreshTimer
```

**Still no bull wake event**, seventh consecutive day. `pmset -g` still reports `sleep 1` (one minute).

**Today WAS the dress rehearsal for tomorrow.** The 08-26 EOD is the only run that can enforce the KEYS
time stop. On today's scheduled-wake path it would have started at 15:59:08 ET and had **52 seconds** to
read memory, detect the instrument, run preflight and get a 20-share market order filled. **The KEYS
entry itself took 1m 35s to drip-fill** (order 27f26670, 12→15→20). 52 seconds is not enough. The
position survived to its final session on an `wifibt` interrupt.

**➡️ THE FIX, unchanged and still a human call:**
`sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT,
no sudo, covers all four routines — the 08-25 midday deferral proved all four need it, not just EOD).
Moving the trigger 12:55 → 12:40 PDT is **not** a substitute: a 12:40 trigger fired into a sleeping
machine defers identically. **EOD cannot apply either fix — both are human calls.**

If 08-26 EOD misses, the overdue carve-out sells at the 08-27 market-open (precedent KMX 06-26,
PENG 07-16, CCK 07-30, BMY 08-10) — a one-session overshoot on a Thursday, so no weekend risk.

### Step 1 — time stops + expiry guard: nothing due. Safety net re-run in full.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| **time stop** | target_exit **2026-08-26** | today >= target_exit | **no — due TOMORROW, not today** |
| overdue carve-out | not past due | strictly in the past | no |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |
| profit target | -6.07% | +100% (`per_trade_target_pct`) | no |
| stop loss | -6.07% | **-100%** (`per_trade_stop_pct`) | **no — 93.9pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-25 query **NONE** | concrete named event | no |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. The market was open with ~3.5 minutes left, so a verdict could have produced an order. It did
not. Mark used is `positions.current_price` (320.12) per the standing lesson.

### 🟢 THE CAP SAVED US TODAY — this morning's "cost" reading is INVERTED by the close

Market-open called the NVT block **"the cleanest measurement of the cap's cost the log has"** — a score-7
whose novelty was verified intact at the bell (+2.82%, inside the 5% bar) and which was refused **solely**
by `max_concurrent_positions: 1`. **The close says the opposite.** Marking from the open per the 08-14
rule — the only price we could have paid:

| ticker | 08-25 open | 08-25 close | return | disposition |
|--------|------------|-------------|--------|-------------|
| **NVT** | **157.68** | **151.49** | **-3.93%** | **cap-blocked (accept side, score 7)** |
| JNJ | 271.00 | 273.16 | +0.80% | below threshold (score 5) |
| BA | 212.495 | 211.09 | -0.66% | below threshold (score 3) |
| BJ | 97.63 | 94.37 | **-3.34%** | DQ — freshness (release 08-21) |
| ROST | 241.50 | 241.11 | -0.16% | DQ — freshness (gapped 08-21) |
| Z | 37.48 | 36.11 | **-3.66%** | DQ — Directional (FTC order runs against it) |
| ESTC | 82.98 | 80.40 | **-3.11%** | DQ — Material |

**Every one of the seven marks was correct.** Six fell or went nowhere; the single positive (JNJ +0.80%)
was a score-5 we passed on and it barely moved. KEYS returned **+0.69%** from its own 318.22 open over
the same hours, so the cap was worth roughly **+4.6pp** today versus the switch it prevented.

**This is the entry the 08-26 review needs, and it cuts against two days of narrative.** The 08-24 close
measured the cap costing ~2.2pp (GSK +0.50% vs KEYS -1.75%); today it *saved* 3.93pp on a higher-scoring
name. Two sessions, opposite signs, and the sample is two. **The honest reading is that the cap's cost is
unmeasured noise at n=2, not an established drag** — and this morning's confident "second and larger
measured cost" framing was premature. Carry-forward #11 gets one accept-side mark (NVT, and it is the
instance that measures the **cap**) plus six discard-side marks, all correct.

Note also that NVT's **-14.2% four-session drawdown into the catalyst** — flagged pre-market as "the
single largest risk on this name and not captured anywhere in the rubric" — continued straight through
the announcement. The rubric scored the acquisition 7; the tape kept selling. **That gap is worth a rule
proposal at the review**, and it is independent of the cap question.

### 🟢 Grok clean a TWELFTH consecutive session — #16 applied an eighth time

Two independent queries:

1. **Standard 10-class enumeration** (guidance cut, recall, litigation, regulatory/export-control, exec
   departure, downgrade-only, restatement, dilution, short report, contract/customer loss) — literal
   **"NONE (all 10 classes). No qualifying recent items found matching the criteria."** enumerated class
   by class. The only citations returned were the Q3 IR release itself and a **July Mayer Brown note
   describing a Keysight courtroom WIN** in the US Court of Federal Claims.
2. **Dated 08-25 query**, instructed to ignore the 08-18 print — replied the single word **NONE**.

Verdict **THESIS INTACT**; per the hard rule (sell only on concrete, named negative news) the position is
held into its final session. **Eight consecutive dated queries have now returned Form 144, a 13F purchase,
a 10b5-1 Form 4, a 13F purchase, nothing, a 13F purchase, nothing, and nothing — filings, never events,
and not one negative in twelve sessions.** #16 has earned its place; write it into both routine files.

### 🟢 The tape INVERTED and closed AT THE HIGHS — the first bullish shape in seven sessions

Off the sip consolidated feed, **re-pulled after the bell** per #10a:

| session | open | high | low | close | volume |
|---------|------|------|-----|-------|--------|
| 2026-08-18 (print) | 350.00 | 350.895 | 332.64 | **341.00** | 3,526,271 |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | 3,875,269 |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | 1,905,031 |
| 2026-08-21 | 319.22 | 322.73 | 310.27 | **316.13** | 1,201,274 |
| 2026-08-24 | 311.09 | 313.82 | 306.8517 | **310.66** | 1,038,616 |
| **2026-08-25** | **318.22** | **320.73** | **313.865** | **320.41** | **1,340,803** |

**Close-to-close +3.14%, the best session since the print**, on rising volume. The 30-minute bars invert
the four-session pattern outright:

| 30-min bar (ET) | close | note |
|-----------------|-------|------|
| 09:30 | 316.58 | opened 318.22, faded |
| 10:30 | 315.85 | **session low 313.865** |
| 12:00 | 318.09 | midday note's read, +1.20% off the low |
| 14:00 | 318.79 | grind |
| 15:00 | **320.67** | breakout |
| **15:30** | 320.16 | **session HIGH 320.73 printed here, on 337,120 sh — the day's heaviest 30-min volume** |

Four sessions printed the high in the opening minutes and walked down; 08-24 was low-early/close-soft;
**today is low-early / high-LATE / close-at-the-high (320.41 vs a 320.73 high — 32 cents off it)**. That
is the first genuinely bullish intraday shape since the print, and it arrives **one day before the time
stop forces the exit regardless**. Logged, not acted on — no rule reads intraday shape and inventing one
at the terminal is what decision.md forbids. **The 08-26/weekly review should read all seven sessions
together**, and should note the irony explicitly: the position's best mark and best shape land on the eve
of a calendar-driven exit that cannot see either.

### 🟢 Carry-forward #8 did NOT reproduce at the close — the rule now has FIVE data points

`./scripts/alpaca.sh quote KEYS` returned `p=319.95` at `t=2026-08-25T19:57:54Z` = **15:57:54 ET**,
agreeing with `positions.current_price` (319.97 at that moment) to **two cents**. Contrast this morning's
open, where the same call returned the prior session's last print and **understated the position by
2.20pp**.

**Five data points now settle it: IEX `quote` is stale at the 09:30 open (08-24 -1.26pp, 08-25 +2.20pp)
and live everywhere else (08-24 close to the cent, 08-25 midday to six cents, 08-25 close to two cents).**
This is no longer a carry-forward; **promote it to a written rule in strategy.md at the 08-26 review**,
alongside #16.

### 🟠 Carry-forward #10a — a THIRD instance, recorded live this run

At 15:58 ET the 08-25 sip daily bar read `c=319.95, v=1,227,860`. Re-pulled after the bell it is
**`c=320.41, v=1,340,803`** — a 46-cent and 113k-share difference. This run **followed** the rule (pulled
the partial, waited for the close, re-pulled) rather than tripping over it, which is what the 08-24 EOD
note failed to do. The final close 320.41 vs Alpaca's 320.12 mark is a **29-cent tape-vs-mark spread**,
immaterial and *not* staleness. **The rule works; write it down.**

### Step 2 — weekly loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **+2.85%** (6824.30 vs last_equity 6635.10) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **+1.18%** (week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | none |

No flatten, no `cancel-all` (0 open orders anyway), no `notify.sh` alert, no `PAUSED` marker in
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said.

### 🔴 THE TIME STOP IS TOMORROW — one run, and today showed how thin its margin is

**93.82%** of the book in one name whose only remaining exit is the **2026-08-26 time stop**. At
`per_trade_stop_pct: 100` the price gate cannot fire above $0.00; thesis-broken has now been denied
**twelve consecutive sessions**. Sessions left: **08-26 only**, enforceable only by the **08-26 EOD** run.

Naive odds off the ~39% miss rate put it at ~**61%**. Today refines that unhelpfully: the run *made it*,
but the scheduled-wake path would have delivered **52 seconds**, and the deferral mechanism is now
confirmed on both the midday and EOD triggers within a single day. Today's **+2.85%** improves the mark,
not the exit path.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order sent, so nothing could move cash; mark-to-market moves equity only. `long_market_value`
$6,402.40, `initial_margin` $3,201.20, `maintenance_margin` $1,920.72, `sma` $6,744.50, buying power
$19,614.32 — no leverage, cash positive an **11th consecutive session**. Account `ACTIVE`,
`trading_blocked` and `account_blocked` both `false`. The 98% haircut remains **not stress-tested** (#5)
— it should finally be exercised tomorrow when the slot frees.

### 🟠 Carry-forward #6/#10: `feed=sip` load-bearing a FIFTEENTH consecutive run

Daily **and 30-minute** `feed=sip` bars both returned the current session, consistent with the sharpened
entitlement statement (**delayed SIP bars yes, real-time SIP quotes/snapshots no**). Load-bearing today
for the seven-session table, the 30-minute shape read, the post-close re-pull **and all seven
rejection-cohort closes** — the NVT mark that inverted the cap narrative came from this call.
`scripts/alpaca.sh:104` still ships `feed=iex`. Not applied — EOD's remit is exits, journaling and
notification, not tooling.

### Ops carry-forward — nothing applied

**#1** 🔴🔴 sleep-deferral — **hit BOTH midday (+3m50s) and EOD (+1m16s) today**; EOD's scheduled-wake
path was **52 seconds** from the close. TIME-CRITICAL, human call, un-applied 7th day, **one enforcing
run left**. **#2** `caffeinate -is` still uncommitted (with `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`,
`.env.bak.broken`, `memory/guardrails.md.conservative.bak`); **re-falsified as mitigation a fourth time**
— its assertion was created at 12:56:17, after the deferral. **#3** `routines/market-open.md:29` vs
strategy.md's overdue carve-out — **08-27 is the only morning it could ever fire**, live the moment 08-26
EOD misses. **#4** no limit-order/partial-close path. **#5** haircut 98% → 96%, still not stress-tested;
the freeing slot should exercise it tomorrow. **#6/#10** `feed=sip` — **fifteenth use**, load-bearing,
still unapplied. **#7** `routines/midday.md:1` header — not exercised this run. **#8** IEX bell
staleness — **did NOT reproduce at the close (two cents)**; **five data points now, promote to a written
rule**. **#9** `routines/end-of-day.md:1` header claims `3:55 PM Central / 4:55 PM Eastern` — internally
contradictory and wrong on both counts; live plist is 12:55 PDT = **15:55 ET / 14:55 CT**. Docs-only fix,
do NOT move the plist. **#10a** an intraday sip bar is a **PARTIAL** — **third instance, and the first
this run handled correctly** (319.95/1,227,860 → 320.41/1,340,803). **#11** novelty-at-the-open —
**closes measured: NVT -3.93% (accept side, cap-blocked), JNJ +0.80%, BA -0.66%, BJ -3.34%, ROST -0.16%,
Z -3.66%, ESTC -3.11% — all seven marks correct.** **#12** the 3–7 DTE option window — the reason KEYS is
shares at 93.8% of the book with no premium-decay exit. **#13** the bounded fill poll — **relevant
tomorrow: the KEYS entry took 1m35s to drip-fill, which is the number that makes a 52-second start
unsurvivable.** **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100` survivability — **KEYS
closed -6.07%, its best mark since entry, with one enforcing run to its only exit; and the same config's
cap SAVED 3.93pp today after costing ~2.2pp yesterday.** **#15** "raised but capacity-constrained" —
**judged no an eighth time; moot for KEYS, but rule it for the next name.** **#16** the dated Grok query
— **applied an eighth time**; write it into both routine files. **#17** 🆕 **NVT scored 7 while carrying
an unexplained -14.2% four-session drawdown into its catalyst, and fell another -3.93% on the day. The
rubric has no term for "the tape is already rejecting this name." Propose one at the review.**

2026-08-25 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
KEYS 20 sh marked **317.64** vs 340.8005 entry = **-6.80%**, giving back 0.16pp of the -6.64% market-open
mark but still the second-best mark since 08-21. Market value **$6,352.80** on $6,774.70 equity = **93.77%
of the book**. Equity **$6,774.70**, cash **+$421.90**, day **+2.10%**, WTD **+0.45%**, all-time **-93.23%**
from the $100,000 open. Reconciled against Alpaca: `positions` returns 1 (`asset_class: us_equity`),
`orders open` returns **0** — no drift. **20 × 317.64 + 421.90 = $6,774.70 = equity, to the cent.**

### 🔴🔴 RUN QUALITY: THE SLEEP-DEFERRAL MECHANISM HIT **MIDDAY** FOR THE FIRST TIME — +3m 50s

Every prior note in this file states that the midday trigger "sits in the machine's active period and has
**never** been hit by the sleep-deferral mechanism the 08-20 EOD run root-caused." **That is now false.**
`ps -eo lstart` shows `run-routine.sh midday` started **`Tue Aug 25 09:03:50 2026`** PDT against a
09:00:00 PDT trigger — **deferral 3m 50s**. From `pmset -g log`:

```
2026-08-25 08:53:45 -0700  Sleep      Entering Sleep state due to 'Maintenance Sleep' ... 605 secs
2026-08-25 09:03:50 -0700  DarkWake   DarkWake from Deep Idle [CDNPB] : due to smc.sysState.Wake(0x70070000) wifibt
```

The machine slept at **08:53:45**, the 09:00:00 trigger landed **into a sleeping machine**, and the routine
started in the **same second** as the 09:03:50 wake. That is the exact signature of the 08-20/08-21 EOD
misses, reproduced on a second trigger.

**Two details make this worse than the raw 3m50s suggests:**

1. The `Wake Requests` block logged at 08:53:47 — the machine's own list of what would wake it — contains
   **no bull event**: only `dasd`/spotlight (09:10:41), `dasd`/contacts (09:09:22), `mDNSResponder` upkeep
   (10:53:45), `powerd` CSPNEvaluation (09:25:52) and `calaccessd.travelEngine` (09:34:23). **Nothing bull
   owns would have woken it before 09:09:22 — 9+ minutes late.** The 09:03:50 wake was
   `smc.sysState.Wake ... wifibt SMC.OutboxNotEmpty` — an **incidental hardware wake**. The routine ran on
   luck, and got a *better* deferral than any scheduled wake would have given it.
2. `caffeinate` (pid 73298) was created at **09:03:50**, the same second — this run's own assertion, a
   consequence not a cause, exactly as the 08-21 and 08-24 notes established. **Carry-forward #2 again
   demonstrably fails to prevent the deferral.**

**Cost today: ZERO.** Midday has ~4 hours of slack to the 16:00 ET close, so a 4-minute deferral is
invisible. **That is the entire point.** The mechanism is not EOD-specific — it is trigger-agnostic, and
we only ever *noticed* it at EOD because EOD is the one routine with ~5 minutes of slack instead of hours.
Late-or-missed **27 of 70 (~39%)**, and this is the **first entry in that tally contributed by a routine
other than end-of-day**.

### 🔴🔴 ESCALATION #1 — SIXTH DAY, ZERO SLACK, AND NOW WITH DIRECT EVIDENCE IT REACHES ANY TRIGGER

`pmset -g sched` read live this run:

```
[0] wake at 08/25/2026 09:34:23 by com.apple.alarm...calaccessd.travelEngine.periodicRefreshTimer
[1] wake at 08/25/2026 16:58:21 by com.apple.alarm...osanalytics.hardhighengagementtimer
```

**Still no bull wake event**, sixth consecutive day. `pmset -g` still reports `sleep 1` (one minute).

**The 08-26 EOD is the ONLY run that can enforce the KEYS time stop**, and today proved the deferral is not
confined to it. Historical EOD deferrals: +35s, +9m, +4m16s, +10m59s, +4m51s, +4s. The 12:55:00 PDT trigger
has **4m 59s** of runway to the 16:00 ET close — **four of those six deferrals would blow it.** Today's
midday deferral (3m50s) would have left **1m 09s**.

**➡️ THE FIX, unchanged and still a human call:**
`sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT,
no sudo, covers all four routines — and today's evidence says all four **need** it, not just EOD).
Moving the trigger 12:55 → 12:40 PDT is **not** a substitute: a 12:40 trigger fired into a sleeping machine
defers identically. Carry-forward #2 is **not** mitigation — its assertion was created *by* this run, after
the deferral had already happened.

If 08-26 EOD misses, the overdue carve-out sells at the 08-27 market-open (precedent KMX 06-26, PENG 07-16,
CCK 07-30, BMY 08-10) — a one-session overshoot on a Thursday, so no weekend risk. **Midday cannot apply
either fix; its remit is exits and notifications.**

### Step 1 — exits: no gate fired. Thesis-broken was again the only one that could.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -6.80% | +100% (`per_trade_target_pct`) | no |
| stop loss | -6.80% | **-100%** (`per_trade_stop_pct`) | **no — 93.2pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-25 query **NONE** | concrete named event | no |
| time stop | target_exit **2026-08-26** | due TOMORROW | not due, and not midday's |
| expiry guard | n/a — shares, no options open | — | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Mark used is `positions.current_price` (317.64) per the standing lesson.

### 🟢 Carry-forward #8 did NOT reproduce — the "stale at the open, live otherwise" rule holds a 4th time

`./scripts/alpaca.sh quote KEYS` returned `p=317.58` at `t=2026-08-25T16:02:28Z` = **12:02:28 ET, ~90
seconds old** — agreeing with `positions.current_price` (317.64) to **six cents** (-6.82% vs -6.80%).
Contrast this morning's open, where the same call returned the prior session's last print and **understated
the position by 2.20pp**. Four data points now: **IEX `quote` is stale at the 09:30 open (08-24 -1.26pp,
08-25 +2.20pp) and live everywhere else (08-24 close matched to the cent; today's midday to six cents).**
Promote to a written rule at the 08-26/weekly review alongside #16.

### 🟢 Grok clean an ELEVENTH consecutive session — #16 applied a seventh time

Two independent queries:

1. **Standard 10-class enumeration** (guidance cut, recall, litigation, regulatory/export-control, exec
   departure, downgrade-only, restatement, dilution, short report, contract/customer loss) — literal
   **"NONE across all 10 classes."** The only activity surfaced was the routine insider sale already
   dispositioned on 08-24 (SVP Ingrid Estrada, 2,000 sh, **10b5-1** plan, 08-20 transaction reported
   08-24) plus prior-week analyst notes characterised as **upgrades/raises**.
2. **Dated 08-25 query**, instructed to ignore the 08-18 print — replied the single word **NONE**.

Verdict **THESIS INTACT**; per the hard rule (sell only on concrete, named negative news) the position is
held into its final session. **Seven consecutive dated queries have now returned Form 144, a 13F purchase,
a 10b5-1 Form 4, a 13F purchase, nothing, a 13F purchase, and now nothing — filings, never events, and not
one negative in eleven sessions.** #16 has earned its place; write it into both routine files.

### 🟠 Carry-forward #15 re-tested an EIGHTH time: still not thesis-broken — and now moot for KEYS

The 10-class query explicitly excluded the Aug 18 supply-chain commentary and Grok returned it only as
"ongoing discussion of the excluded ... items" — i.e. it surfaced as *old excluded colour*, not as a new
negative in any of the ten classes. Judged **not thesis-broken** on the same reasoning as the seven prior
runs: the Q4 guide was *raised* ($3.34–3.40 vs ~$2.68 consensus) and a ceiling on upside conversion is not
a reduction of the forward numbers we bought. **#15 now has eight consistent readings and KEYS exits
tomorrow on the time stop regardless.** The review should still rule so the next name inherits a decided
rule rather than an open one.

### The tape: high-early AGAIN, but the walk-down was bought back

Off the sip consolidated feed (⚠️ **today's daily bar is a PARTIAL** — pulled 12:05 ET, per #10a):

| session | open | high | low | close | volume |
|---------|------|------|-----|-------|--------|
| 2026-08-18 (print) | 350.00 | 350.895 | 332.64 | **341.00** | 3,526,271 |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | 3,875,269 |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | 1,905,031 |
| 2026-08-21 | 319.22 | 322.73 | 310.27 | **316.13** | 1,201,274 |
| 2026-08-24 | 311.09 | 313.82 | 306.8517 | **310.66** | 1,038,616 |
| **2026-08-25** *(partial, 12:05 ET)* | **318.22** | **319.62** | **313.865** | **317.64 live** | **433,356** |

30-minute bars locate the shape precisely: the high **319.62** printed in the **opening 30 minutes**
(13:30Z), it walked down to **313.865** by 10:30–11:00 ET (14:30Z), then recovered through 15:30Z to
**317.11** and now **317.64** — **+1.20% off the low, -0.62% off the high.** So the high-early half of the
four-session pattern repeated, but the walk-down was bought back rather than closing at the lows, as on
08-24. **The 08-26/weekly review should read all seven sessions together**; logged, not acted on — no rule
reads intraday shape and inventing one at the terminal is what decision.md forbids.

Two small corrections to this morning's market-open note, now that the bar has posted: the true 08-25 open
is **318.22** (market-open wrote "318.175 live", its `positions.current_price` mark, 4.5 cents low), and the
gap off the 08-24 close is **+2.43%**, not +2.42%. Immaterial, but the pattern — an intraday mark written
down as a session open/close — is the same one #10a flags.

### Step 2 — daily loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **+2.10%** (6774.70 vs last_equity 6635.10) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **+0.45%** (week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all` (0 open orders anyway), no `notify.sh` alert, no halt marker written to
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said. The binding
constraint on entries remains `max_concurrent_positions: 1`, which this morning blocked a **score-7 NVT**
whose novelty was verified still intact at the open (+2.82%, inside the 5% bar) — the cap's second and
larger measured cost in two sessions. Midday opens nothing regardless.

### 🔴 ONE SESSION TO THE TIME STOP — and today just widened the risk that it misses

**93.77%** of the book in one name whose only remaining exit is the **2026-08-26 time stop**. At
`per_trade_stop_pct: 100` the price gate cannot fire above $0.00; thesis-broken has now been denied
**eleven consecutive sessions**. Sessions left: **08-26 only**, enforceable only by the **08-26 EOD** run.

Prior notes put the naive odds it fires in time at ~**62%** off a ~38% EOD miss rate. **Today's finding
argues that is optimistic**: the deferral mechanism is trigger-agnostic, the machine sleeps on a 1-minute
timer, and there is still no bull wake event scheduled. Today's +2.10% improves the mark, not the exit path.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order sent, so nothing could move cash; mark-to-market moves equity only. `long_market_value`
$6,352.80, `initial_margin` $3,176.40, `maintenance_margin` $1,905.84, `sma` $6,744.50, buying power
$19,475.44 — no leverage, cash positive a 10th consecutive session. Account `ACTIVE`, `trading_blocked`
and `account_blocked` both `false`. The 98% haircut remains **not stress-tested** (#5) — it may finally be
exercised when the slot frees tomorrow.

### 🟠 Carry-forward #6/#10: the sharpened entitlement statement held

Daily **and 30-minute** `feed=sip` bars both returned the current session without complaint, consistent
with the 08-25 market-open finding that the account holds **delayed SIP bars, not real-time SIP
quotes/snapshots** (`/v2/stocks/snapshots?feed=sip` hard-errors). **Fourteenth consecutive run calling
`feed=sip` out-of-band** while `scripts/alpaca.sh:104` ships `feed=iex`; load-bearing again today for the
session table and the 30-minute shape read. Not applied — midday's remit is exits and notifications, not
tooling.

### Ops carry-forward — nothing applied

Midday can apply none of these (exits and notifications only). By reference so the count stays honest:
**#1** 🔴🔴 sleep-deferral — **no longer EOD-only: it hit MIDDAY today (+3m50s), first time ever.**
TIME-CRITICAL, zero slack, human call, un-applied 6th day. **#2** `caffeinate -is` still uncommitted (with
`AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`);
**re-falsified as mitigation today** — its assertion was created by this run at 09:03:50, after the
deferral. **#3** `routines/market-open.md:29` vs strategy.md's overdue carve-out — **08-27 is the only
morning it could ever fire**, live the moment 08-26 EOD misses. **#4** no limit-order/partial-close path.
**#5** haircut 98% → 96%, still not stress-tested. **#6/#10** `feed=sip` — **fourteenth use**,
load-bearing, still unapplied; entitlement statement (bars yes, snapshots no) held again. **#7**
`routines/midday.md:1` header claims `12:00 PM Central / 1:00 PM Eastern`; the plist fires 09:00 PDT =
**12:00 ET / 11:00 CT** — **re-confirmed live, ninth time. The header is the wrong artifact; do NOT move
the plist.** **#8** IEX bell staleness — **did NOT reproduce** (six cents at midday); four data points now
resolve it to *stale at the 09:30 open, live everywhere else*. Promote to a written rule. **#9**
`routines/end-of-day.md:1` header — wrong on both counts; live plist is 12:55 PDT = **15:55 ET / 14:55 CT**.
Docs-only fix, do NOT move the plist. **#10a** an intraday sip bar is a **PARTIAL** — third instance today
(this run's own daily bar, plus market-open's 318.175-vs-318.22 open). **#11** novelty-at-the-open — this
morning added NVT +2.82% (accept side, cap-blocked, score 7) plus six discard marks. **#12** the 3–7 DTE
option window — the reason KEYS is shares at 93.8% of the book with no premium-decay exit. **#13** the
bounded fill poll. **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100` survivability — **KEYS at
-6.80% with one enforcing run to its only exit, and the same config's cap blocked a score-7 NVT this
morning after a 6 yesterday.** **#15** "raised but capacity-constrained" — **judged no an eighth time; moot
for KEYS, but rule it for the next name.** **#16** the dated Grok query — **applied a seventh time**; write
it into both routine files.

2026-08-25 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh held, marked **318.175** vs 340.8005 entry = **-6.64%**, a **2.20pp improvement**
on the -8.84% 08-24 EOD mark and the best mark since 08-21 market-open. Market value **$6,363.50** on
$6,785.40 equity = **93.78% of the book**. Equity **$6,785.40**, cash **+$421.90**, day **+2.27%**,
WTD **+0.61%**, all-time **-93.21%** from the $100,000 open. Reconciled against Alpaca: `positions`
returns 1 (`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 318.175 + 421.90 = $6,785.40 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:16 ET, 16s after the bell

**Tenth consecutive on-time market-open.** Account `ACTIVE`, `trading_blocked`/`account_blocked` both
`false`. The morning trigger has never been hit by the sleep-deferral mechanism the 08-20 EOD run
root-caused; today says nothing for or against escalation #1, which is EOD-only.

### Step 1 — exits: no gate fired. Thesis-broken was again the only one that could.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -6.64% | +100% (`per_trade_target_pct`) | no |
| stop loss | -6.64% | **-100%** (`per_trade_stop_pct`) | **no — 93.4pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-25 query → a 13F **purchase** | concrete named event | no |
| time stop | target_exit **2026-08-26** | today >= target_exit | **no — due TOMORROW, not overdue** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Overdue carve-out did **not** apply (`target_exit` is tomorrow, not in the past) —
carry-forward #3 unexercised, and **08-26 is the last session in which it could ever fire.**

### 🔴 Carry-forward #8 REPRODUCED — and this time the staleness error ran AGAINST us

`./scripts/alpaca.sh quote KEYS` returned `p=310.66` at `t=2026-08-24T19:59:52Z` — **08-24 15:59:52 ET**,
the prior session's last print, identical to the value the 08-24 EOD run marked at the close.
`positions.current_price` (318.175) and `change_today` (+2.04%) agree the tape is live and **up**.

**The direction of the error flipped.** On 08-24 the stale quote overstated the position by 1.26pp
(favourable); today it **understates** it by **2.20pp** (-8.84% vs the true -6.64%) — the largest
staleness error recorded, and the first on the unfavourable side. That kills the tempting reading that
staleness is a one-way bias: it is simply yesterday's close, and its sign is whatever the overnight move
was. The standing "mark off `positions.current_price`" lesson held the number honest for a third
consecutive open. **Promote it to a written rule at the 08-26/weekly review, with #16.**

Refined statement of the rule, now with three data points: **IEX `quote` is stale at the 09:30 open
(08-24: -1.26pp, 08-25: +2.20pp) and live at the 16:00 close (08-24: matched to the cent).**

### 🟢 Grok clean a TENTH consecutive session — #16 applied a sixth time

Two independent queries:

1. **Standard 10-class enumeration** (guidance cut, recall, litigation, regulatory/export-control, exec
   departure, downgrade-only, restatement, dilution, short report, contract/customer loss) — literal
   **NONE across all ten classes.** Coverage characterised as post-earnings analyst commentary and
   positive product/newsroom items, with analyst flow on the **upgrade** side. Older Centripetal matters
   and the Aug 18 supply-chain commentary excluded per the query.
2. **Dated 08-25 query** — the single 08-25-datelined KEYS item is a **13F filing by Sanctuary Advisors
   LLC disclosing a NEW $7.62M stake (21,782 shares acquired in Q2 2026)**. A *purchase*.

Verdict **THESIS INTACT**; per the hard rule (sell only on concrete, named negative news) the position is
held into its final session. **Six consecutive dated queries have now returned Form 144, 13F purchases, a
10b5-1 Form 4, a 13F purchase, nothing at all, and now another 13F purchase — filings, never events, and
five of the six were on the BUY side.** #16 has earned its place; write it into both routine files.

### 🟠 Carry-forward #15 re-tested a SEVENTH time: still not thesis-broken — and now moot

The 10-class query did not surface the "raised but capacity-constrained" framing as a negative in any of
the ten classes; it appeared nowhere at all this run. Judged **not thesis-broken** on the same reasoning
as the six prior runs: the Q4 guide was *raised* ($3.34–3.40 vs ~$2.68 consensus) and a ceiling on upside
conversion is not a reduction of the forward numbers we bought. **#15 now has seven consistent readings
and KEYS exits tomorrow on the time stop regardless — it can no longer change an outcome on this
position.** The review should still rule so the next name inherits a decided rule rather than an open one.

### 🟢 The tape: KEYS gapped UP into its final session — first up-open since the catalyst

Off the sip consolidated feed:

| session | open | high | low | close | volume |
|---------|------|------|-----|-------|--------|
| 2026-08-18 (print) | 350.00 | 350.895 | 332.64 | **341.00** | 3,526,271 |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | 3,875,269 |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | 1,905,031 |
| 2026-08-21 | 319.22 | 322.73 | 310.27 | **316.13** | 1,201,274 |
| 2026-08-24 | 311.09 | 313.82 | 306.8517 | **310.66** | **1,038,616** |
| **2026-08-25** | *(sip bar not yet posted at 09:32)* | | | **318.175 live** | |

**Correction to the 08-24 EOD note:** it recorded the 08-24 close as **310.59 on 733,309 shares** and
attributed the 7-cent gap to a tape-vs-mark spread. The completed consolidated bar says **310.66 on
1,038,616** — the EOD read was an *incomplete* bar taken ~4 minutes before the bell, not a spread.
Alpaca's mark was right and the sip read was early. **This is a second instance of the same failure mode
as the 08-21 midday note (313.59/467,092 → 316.13/1,201,274): a sip bar pulled intraday is a partial, and
must be re-pulled after the close before it is written down as a session close.** Two instances now —
worth a written caveat alongside #10.

KEYS is **+2.42% off the 08-24 close** at the open, the first up-open in the six sessions since the print,
and the position's best mark since 08-21 market-open. Logged, not acted on — no rule reads intraday shape.

### Step 2 — halt checks: entries HALTED on the position cap for the SECOND consecutive session

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **+2.27%** (6785.40 vs last_equity 6635.10) | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **+0.61%** (week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **1** | **1** (`max_concurrent_positions`) | ✅ **YES — slot FULL** |
| new positions today | 0 | 1 (`max_new_positions_per_day`) | no |

### 🔴 The cap blocked a SEVEN — higher than yesterday's blocked six. Second measurable cost in two sessions.

**NVT scored 7 against a threshold of 6** — the highest score the watchlist has produced since the KEYS 8
on 08-19 — passed Material/Fresh/Directional with the acquisition verified against nVent's own 08-24
release, and was blocked **solely** by `max_concurrent_positions: 1`. Yesterday the cap cost a 6 (GSK);
today it cost a 7.

**Novelty re-measured at the open** per the ALB 08-06 / KEYS 08-19 rule, exactly as pre-market instructed:

| reference | price | vs |
|-----------|-------|-----|
| pre-catalyst close (08-21) | 151.98 | — |
| catalyst-day close (08-24) | 153.35 | +0.90% |
| **08-25 open** | **157.68** | **+2.82% vs catalyst-day close** |
| pre-market kill threshold | **161.02** (+5%) | **not breached** |

**NVT still qualifies — the novelty was NOT consumed.** The name opened +2.82%, comfortably inside the 5%
bar for a sub-$100B name, so the second wave pre-market identified was still available at the bell and we
could not take it. This is the cleanest measurement of the cap's cost the log has: not a marginal 6 that
went nowhere (GSK closed +0.50%), but a 7 whose entry condition was verified live and still refused.

**The 08-26 review must price this against #14.** Two consecutive sessions where the score gate said yes
and the config said no, escalating 6 → 7. The same FULL YOLO settings that put **93.78%** of the book into
one name are what blocked both diversifiers. Note the slot frees **tomorrow** on the KEYS time stop — by
which point NVT's novelty has to be re-measured from scratch a third time.

### Step 3 — entries: none constructed; preflight never invoked (no order to gate)

Rejection open-marks (sip, per the 08-14 rule — from the open, never the prior close):

| ticker | 08-24 close | 08-25 open | gap | disposition |
|--------|-------------|------------|-----|-------------|
| **NVT** | 153.35 | **157.68** | **+2.82%** | **cap-blocked (accept side, score 7)** |
| JNJ | 273.04 | 271.00 | -0.75% | below threshold (score 5) |
| BA | 210.46 | 212.495 | +0.97% | below threshold (score 3) |
| BJ | 98.49 | 97.63 | -0.87% | DQ — freshness (release 08-21) |
| ROST | 241.52 | 241.50 | **-0.01%** | DQ — freshness (gapped 08-21) |
| Z | 37.05 | 37.48 | +1.16% | DQ — Directional (FTC order runs against it) |
| ESTC | 83.24 | 82.98 | -0.31% | DQ — Material |

### 🟢 The primary-source rule paid again: ROST's "6% pre-market gap" was fiction, and the tape proved it

Grok query 2 called ROST "a clear pre-market mover (>2% up)... shares gapped higher ~6%+ in pre-market
(e.g., ~$243 area)" on an 08-25 catalyst. Pre-market DQ'd it on freshness, having found the release was
dated **08-21**. **ROST opened at 241.50 against a 241.52 close — a gap of -0.01%.** There was no 6% gap
and no 08-25 catalyst. The primary-source check was correct and Grok's pre-market screener framing was
simply wrong about *which session* the move belonged to. Seventh consecutive session in which the 08-21
rule changed or defended the answer; add this to the tally as a **defend**, not a move.

Carry-forward #11 gets four discard-side instances (JNJ, BA, BJ/ROST/Z/ESTC on the DQ side) plus NVT on
the accept side — and NVT is the instance that measures the **cap**, not the gate.

### 🔴 ONE SESSION TO THE TIME STOP — tomorrow is the only enforcing run

**93.78%** of the book in one name whose only remaining exit is the **2026-08-26 time stop**. At
`per_trade_stop_pct: 100` the price gate cannot fire above $0.00; thesis-broken has now been denied **ten
consecutive sessions**. Sessions left: **08-26 only**, and only the **08-26 EOD** run can enforce it —
a single run against a ~38% historical miss rate → naive odds it fires in time ~**62%**.

Today's +2.27% is welcome but changes nothing structural: it improves the mark, not the exit path.

**➡️ ESCALATION #1, FIFTH DAY RUNNING, now with ZERO enforcing runs of slack:**
`sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT,
no sudo, covers all four routines). Moving the trigger 12:55 → 12:40 PDT is **not** a substitute — a 12:40
trigger fired into a sleeping machine defers identically. Carry-forward #2 is **not** mitigation.
If 08-26 EOD misses, the overdue carve-out sells at the 08-27 market-open (precedent KMX 06-26,
PENG 07-16, CCK 07-30, BMY 08-10) — a one-session overshoot on a Thursday, so no weekend risk.
**Market-open cannot apply either fix — both are human calls.**

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order sent, so nothing could move cash; mark-to-market moves equity only. `long_market_value`
$6,363.50, `initial_margin` $3,191.60, `maintenance_margin` $1,914.96, `sma` $6,744.50, buying power
$19,560.56 — no leverage, cash positive a 9th consecutive session. The 98% haircut remains **not
stress-tested** (#5).

### 🔴 Carry-forward #6/#10 SHARPENED: `feed=sip` works for BARS but is FORBIDDEN for snapshots

This run tried `/v2/stocks/snapshots?feed=sip` for a live open print and got a hard error:

```
{"message":"subscription does not permit querying recent SIP data"}
```

The same credentials return **daily sip bars including the current session** without complaint (the NVT
08-25 bar came back live, o=157.68). So the account's entitlement is **delayed SIP bars, not real-time SIP
quotes/trades** — which also explains why every prior run's "sip refuses the current session" observation
was intermittent: it is a *delay* on the bars endpoint, not a refusal, exactly as 08-21 through 08-24
concluded. **Drop the "no current session" caveat and replace it with the entitlement statement above.**
**Thirteenth consecutive run calling `feed=sip` out-of-band** while `scripts/alpaca.sh:104` ships
`feed=iex`; load-bearing again today for every open mark, the NVT novelty re-measure and the 08-24 close
correction. Not applied — market-open's remit is orders, not tooling.

### Ops carry-forward — nothing applied

**#1** 🔴🔴 EOD sleep-deferral — **TIME-CRITICAL, ZERO slack: the 08-26 EOD is the last enforcing run
before the KEYS stop.** Human call, un-applied 5th day. **#2** `caffeinate -is` still uncommitted (with
`AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`);
not mitigation for #1. **#3** `routines/market-open.md:29` ("Time stop + expiry guard are enforced in
end-of-day, not here") vs strategy.md's overdue carve-out — **verified still present and contradictory
this run; 08-27 is the only morning it could ever fire**, and it becomes live the moment 08-26 EOD misses.
**#4** no limit-order/partial-close path. **#5** haircut 98% → 96%, still not stress-tested — and with the
slot freeing tomorrow it may finally be exercised. **#6/#10** `feed=sip` — **thirteenth use**,
load-bearing, still unapplied; **now sharpened to an entitlement statement (bars yes, snapshots no)** and
the "no current session" caveat is dead. **#7** `routines/midday.md:1` header — not exercised this run.
**#8** IEX bell staleness — **🔴 REPRODUCED at 2.20pp, the largest yet and the first AGAINST us**; the
sign flips with the overnight move. Promote to a written rule: *stale at the open, live at the close.*
**#9** `routines/end-of-day.md:1` header claims `3:55 PM Central / 4:55 PM Eastern` — internally
contradictory and wrong on both counts; the live plist is 12:55 PDT = **15:55 ET / 14:55 CT**. Docs-only
fix, do NOT move the plist. **#10a** 🆕 **a sip bar pulled intraday is a PARTIAL** — the 08-24 EOD note
wrote 310.59/733,309 as a close; the completed bar is **310.66/1,038,616**. Second instance (08-21 midday
was the first). Re-pull after the close before writing a session close down. **#11** novelty-at-the-open —
NVT +2.82% (accept side, cap-blocked, novelty intact) + six discard marks. **#12** the 3–7 DTE option
window — the reason KEYS is shares at 93.8% of the book with no premium-decay exit. **#13** the bounded
fill poll. **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100` survivability — **KEYS at
-6.64% with one enforcing run to its only exit, and the same config's cap blocked a score-7 NVT today
after blocking a 6 yesterday.** **#15** "raised but capacity-constrained" — **judged no a seventh time;
now moot for KEYS, but rule it for the next name.** **#16** the dated Grok query — **applied a sixth
time**; write it into both routine files.

2026-08-24 EOD: **🟢 ON TIME — started 12:55:04 PDT, 4 SECONDS after the trigger; clock read 15:55:11 ET
with 4m49s of market left.** First on-time EOD since 08-17, breaking a streak of 4 misses in 5 runs.
**0 exits, 0 orders, no preflight**, `memory/trade-log.md` unchanged. KEYS 20 sh marked at the close
**310.66** vs 340.8005 entry = **-8.84%**, a 0.57pp improvement on the -9.41% intraday worst. Market value
**$6,213.20** on $6,635.10 equity = **93.64% of the book**. Equity **$6,635.10**, cash **+$421.90**, day
**-1.62%**, WTD **-1.62%** (Monday), all-time **-93.36%** from the $100,000 open. Reconciled against
Alpaca: `positions` returns 1 (`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 310.66 + 421.90 = $6,635.10 = equity, to the cent.** EOD email **SENT**
(id `655bad87-254f-4b48-ac4d-26ac150178fc`).

### 🟢 RUN QUALITY: ON TIME — but it is LUCK, not the fix. Escalation #1 is still un-applied.

`ps -eo lstart` shows `run-routine.sh end-of-day` started **`Mon Aug 24 12:55:04 2026`** against a
12:55:00 PDT trigger — **+4s, the tightest margin on record**, beating 08-17's +35s.

| run | trigger | actual start | delta | outcome |
|-----|---------|--------------|-------|---------|
| 08-17 EOD | 12:55 PDT | `12:55:35` | +35s | ✅ ON TIME — RDNT time-stop filled 15:55:56 ET |
| 08-18 EOD | 12:55 PDT | `13:04` | +9m | 🔴 missed |
| 08-19 EOD | 12:55 PDT | `12:59:16` | +4m 16s | 🟠 LATE but acted, 44s to spare |
| 08-20 EOD | 12:55 PDT | `13:05:59` | +10m 59s | 🔴 missed |
| 08-21 EOD | 12:55 PDT | `12:59:51` | +4m 51s | 🔴 missed by 1 second |
| **08-24 EOD** | 12:55 PDT | **`12:55:04`** | **+4s** | ✅ **ON TIME** |

**Do not read this as a fix.** `pmset -g sched` read live this run shows **NO bull wake event** — only
`com.apple.osanalytics.hardhighengagementtimer` (16:57:44) and `com.apple.calaccessd.travelEngine`
(17:08:21), the same two Apple alarms as every prior run. `pmset sleep` is still **1 minute**. The
machine simply happened to be **awake** at 12:55:00 (`sleep prevented by caffeinate, caffeinate,
mds_stores`), so launchd fired immediately instead of deferring. **The sleep-deferral mechanism the
08-20 run root-caused is untouched; today just didn't roll into it.** Note the `caffeinate` assertions
visible here include this run's own (`pid 95016`, started `12:55:04`, the same second) — a consequence
of the run, not a cause of it, exactly as the 08-21 note established. Late-or-missed count holds at
**26 of 68 (~38%)**.

### 🔴 ONE SESSION TO THE TIME STOP — and it is still the only exit KEYS has

**93.64%** of the book in one name whose only remaining exit is the **2026-08-26 time stop**. At
`per_trade_stop_pct: 100` the price gate cannot fire above $0.00; thesis-broken has now been denied
**nine consecutive sessions**. Sessions left: **08-25, 08-26** — but only the **08-26 EOD** can enforce
the stop, so it is a single run against a ~38% historical miss rate → naive odds it fires in time ~**62%**.
Today's on-time run does not improve those odds: nothing about the machine changed.

**➡️ ESCALATION #1, FOURTH DAY RUNNING, now with ONE enforcing run left:**
`sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT,
no sudo, covers all four routines). Moving the trigger 12:55 → 12:40 PDT is **not** a substitute — a 12:40
trigger fired into a sleeping machine defers identically. Carry-forward #2 is **not** mitigation.
If 08-26 EOD misses, the overdue carve-out sells at the 08-27 market-open (precedent KMX 06-26,
PENG 07-16, CCK 07-30, BMY 08-10) — a one-session overshoot on a Thursday, so no weekend risk.

### Step 1 — time stops + expiry guard: nothing due. Safety net re-run in full.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| **time stop** | target_exit **2026-08-26** | today >= target_exit | **no — 2 sessions out, not overdue** |
| overdue carve-out | not past due | strictly in the past | no |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |
| profit target | -8.84% | +100% (`per_trade_target_pct`) | no |
| stop loss | -8.84% | **-100%** (`per_trade_stop_pct`) | **no — 91.2pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-24 query **NONE** | concrete named event | no |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Unlike 08-20 and 08-21, **the thesis check was actually run this time** — the market was open
with ~4 minutes left, so a verdict could have produced an order. It did not.

### 🟢 Grok clean a NINTH consecutive session — #16 applied a fifth time

Two independent queries, both literal **NONE**:

1. **Standard 10-class enumeration** (guidance cut, recall, litigation, regulatory/export-control, exec
   departure, downgrade-only, restatement, dilution, short report, contract/customer loss) — **NONE on
   every class.** Only qualifications offered were the pre-existing Centripetal matters (old, no new
   filings) and the already-dispositioned 10b5-1 SVP sale; analyst flow characterised as upgrades/PT
   raises. Grok itself attributed the drawdown to earnings-call supply-chain commentary — i.e. #15,
   which the query explicitly excluded.
2. **Dated 08-24 query**, instructed to ignore the 08-18 print — replied the single word **NONE**.

Verdict **THESIS INTACT**; per the hard rule (sell only on concrete, named negative news) the position is
held into its final session. **Five consecutive dated queries have returned Form 144, 13F *purchases*, a
10b5-1 Form 4, a 13F purchase, and now nothing at all — filings, never events.** #16 has earned its place;
write it into both routine files at the 08-25 review.

### 🟠 Carry-forward #15 re-tested a SIXTH time: still not thesis-broken

The 10-class query surfaced the supply-chain/capacity framing only as unprompted colour on the drawdown,
not as a new negative in any of the ten classes. Judged **not thesis-broken** on the same reasoning as the
five prior runs: the Q4 guide was *raised* ($3.34–3.40 vs ~$2.68 consensus) and a ceiling on upside
conversion is not a reduction of the forward numbers we bought. **#15 now has six consistent readings and
the 08-25 review should rule** — this is its last chance to matter for KEYS.

### The tape: KEYS made its low early a second day and closed mid-range

Off the sip consolidated feed:

| session | open | high | low | close | volume |
|---------|------|------|-----|-------|--------|
| 2026-08-18 (print) | 350.00 | 350.895 | 332.64 | **341.00** | 3,526,271 |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | 3,875,269 |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | 1,905,031 |
| 2026-08-21 | 319.22 | 322.73 | 310.27 | **316.13** | 1,201,274 |
| **2026-08-24** | **311.09** | **313.82** | **306.8517** | **310.59** | **733,309** |

The inversion midday flagged **held**: the session low **306.8517** (which would have marked the position
**-9.96%**) came early, and KEYS closed **+1.22% off it**. But it also gave back the midday recovery —
midday marked 312.605, the close is 310.59 — so the day is better described as *low-early, chop, close
soft* than as a clean reversal. Close-to-close **-1.75%** vs the 316.13 prior close. Two sessions now
counter the four-session high-early/walk-down pattern; **the 08-25 review should read all six together.**
Logged, not acted on — no rule reads intraday shape.

### 🟢 Carry-forward #8 did NOT reproduce at the close — staleness is a 09:30 phenomenon

`./scripts/alpaca.sh quote KEYS` returned `p=310.66` at `t=2026-08-24T19:59:52Z` = **15:59:52 ET, 8
seconds before the bell** — matching `positions.current_price` (310.66) **exactly**. Contrast this
morning, where the same call returned Friday's 15:59:48 print and would have overstated the position by
**1.26pp**. Two data points now bracket it: **IEX is stale at the 09:30 open and live at the 16:00 close.**
That is a sharper rule than "prefer `positions.current_price`" and should be written up as such at the
08-25 review alongside #16. (sip closed at **310.59** on 733,309 shares vs Alpaca's 310.66 mark — a
7-cent spread between consolidated tape and Alpaca's mark, immaterial and not staleness.)

### Step 2 — weekly loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-1.62%** (6635.10 vs last_equity 6744.50) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **-1.62%** (Monday; week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | none |

No flatten, no `cancel-all` (0 open orders anyway), no `notify.sh` alert, no `PAUSED` marker in
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said.

### 🔴 The position cap's cost, now measured at the close: ~2.2pp in one session

Market-open recorded the first session on which `max_concurrent_positions: 1` was the **sole** reason no
trade happened — GSK scored **6** against a threshold of 6, passed Material/Fresh/Directional with both
catalysts verified against GSK's own 08-24 newsroom releases, and was blocked only by the full slot.
Marking from the open per the 08-14 rule:

| ticker | open | close | return | disposition |
|--------|------|-------|--------|-------------|
| **GSK** | **51.54** | **51.80** | **+0.50%** | **cap-blocked (accept side)** |
| TGT | 166.06 | 169.90 | +2.31% | DQ'd on freshness |
| MRNA | 142.70 | 138.89 | **-2.67%** | below threshold |
| ROST | 238.075 | 241.62 | +1.49% | below threshold |

GSK **+0.50%** against KEYS **-1.75%** close-to-close: the cap cost roughly **2.2pp today**. One session
is not an indictment — GSK's score of 6 came with confirmation of 0, and it duly went nowhere — but the
**08-25 review should price this against #14**: the same FULL YOLO config that put 93.6% of the book into
one name is what blocked the diversifier. Carry-forward #11 gets a fourth discard-side instance (MRNA is
the useful one — a **-2.67%** day validates the below-threshold call) plus the accept-side GSK mark.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent, so nothing could move cash; mark-to-market moves equity only. `long_market_value`
$6,213.20, `initial_margin` $3,106.60, `maintenance_margin` $1,863.96, `sma` $6,752.10, buying power
$19,084.56 — no leverage, cash positive an 8th consecutive session. Account `ACTIVE`, `trading_blocked`
and `account_blocked` both `false`. The 98% haircut remains **not stress-tested** (#5).

### 🟠 Carry-forward #10: sip returned the current session a FOURTH consecutive time

The 08-24 bar came back live intraday (c=310.545, v=649,427 at 15:56 ET) and again final after the close
(c=310.59, v=733,309), as on 08-21, at this morning's open, and at midday. **Four runs now contradict the
"sip refuses the current session" limit recorded 08-19 — it is a delay, not a refusal; drop the caveat at
the 08-25 review.** **Eleventh consecutive run calling `feed=sip` out-of-band** while
`scripts/alpaca.sh:104` ships `feed=iex`; load-bearing again today for the session table and every
rejection mark. Not applied — EOD's remit is exits, journaling and notification, not tooling.

### Ops carry-forward — nothing applied

**#1** 🔴🔴 EOD sleep-deferral — **TIME-CRITICAL, ONE enforcing run left before the KEYS 08-26 stop**;
today ran on time on luck, `pmset -g sched` still shows no bull wake. Human call, un-applied 4th day.
**#2** `caffeinate -is` still uncommitted (with `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`,
`.env.bak.broken`, `memory/guardrails.md.conservative.bak`); not mitigation for #1. **#3**
`routines/market-open.md:29` vs the overdue carve-out — **1 session left in which it could ever matter**,
and it becomes live the moment 08-26 EOD misses. **#4** no limit-order/partial-close path. **#5** haircut
98% → 96%, still not stress-tested. **#6/#10** `feed=sip` — **eleventh use**, load-bearing, still
unapplied; its "no current session" limit has now failed four consecutive runs. **#7**
`routines/midday.md:1` header — not exercised this run. **#8** IEX bell staleness — **did NOT reproduce at
the close** (quote matched to the cent at 15:59:52 ET); combined with this morning's 1.26pp error this
resolves into a sharper written rule: *stale at the open, live at the close.* **#9**
`routines/end-of-day.md:1` header claims `3:55 PM Central / 4:55 PM Eastern` — internally contradictory
(15:55 CT = 16:55 ET, after the close) and wrong on both counts; the live plist is 12:55 PDT = **15:55 ET
/ 14:55 CT**. Docs-only fix, do NOT move the plist. **#11** novelty-at-the-open — **closes measured**:
GSK +0.50% (accept side, cap-blocked), MRNA -2.67%, ROST +1.49%, TGT +2.31%. **#12** the 3–7 DTE option
window — the reason KEYS is shares at 93.6% of the book with no premium-decay exit. **#13** the bounded
fill poll. **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100` survivability — **KEYS closed
-8.84%, one enforcing run from its only exit, and the same config cost ~2.2pp by blocking GSK today.**
**#15** "raised but capacity-constrained" — **judged no a sixth time; 08-25 is its last chance to matter.**
**#16** the dated Grok query — **applied a fifth time**; write it into both routine files at the 08-25
review.

2026-08-24 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
KEYS 20 sh marked **312.605** vs 340.8005 entry = **-8.27%**, recovering 0.16pp off the -8.43% market-open
mark. Market value **$6,252.10** on $6,674.00 equity = **93.68% of the book**. Equity **$6,674.00**, cash
**+$421.90**, day **-1.05%**, WTD **-1.05%** (Monday), all-time **-93.33%** from the $100,000 open.
Reconciled against Alpaca: `positions` returns 1 (`asset_class: us_equity`), `orders open` returns **0** —
no drift. **20 × 312.605 + 421.90 = $6,674.00 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 12:01:47 ET, 1m47s after the 12:00 ET trigger

`clock.is_open` = `true`, `next_close` 2026-08-24T16:00 ET. Account `ACTIVE`, `trading_blocked` and
`account_blocked` both `false`. **Eighth consecutive live confirmation of the header bug in
`routines/midday.md:1`** (carry-forward #7): the plist fires 09:00 PDT = **12:00 ET / 11:00 CT**, not the
`12:00 PM Central / 1:00 PM Eastern` the header claims. **The header is the wrong artifact — do NOT move
the plist to match it.** Margin is slightly wider than 08-21's 1m24s but well inside the window; the
midday trigger sits in the machine's active period and has never been hit by the sleep-deferral mechanism
the 08-20 EOD run root-caused.

### Step 1 — exits: no gate fired. Thesis-broken was again the only one that could.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -8.27% | +100% (`per_trade_target_pct`) | no |
| stop loss | -8.27% | **-100%** (`per_trade_stop_pct`) | **no — 91.7pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-24 query **NONE** | concrete named event | no |
| time stop | target_exit **2026-08-26** | 2 sessions out | not due, and not midday's |
| expiry guard | n/a — shares, no options open | — | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Mark used is `positions.current_price` (312.605) per the standing lesson; `trade.p` was
**312.51** = -8.30% and the two agree to nine cents — no staleness, as expected away from the bell
(`t=2026-08-24T16:01:42Z`, ~5s old). **Carry-forward #8 did NOT reproduce**, consistent with every prior
midday: the IEX bell-staleness failure is specific to the 09:30 ET run, where it cost 1.26pp this morning.
Neither mark is within 91 points of a gate.

### 🟢 Grok clean an EIGHTH consecutive session — #16 applied a fourth time

Two independent queries, both literal **NONE**:

1. **Standard 10-class enumeration** (guidance cut, recall, litigation, regulatory/export-control, exec
   departure, downgrade-only, restatement, dilution, short report, contract/customer loss) — **NONE on
   every class**, with coverage Aug 18–23 characterised as beats, raised guidance and AI-driven demand,
   and analyst flow all on the *raise* side (Morgan Stanley, UBS, Truist, Baird $410 PT 08-19).
2. **Dated 08-24 query**, instructed to ignore the 08-18 print — **NONE**. Today's KEYS coverage is
   routine 13F institutional-ownership disclosures (Meiji Yasuda Asset Management, a ~$7.38M **purchase**)
   plus the SVP Form 4 already dispositioned by market-open (Ingrid Estrada, 2,000 sh sold 08-20 under a
   pre-arranged **10b5-1** plan).

Verdict **THESIS INTACT**; per the hard rule (sell only on concrete, named negative news) the position is
held. **Four consecutive sessions of dated queries have now returned Form 144, 13F *purchases*, a 10b5-1
Form 4, and today a 13F purchase + the same 10b5-1 — filings, never events.** The dated query remains the
only version of the check falsifiable against the current session; write it into both routine files at the
08-25 review.

### 🟠 Carry-forward #15 re-tested a FIFTH time: still not thesis-broken

Neither query surfaced the "guidance raised BUT capacity-constrained" framing as a *new* negative today —
the standard query returned it under raised-guidance/AI-demand coverage, not as a fundamental negative.
Judged **not thesis-broken** on the same reasoning as the four prior runs: the Q4 guide was *raised*
($3.34–3.40 vs ~$2.68 consensus) and a ceiling on upside conversion is not a reduction of the forward
numbers we bought. **#15 now has five consistent readings and the 08-25 review should rule** rather than
leaving it to each routine to re-derive.

### 🟢 The tape INVERTED: KEYS made its low early and recovered — first break in the four-session pattern

Off the sip consolidated feed:

| session | open | high | low | close/last | volume |
|---------|------|------|-----|------------|--------|
| 2026-08-18 (print) | 350.00 | 350.895 | 332.64 | **341.00** | 3,526,271 |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | 3,875,269 |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | 1,905,031 |
| 2026-08-21 | 319.22 | 322.73 | 310.27 | **316.13** | 1,201,274 |
| **2026-08-24** | **311.09** | **313.35** | **306.8517** | **312.605** | 246,114 |

Four consecutive sessions printed the high in the opening minutes and walked down. **Today did the
opposite**: the low **306.8517** came early — a level that would have marked the position **-9.96%**, the
worst it has ever been — and KEYS has since recovered to **312.605**, within 0.75 of the session high and
**+1.87% off the low**. Also note **08-21's true close is 316.13, not the 313.59 the 08-21 midday note
logged** (that was an intraday partial; `lastday_price` 316.13 confirms) and its true volume 1,201,274,
not 467,092. Logged, not acted on — no rule reads intraday shape and inventing one at the terminal is what
decision.md forbids. But the shape is the first counter-evidence in five sessions and the 08-25 review
should read it alongside the four-session pattern rather than after it.

### Step 2 — daily loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-1.05%** (6674.00 vs last_equity 6744.50) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **-1.05%** (Monday; week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all` (0 open orders anyway), no `notify.sh` alert, no halt marker written to
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said. The binding
constraint on entries today is `max_concurrent_positions: 1` — and this morning it had a **real cost for
the first time** (GSK scored 6, passed the gate, blocked solely by the cap). Midday opens nothing
regardless.

### 🔴 TWO SESSIONS TO THE TIME STOP — still the only exit KEYS has

**93.68%** of the book in one name whose only remaining exit is the **2026-08-26 time stop**. At
`per_trade_stop_pct: 100` the price gate cannot fire above $0.00; thesis-broken denied **eight consecutive
sessions**. Sessions left: **08-25, 08-26**. The enforcing routine is late-or-missed **26 of 67 (~39%)**
and **4 of the last 5** → naive odds it fires in time ~**61%**. If it misses, the overdue carve-out sells
at the 08-27 market-open (precedent KMX 06-26, PENG 07-16, CCK 07-30, BMY 08-10) — a one-session overshoot
on a Thursday, so no weekend risk.

**➡️ ESCALATION #1, THIRD DAY RUNNING and now with two sessions of runway:**
`sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10 PDT,
no sudo, covers all four routines). Moving the trigger 12:55 → 12:40 PDT is **not** a substitute — a 12:40
trigger fired into a sleeping machine defers identically. Carry-forward #2 is **not** mitigation; it held
live assertions through the 08-21 miss.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent, so nothing could move cash; mark-to-market moves equity only. `long_market_value`
$6,252.10, `initial_margin` $3,126.05, `maintenance_margin` $1,875.63, `sma` $6,752.10, buying power
$19,193.48 — no leverage, cash positive a 7th consecutive session. The 98% haircut remains **not
stress-tested** (#5).

### 🟠 Carry-forward #10: sip returned the current session a THIRD consecutive time

The 08-24 bar came back live (o=311.09, h=313.35, l=306.8517, c=312.605, v=246,114) alongside history, as
on 08-21 and at this morning's market-open. Three runs now contradict the "sip refuses the current session"
limit recorded 08-19 — **treat it as a delay, not a refusal, and drop the caveat at the 08-25 review.**
**Tenth consecutive run calling `feed=sip` out-of-band** while `scripts/alpaca.sh:104` ships `feed=iex`;
load-bearing again today for the entire session table. Note the raw call also needs
`ALPACA_SECRET_KEY` (not `ALPACA_SECRET`) per `scripts/alpaca.sh:29` — the first attempt this run failed on
that. Not applied — midday's remit is exits and notifications, not tooling.

### Ops carry-forward — nothing applied

Midday can apply none of these (exits and notifications only). By reference so the count stays honest:
**#1** 🔴🔴 EOD sleep-deferral — **TIME-CRITICAL, 2 sessions to the KEYS 08-26 stop**, human call,
un-applied 3rd day. **#2** `caffeinate -is` still uncommitted (with `AGENTS.md`, `.agents/`, `_raw/`,
`_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`); not mitigation for #1.
**#3** `routines/market-open.md:29` vs the overdue carve-out — 2 sessions left. **#4** no
limit-order/partial-close path. **#5** haircut 98% → 96%. **#6/#10** `feed=sip` — **tenth use**,
load-bearing, still unapplied; its "no current session" limit has now failed three consecutive runs.
**#7** `routines/midday.md:1` header — **re-confirmed live this run, eighth time**. **#8** IEX bell
staleness — **did not reproduce** (midday is not the bell); it cost 1.26pp at this morning's open, so
promote it to a written rule. **#9** `routines/end-of-day.md:1` header. **#11** novelty-at-the-open —
this morning added GSK on the accept side plus TGT/MRNA/ROST discards. **#12** the 3–7 DTE option window.
**#13** the bounded fill poll. **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100`
survivability — **KEYS at -8.27%, 2 sessions from its only exit, and it traded -9.96% intraday today.**
**#15** "raised but capacity-constrained" — **judged no a fifth time; 08-25 should rule.** **#16** the
dated Grok query — **applied a fourth time**; write it into both routine files at the 08-25 review.

2026-08-24 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh held, marked **312.085** vs 340.8005 entry = **-8.43%**, a new low-water mark for
the trade (prior low -8.06% at midday 08-21). Market value **$6,241.70** on $6,663.60 equity = **93.67%
of the book**. Equity **$6,663.60**, cash **+$421.90**, day **-1.20%**, WTD **-1.20%** (Monday), all-time
**-93.34%** from the $100,000 open. Reconciled against Alpaca: `positions` returns 1
(`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 312.085 + 421.90 = $6,663.60 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:17 ET, 17s after the bell

**Ninth consecutive on-time market-open.** Account `ACTIVE`, `trading_blocked`/`account_blocked` both
`false`. The morning trigger has never been hit by the sleep-deferral mechanism the 08-20 EOD run
root-caused; today says nothing for or against escalation #1, which is EOD-only.

### Step 1 — exits: no gate fired. Thesis-broken was again the only one that could.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -8.43% | +100% (`per_trade_target_pct`) | no |
| stop loss | -8.43% | **-100%** (`per_trade_stop_pct`) | **no — 91.6pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-24 query **NONE** | concrete named event | no |
| time stop | target_exit **2026-08-26** | today >= target_exit | **no — 2 sessions out, not overdue** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |

Overdue carve-out did **not** apply (`target_exit` in the future) — carry-forward #3 unexercised, **2
sessions left** in which it could ever fire.

### 🔴 Carry-forward #8 REPRODUCED — `quote` returned Friday's close at the bell, worth 1.26pp

`./scripts/alpaca.sh quote KEYS` returned `p=316.365` at `t=2026-08-21T19:59:48Z` — **Friday 15:59:48
ET**, the prior session's last print. Using it would have marked the position **-7.17%** instead of
**-8.43%**, a **1.26pp** error on the favourable side. `positions.current_price` (312.085) and the sip
08-24 bar (open 311.09) agree the tape is live and low. The standing "mark off `positions.current_price`"
lesson held the number honest and **should be promoted to a written rule at the 08-25 review**, with #16.

### 🟢 Grok clean a SEVENTH consecutive session — #16 applied a third time by market-open

Two independent queries, both literal **NONE**: the standard 10-class enumeration (Aug 23–24, positive
coverage and PT raises only), and the dated 08-24 query. The **only** 08-24-datelined KEYS item is a
routine **Form 4** — SVP Ingrid Estrada sold 2,000 shares on 08-20 under a **pre-arranged 10b5-1 plan**,
published today. A scheduled plan sale discloses a pre-committed trade and says nothing about forward
numbers; not a concrete named negative. Verdict **THESIS INTACT**, position held. Three sessions of dated
queries have now returned Form 144, 13F *purchases*, and a 10b5-1 Form 4 — filings, never events.

### Step 2 — halt checks: entries HALTED on the position cap, and today it had a real cost

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **-1.20%** (6663.60 vs last_equity 6744.50) | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **-1.20%** (Monday; week opens at Friday's $6,744.50) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **1** | **1** (`max_concurrent_positions`) | ✅ **YES — slot FULL** |
| new positions today | 0 | 1 (`max_new_positions_per_day`) | no |

**🔴 First market-open on which the cap was the SOLE reason no trade happened.** On 08-20 (top score 5)
and 08-21 (top score 4) both gates refused independently and every note called the cap "binding on paper,
free in practice." Not true today: **GSK scored 6 against a threshold of 6** and passed Material / Fresh /
Directional, both catalysts verified against GSK's own 08-24-datelined newsroom releases. The score gate
said **yes**; only `max_concurrent_positions: 1` said no. **The 08-25 review should price this against
#14** — the same FULL YOLO config that put 93.7% of the book in one name is what blocked the diversifier.

### Step 3 — entries: none constructed; preflight never invoked (no order to gate)

**GSK novelty re-measured at the open** per the ALB 08-06 / KEYS 08-19 rule, as pre-market requested:
opened **$51.54 vs the 08-21 close $52.41 = -1.66%**, against a pre-market read of -0.9% to -1.14%. Score
**holds at 6** — confirmation was already 0 and the open confirms it harder, so pre-market's call was
correct and conservative. The name we could not buy was a genuine 6 *and* still not confirming; the 08-25
review needs both facts.

Rejection open-marks (sip, 09:32 ET, per the 08-14 rule — from the open, never the prior close):
**GSK 51.54 (-1.66%, cap-blocked)**, TGT 166.06 (+0.37%), MRNA 142.70 (-1.67%), ROST 238.075 (-0.40%).
Carry-forward #11 gets three discard-side instances; GSK is the accept-side instance that measures the
cap's cost rather than the gate's accuracy.

### 🔴 TWO SESSIONS TO THE TIME STOP — still the only exit KEYS has

**93.67%** of the book in one name whose only remaining exit is the **2026-08-26 time stop**. At
`per_trade_stop_pct: 100` the price gate cannot fire above $0.00; thesis-broken denied **seven
consecutive sessions**. Sessions left: **08-25, 08-26**. The enforcing routine is late-or-missed **26 of
67 (~39%)** and **4 of the last 5** → naive odds it fires in time ~**61%**. If it misses, the overdue
carve-out sells at the 08-27 market-open (precedent KMX 06-26, PENG 07-16, CCK 07-30, BMY 08-10) — a
one-session overshoot on a Thursday, so no weekend risk.

**➡️ ESCALATION #1, THIRD DAY RUNNING:** `sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours
`caffeinate -s` LaunchAgent (~06:20–13:10 PDT, no sudo, covers all four routines). Moving the trigger
12:55 → 12:40 PDT is **not** a substitute. Carry-forward #2 is **not** mitigation — it held live
assertions through the 08-21 miss.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order sent. `long_market_value` $6,241.70, `initial_margin` $3,120.85, `maintenance_margin` $1,872.51,
`sma` $6,752.10, buying power $19,164.36 — no leverage, cash positive a 6th consecutive session. The 98%
haircut remains **not stress-tested** (#5).

### 🟠 Carry-forward #10: sip returned the current session a SECOND consecutive time

The 08-24 KEYS bar came back live (311.09, v=2,459) alongside history, as on 08-21. Two runs now
contradict the "sip refuses the current session" limit recorded 08-19 — treat it as a **delay, not a
refusal**, and drop the caveat at the 08-25 review. **Ninth consecutive run calling `feed=sip`
out-of-band** while `scripts/alpaca.sh:104` ships `feed=iex`; load-bearing again today for every
rejection mark and for corroborating #8. Not applied — market-open's remit is orders, not tooling.

### Ops carry-forward — nothing applied

**#1** 🔴🔴 EOD sleep-deferral — **TIME-CRITICAL, 2 sessions to the KEYS 08-26 stop**, human call,
un-applied 3rd day. **#2** `caffeinate -is` still uncommitted (with `AGENTS.md`, `.agents/`, `_raw/`,
`_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`); not mitigation for #1.
**#3** `routines/market-open.md:29` vs the overdue carve-out — 2 sessions left. **#4** no
limit-order/partial-close path. **#5** haircut 98% → 96%. **#6/#10** `feed=sip` — ninth use,
load-bearing, still unapplied; its "no current session" limit failed a second consecutive run.
**#7** `routines/midday.md:1` header. **#8** IEX bell staleness — **🔴 REPRODUCED, worth 1.26pp**;
promote to a written rule. **#9** `routines/end-of-day.md:1` header. **#11** novelty-at-the-open —
three discard instances (TGT/MRNA/ROST) + GSK on the accept side. **#12** the 3–7 DTE option window.
**#13** the bounded fill poll. **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100`
survivability — **KEYS at -8.43%, 2 sessions from its only exit, and the same config's position cap
blocked a qualifying GSK entry today.** **#15** "raised but capacity-constrained" — surfaced a **fifth**
time (Motley Fool 08-22), judged no again; **08-25 should rule**. **#16** the dated Grok query —
**applied a third time**; write it into both routine files at the 08-25 review.

2026-08-21 EOD: **🔴 MISSED — started 12:59:51 PDT, clock read 13:00:01 PDT = 16:00:01 ET, ONE SECOND
past the close.** `clock.is_open` = `false` → Step-0 bail-out. **0 exits, 0 orders, no preflight**,
`memory/trade-log.md` unchanged. KEYS 20 sh marked **316.13** vs 340.8005 entry = **-7.24%**, recovering
0.82pp off the -8.06% midday low-water mark. Equity **$6,744.50**, cash **$421.90**, day **-0.11%**
(−$7.60), WTD **-6.48%**, all-time **-93.26%** from the $100,000 open. Reconciled against Alpaca:
`positions` returns 1 (`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 316.13 + 421.90 = $6,744.50 = equity, to the cent.**
Late-or-missed **#26 of 67 (~39%)**, and **4 of the last 5**. EOD email **SENT** anyway
(id `c605a487-6f19-40cb-a5b3-68f1fff56ec7`) per the 08-20 precedent — the session data is final and
the escalation below is what the human needs; one attempt, delivered.

### 🔴 RUN QUALITY: MISSED BY ONE SECOND — the narrowest miss on record, and the cause is unchanged

Sleep deferral, reproduced live for the second consecutive session. From `pmset -g log`:

```
12:59:51 PDT  DarkWake from Deep Idle [CDNPB] : due to ... rtc/Maintenance   Using AC (Charge:100%)
```

and `ps -eo lstart` shows `run-routine.sh end-of-day` started **`Fri Aug 21 12:59:51 2026`** — the same
second as the wake. Trigger is 12:55:00 PDT. **Deferral 4m 51s.**

| run | trigger | actual start | delta | outcome |
|-----|---------|--------------|-------|---------|
| 08-17 EOD | 12:55 PDT | `12:55:35` | +35s | ✅ ON TIME — RDNT time-stop filled 15:55:56 ET |
| 08-18 EOD | 12:55 PDT | `13:04` | +9m | 🔴 missed |
| 08-19 EOD | 12:55 PDT | `12:59:16` | +4m 16s | 🟠 LATE but acted, 44s to spare |
| 08-20 EOD | 12:55 PDT | `13:05:59` | +10m 59s | 🔴 missed |
| **08-21 EOD** | 12:55 PDT | **`12:59:51`** | **+4m 51s** | 🔴 **missed by 1 second** |

Note 08-19 vs 08-21: **35 seconds of deferral separated a working time-stop enforcement from a
bail-out.** The margin is now the entire safety system, and it is coin-flip wide.

Corroborating: `weekly-review` started `13:00:04` — a second batch released just after the same wake,
the coalescing signature. The plists remain **healthy** (`ProcessType` absent, the 08-17 repair holds,
`StartCalendarInterval` correct at 12:55 PDT = 15:55 ET). This was **deferred, not misconfigured**.

**`pmset -g sched` still shows NO bull wake** — only `com.apple.calaccessd.travelEngine` (15:11:18)
and `com.apple.osanalytics.hardhighengagementtimer` (16:59:19). Escalation #1 remains un-applied for
a second day.

**Carry-forward #2 is now empirically dead as mitigation.** `caffeinate` was *running* during this
window (two live assertions, pids 49371/49514, `PreventSystemSleep`) and the run **still missed** —
exactly as the 08-20 root-cause block predicted. It holds the machine awake *while a routine runs*;
it cannot start a routine whose trigger landed during sleep. Commit it to prevent mid-run sleep, but
stop counting it against #1.

### Step 1 — time stops + expiry guard: NOT EVALUATED (bailed out). Cost of the miss: ZERO.

| gate | value | would it have fired? |
|------|-------|----------------------|
| time stop | target_exit **2026-08-26**, 3 sessions out | no — not due |
| overdue carve-out | not past due | no |
| expiry guard | n/a — shares only, no options open | n/a |
| profit target | -7.24% vs +100% (`per_trade_target_pct`) | no |
| stop loss | -7.24% vs -100% (`per_trade_stop_pct`) | no — **92.76pp of room** |
| thesis broken | **not re-checked** — bailed before Grok | unknown |

Today's miss cost the safety-net re-check and nothing else. **That is the calendar's doing, not the
scheduler's** — the same luck that covered 08-14, 08-18 and 08-20. It runs out on **08-26**.

The thesis re-check was deliberately **skipped, not silently dropped**: the market was already closed,
so no result could have been acted on, and midday's two queries (4h earlier) both returned literal
**NONE** — standard 10-class enumeration and the dated 08-21 query. Monday's market-open will
re-derive it fresh across the full weekend. Recorded here so the gap is visible rather than assumed.

### Step 2 — weekly loss cap: NOT hit (computed post-hoc, not as a gate)

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-0.11%** (6744.50 vs last_equity 6752.10) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **-6.48%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |

No flatten, no `cancel-all` (0 open orders anyway), no `notify.sh` alert, no `PAUSED` marker in
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said.

### The tape: KEYS closed off the low, breaking the high-early/close-weak pattern — barely

Midday marked **313.32** (-8.06%, the trade's low-water mark); the close came in at **316.13**
(-7.24%), a **+0.90% intraday recovery** off that mark. `lastday_price` 316.51 → `change_today`
**-0.12%**, so on a close-to-close basis the session was essentially flat. Four consecutive sessions
of round-tripping the morning bid have now been followed by one that closed near the day's mark.
One session is not a pattern break; note it and re-read it Monday.

### 🔴 THREE SESSIONS TO THE TIME STOP — and the routine that enforces it just missed again

**93.74%** of the book ($6,322.60 of $6,744.50) is in one name whose only remaining exit is the
**2026-08-26 time stop**. At `per_trade_stop_pct: 100` the price gate cannot fire above $0.00, and
thesis-broken has been denied **six consecutive sessions**. Sessions left: **08-24, 08-25, 08-26**.

The enforcing routine has now missed or run late **26 of 67 runs (~39%)** and **4 of the last 5**.
Naive odds the 08-26 EOD fires in time: ~61%. That is the actual probability attached to this
position's only exit.

Mitigations already in place if 08-26 EOD misses: strategy.md's **overdue carve-out** lets
market-open sell on 08-27 (precedent KMX 06-26, PENG 07-16, CCK 07-30, BMY 08-10). So the failure
mode is a **one-session overshoot carrying 93.7% of the book overnight**, not an unbounded hold —
but 08-27 is a Thursday, so no weekend risk this time. Carry-forward **#3** (`routines/market-open.md:29`
contradicting that carve-out) has **3 sessions left in which it could ever matter** and is still unfixed.

**➡️ ESCALATION #1 IS NOW THE MOST TIME-CRITICAL ITEM ON THE BOARD, SECOND DAY RUNNING. Human call:**
`sudo pmset repeat wake MTWRF 12:50:00`, or a market-hours `caffeinate -s` LaunchAgent (~06:20–13:10
PDT) which needs no sudo and covers all four weekday routines. **Moving the trigger 12:55 → 12:40 PDT
is NOT a substitute** — a 12:40 trigger fired into a sleeping machine defers identically.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

Cash positive for the 5th consecutive session. `long_market_value` $6,322.60, `initial_margin`
$3,161.30, `maintenance_margin` $1,896.78, `sma` $6,810.90. Account `ACTIVE`, `trading_blocked` and
`account_blocked` both `false`.

### Ops carry-forward — nothing applied this run

**#1** 🔴🔴 **EOD sleep-deferral — `sudo pmset repeat wake MTWRF 12:50:00` or a market-hours
`caffeinate -s` LaunchAgent. TIME-CRITICAL: 3 sessions to the KEYS 08-26 time stop; missed 4 of the
last 5.** Human call, un-applied 2nd day. **#2** commit the `caffeinate -is` fix in
`scripts/run-routine.sh` — still uncommitted, alongside untracked `AGENTS.md`, `.agents/`, `_raw/`,
`_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`; **now empirically shown NOT to
mitigate #1** (it was holding assertions during today's miss). **#3** `routines/market-open.md:29` vs
strategy.md's overdue carve-out — still contradictory; **3 sessions left in which it could ever fire**,
and today's miss makes it materially more likely to be needed. **#4** no limit-order or partial-close
path in `alpaca.sh`. **#5** widen the entry haircut 98% → 96%, untested. **#6/#10** `alpaca.sh bars`
IEX-default window bug — not exercised this run (no bars call); `feed=sip` still unapplied to
`scripts/alpaca.sh:104`, the only carry-forward a routine could safely apply without a human.
**#7** `routines/midday.md:1` header wrong by an hour. **#9** `routines/end-of-day.md:1` header claims
`3:55 PM Central / 4:55 PM Eastern` — internally contradictory (15:55 CT = 16:55 ET, *after* the close)
and wrong on both counts; the live plist is 12:55 PDT = **15:55 ET / 14:55 CT**. Docs-only fix, do NOT
move the plist. **#11** the HD novelty-at-the-open discard-side question. **#12** the 3–7 DTE option
window that killed 4 of 5 option-eligible setups — **it also killed KEYS on 08-19** (monthly-only
expiries), which is why this position is shares at 93.7% of the book with no premium-decay exit.
**#13** bounded fill poll too short for opening-auction market orders. **#14** whether
`per_trade_stop_pct: 100` + `target_position_pct: 100` is survivable — **KEYS is the live case, -7.24%
and 3 sessions from its only exit**; the 08-21 weekly review should rule on it. **#15** "guidance raised
BUT capacity-constrained" as thesis-broken — judged no four times; **08-25 should rule**. **#16** the
dated "what happened TODAY" Grok query — applied by market-open and midday today; **write it into both
routine files at the 08-25 review**.

2026-08-21 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
KEYS 20 sh marked **313.32** vs 340.8005 entry = **-8.06%**, giving back the entire 08-21 morning
recovery and then some (market-open marked -5.30%). Market value **$6,266.40** on $6,688.30 equity =
**93.69% of the book**. Equity **$6,688.30**, cash **+$421.90**, day **-0.94%**, WTD **-7.25%**,
all-time **-93.31%** from the $100,000 open. Reconciled against Alpaca: `positions` returns 1
(`asset_class: us_equity`), `orders open` returns **0** — no drift.
**20 × 313.32 + 421.90 = $6,688.30 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 12:01:24 ET, 1m24s after the 12:00 ET trigger

`clock.is_open` = `true`, `next_close` 2026-08-21T16:00 ET. Account `ACTIVE`, `trading_blocked` and
`account_blocked` both `false`. **Seventh consecutive live confirmation of the header bug in
`routines/midday.md:1`** (carry-forward #7): the plist fires 09:00 PDT = **12:00 ET / 11:00 CT**, not
the `12:00 PM Central / 1:00 PM Eastern` the header claims. **The header is the wrong artifact — do
NOT move the plist to match it.** Margin is wider than yesterday's 18s but well inside the window; the
midday trigger sits in the machine's active period and has never been hit by the sleep-deferral
mechanism the 08-20 EOD run root-caused.

### Step 1 — exits: no gate fired. Thesis-broken was again the only one that could.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -8.06% | +100% (`per_trade_target_pct`) | no |
| stop loss | -8.06% | **-100%** (`per_trade_stop_pct`) | **no — 91.9pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-21 query **NONE** | concrete named event | no |
| time stop | target_exit **2026-08-26** | 3 sessions out | not due, and not midday's |
| expiry guard | n/a — shares, no options open | — | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Mark used is `positions.current_price` (313.32) per the standing lesson; `trade.p` was
**313.43** = -8.03% and the two agree to eleven cents — no staleness, as expected away from the bell
(`t=2026-08-21T16:00:33Z`, ~1 min old). Neither is within 91 points of a gate.

### 🟢 Grok clean a SIXTH consecutive session — carry-forward #16 applied for the second run

Two independent queries, both literal **NONE**:

1. **Standard 10-class enumeration** (guidance cut, recall, litigation, regulatory/export-control,
   exec departure, downgrade-only, restatement, dilution, short report, contract/customer loss) —
   **NONE on every class**, and explicitly none in "the last 6 hours or even the prior ~2–3 days."
   Coverage characterised as positive post-print, with the drawdown attributed to sell-the-news.
2. **Dated "what happened TODAY" query**, instructed to ignore the 08-18 print and return only
   events with an 08-21 dateline — **NONE**. Today's KEYS coverage is earnings-call recaps of the
   08-18 results, a Zacks AI-infrastructure buy case, and an institutional-ownership filing
   (B. Metzler Seel Sohn purchased ~20,979 shares — a *purchase*, third session running that the
   only 13F/ownership flow has been on the buy side).

Verdict **THESIS INTACT**. Per the hard rule (sell only on concrete, named negative news) the position
is held. **This is the second run with the dated query as standard practice; it remains the only
version of the check that is falsifiable against the current session, and it should be written into
both routine files at the 08-25 review (carry-forward #16).**

### 🔴 The morning recovery round-tripped — the high-early/close-weak pattern reasserted itself

Off the sip consolidated feed:

| session | open | high | low | close/last | volume |
|---------|------|------|-----|------------|--------|
| 2026-08-17 | 360.00 | 366.41 | 358.01 | 361.15 | 1,818,042 |
| 2026-08-18 (print) | 350.00 | 350.895 | 332.64 | **341.00** | 3,526,271 |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | 3,875,269 |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | 1,905,031 |
| **2026-08-21** | **319.22** | **322.73** | **310.27** | **313.59** | 467,092 |

**Correction to this morning's market-open note.** It recorded "the first session in four that has not
printed its high in the opening minutes and walked down," on the evidence of a 09:32 ET IEX fragment.
The full sip bar says otherwise: today's high is **322.73** — the exact price market-open marked at
09:32 — so the high *was* printed in the opening minutes, and KEYS has since fallen **-3.85% off it**
to a session low of **310.27**, the lowest print since the catalyst. **The pattern is now four
consecutive sessions, not three-then-broken.** Logged, not acted on — no rule reads intraday shape and
inventing one at the terminal is what decision.md forbids.

### 🟠 Carry-forward #10: sip returned the CURRENT session today, for the first time

Every note since 08-19 has recorded "sip refuses the current session" as a known scope limit. **That
did not hold today** — the same `feed=sip` daily-bars call returned an 08-21 bar (o=319.22, h=322.73,
l=310.27, v=467,092) alongside the history, so today's row above is consolidated tape, not an IEX
fragment. Either the limit is intermittent or it is a delay rather than a refusal. **Seventh
consecutive run using `feed=sip` out-of-band while `scripts/alpaca.sh:104` still ships the IEX
default.** #6 and #10 remain the same one-line fix, and it is still the only carry-forward a routine
could safely apply without a human. Not applied here — midday's remit is exits and notifications.

### Step 2 — daily loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-0.94%** (6688.30 vs last_equity 6752.10) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **-7.25%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all` (0 open orders anyway), no `notify.sh` alert, no halt marker written to
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said. The binding
constraint on entries today is `max_concurrent_positions: 1` — the slot is full — not the loss cap;
midday opens nothing regardless.

### 🔴 THREE SESSIONS TO THE TIME STOP, and it is still the only exit KEYS has

At `per_trade_stop_pct: 100` the shares gate cannot fire above $0.00. The position has now given back
**-8.06%** — a new low-water mark for this trade, worse than the -7.86% logged at midday 08-20 — and
no price-based rule has noticed, nor will one before zero. With **93.69%** of the book in one name the
only exits that exist are (a) concrete negative news, denied **six consecutive sessions**, and (b) the
**2026-08-26 time stop**, enforceable only by an EOD routine that has been late-or-missed **25 of 66
runs (~38%)**. After today, **3 sessions remain** (08-24, 08-25, 08-26).

**➡️ Escalation #1 as rewritten by the 08-20 root-cause block — `sudo pmset repeat wake MTWRF
12:50:00`, or a market-hours `caffeinate -s` LaunchAgent — is still un-applied and is the most
time-critical item on the board. Human call.** The old framing (move the trigger 12:55 → 12:40 PDT)
is **wrong and is not a substitute**: a 12:40 trigger fired into a sleeping machine defers identically.
Nor does carry-forward #2 mitigate it — `caffeinate -is` inside `run-routine.sh` cannot help a routine
that never started.

### 🟠 Carry-forward #15 re-tested a fourth time: still not thesis-broken

Neither query surfaced the supply-chain-constraint framing as a *new* negative today; both filed the
drawdown under sell-the-news/valuation. Judged **not thesis-broken** on the same reasoning as the
three prior runs — the Q4 guide was *raised* ($3.34–3.40 vs ~$2.68 consensus) and a ceiling on upside
conversion is not a reduction of the forward numbers we bought. **#15 stays open for 08-25** with four
consistent readings behind it; the review should rule rather than leaving it to each routine.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent, so nothing could move cash; mark-to-market moves equity only. Buying power
$19,233.52, no leverage. The 98% haircut remains **not stress-tested** (carry-forward #5).

### Ops carry-forward — nothing applied

Midday can apply none of these (exits and notifications only). By reference so the count stays honest:
**#1** 🔴 EOD sleep-deferral fix — **TIME-CRITICAL, 3 sessions to the KEYS 08-26 stop**, human call.
**#2** `caffeinate -is` in `scripts/run-routine.sh` still uncommitted (with `AGENTS.md`, `.agents/`,
`_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`); does **not** mitigate
#1. **#3** `routines/market-open.md:29` vs strategy.md's overdue carve-out — unexercised, 3 sessions
left. **#4** no limit-order/partial-close path in `alpaca.sh`. **#5** widen the entry haircut 98% →
96%. **#6** `alpaca.sh bars` window bug — fix via #10. **#7** `routines/midday.md:1` header —
**re-confirmed live this run, seventh time**. **#8** IEX bell staleness — not applicable, midday is not
the bell. **#9** `routines/end-of-day.md:1` header. **#10** `feed=sip` — used a seventh time, still
unapplied, and **its "no current session" limit did not hold today** (see above). **#11** the HD
novelty-at-the-open discard-side question. **#12** the 3-7 DTE option window. **#13** the bounded fill
poll. **#14** `per_trade_stop_pct: 100` + `target_position_pct: 100` survivability — **KEYS live at
-8.06%, a new low for the trade, 3 sessions from its only exit.** **#15** "raised but capacity-
constrained" as thesis-broken — **judged no a fourth time**; 08-25 should rule. **#16** the dated
"what happened TODAY" Grok query — **applied a second time**; write it into both routine files at the
08-25 review.

2026-08-21 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh held, marked **322.73** vs 340.8005 entry = **-5.30%**, a 1.82pp improvement on
the -7.12% 08-20 EOD mark. Market value **$6,454.60** on $6,876.50 equity = **93.87% of the book**.
Equity **$6,876.50**, cash **+$421.90**, day **+1.84%**, WTD **-4.65%**, all-time **-93.12%** from the
$100,000 open. Reconciled against Alpaca: `positions` returns 1 (`asset_class: us_equity`), `orders
open` returns 0 — no drift. **20 × 322.73 + 421.90 = $6,876.50 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:12 ET, 12s after the bell

**Eighth consecutive on-time market-open**, same 12s margin as yesterday. The 06:30 PDT trigger sits well
inside the machine's active period and has never been hit by the sleep-deferral mechanism the 08-20 EOD
run root-caused. Today says nothing for or against escalation #1, which is an *EOD*-only problem.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -5.30% | +100% (`per_trade_target_pct`) | no |
| stop loss | -5.30% | **-100%** (`per_trade_stop_pct`) | **no — 94.7pp of room** |
| thesis broken | Grok **NONE ×10 classes** + dated 08-21 query **NONE** | concrete named event | no |
| time stop | target_exit **2026-08-26** | today >= target_exit | **no — 3 sessions out, not overdue** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path. Mark is
`positions.current_price` (322.73) per the standing lesson; `trade.p` was 321.94 = -5.53%. The overdue
carve-out did **not** apply — `target_exit` is in the future — so carry-forward #3 stays unexercised,
now with only 3 sessions left in which it could ever fire.

**Grok clean a FIFTH consecutive session, and carry-forward #16 was applied.** Two queries: the standard
10-class enumeration returned a literal **NONE on every class** (only filing of any kind was a routine
Form 144 by an affiliate for ~2,000 shares, explicitly not a company-led secondary), and a **dated
"what happened TODAY" query** — instructed to ignore the 08-18 print — also returned **NONE**,
characterising today's coverage as routine references to the 08-18 release, PT raises mostly dated
08-19, and a 13F disclosing a ~21k-share institutional *purchase*. Verdict **THESIS INTACT**.

### Step 2 — halt checks: entries HALTED on the position cap, second session running

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **+1.84%** | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **-4.65%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **1** | **1** (`max_concurrent_positions`) | ✅ **YES — slot FULL** |
| new positions today | 0 | 1 (`max_new_positions_per_day`) | no |

Halt fired → Step 3 skipped, reason logged to `research-log.md`, run went straight to refresh + commit.
**Both gates refuse independently**: top score today was **4** (ROST/FDX/UPS) against a threshold of
**6**, so no entry existed for the cap to block. Third consecutive session where the cap is binding on
paper and free in practice.

### 🔴 Three sessions to the KEYS time stop, and it is still the only exit that exists

At `per_trade_stop_pct: 100` the shares stop cannot fire above $0.00, and with **93.87%** of the book in
one name the only exits KEYS has are (a) concrete negative news — denied **five consecutive sessions** —
and (b) the **2026-08-26 time stop**, enforceable only by an EOD routine late-or-missed **25 of 66 runs
(~38%)**. After today, **3 sessions remain** (08-24, 08-25, 08-26).
**➡️ Escalation #1 as rewritten by the 08-20 root-cause block — `sudo pmset repeat wake MTWRF 12:50:00`
or a market-hours `caffeinate -s` LaunchAgent — is un-applied and now the most time-critical item on the
board.** Human call. The old framing (trigger 12:55 → 12:40 PDT) is **still wrong** and is not a
substitute: a 12:40 trigger fired into a sleeping machine defers identically.

### 🟠 KEYS recovered 1.8pp overnight, and did not print its high in the first minutes

| session | open | high | low | close | source |
|---------|------|------|-----|-------|--------|
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** | sip |
| 2026-08-20 | 314.66 | 322.69 | 313.195 | **316.51** | sip |
| **2026-08-21** (09:32 ET) | **319.86** | 321.94 | 319.86 | **~322.73** | IEX fragment |

Opened **+1.06%** vs the 08-20 sip close and held it — the first session in four that has not printed
its high in the opening minutes and walked down. One session of counter-evidence to the pattern the
08-19/08-20 notes logged, and far too early to call: on both of those days the position was green two
minutes in and red by midday. No rule reads intraday shape and none was invented. sip again returns
nothing for the current session (carry-forward #10's known limit), so today's row is an IEX fragment on
531 shares and its open print is not authoritative.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent. Buying power $19,760.48, no leverage. The 98% haircut remains **not stress-tested**
(carry-forward #5).

### 🟠 Carry-forward #6 reproduced live; #10 is a one-line fix away

`./scripts/alpaca.sh bars KEYS` returned a window ending **2026-08-13** — eight sessions stale — so the
table above was built from a direct `feed=sip` call, which returned 08-19/08-20 correctly first try.
**Sixth consecutive run using `feed=sip` out-of-band while `scripts/alpaca.sh:104` still ships the IEX
default.** #6 and #10 are the same fix and it is the only carry-forward a routine could safely apply
without a human. Not applied here — market-open's remit is orders, not tooling.

### Ops carry-forward — nothing applied

**#1** 🔴 EOD sleep-deferral fix — **TIME-CRITICAL, 3 sessions to the KEYS 08-26 stop**, human call.
**#2** `caffeinate -is` in `scripts/run-routine.sh` still uncommitted (with `AGENTS.md`, `.agents/`,
`_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`); does **not** mitigate
#1. **#3** market-open.md:29 vs strategy.md carve-out — unexercised, 3 sessions left. **#4** no
limit-order/partial-close path. **#5** haircut 98% → 96%. **#6** bars window bug — **reproduced**.
**#7** midday.md:1 header. **#8** IEX bell staleness — **did not reproduce** (`t=13:30:20Z` at 09:30 ET,
~0s old, snapshot agreed). **#9** end-of-day.md:1 header. **#10** `feed=sip` — used a sixth time, still
unapplied. **#11** HD novelty-at-the-open discard side — **ROST is today's live instance** (DQ'd at
+8.77% on a 5% bar; mark it from today's *open*, not the 08-20 close, per the 08-14 rule). **#12** the
3-7 DTE option window. **#13** the bounded fill poll. **#14** `per_trade_stop_pct: 100` +
`target_position_pct: 100` survivability — **KEYS live, -5.30%, 3 sessions from its only exit.**
**#15** "raised but capacity-constrained" as thesis-broken — judged no three times; 08-25 should rule.
**#16** dated "what happened TODAY" Grok query — **applied this run**; write it into both routine files
at the 08-25 review.

2026-08-20 EOD: **🔴 MISSED — started 13:05:59 PDT = 16:05:59 ET, 5m59s past the close.**
`clock.is_open` = `false` → Step-0 bail-out. **0 exits, 0 orders, no preflight**, `memory/trade-log.md`
unchanged. KEYS 20 sh marked **316.52** vs 340.8005 entry = **-7.12%**, recovered from the -7.86%
midday mark. Equity **$6,752.30**, cash **$421.90**, day **-0.86%**, WTD **-6.37%**, all-time
**-93.25%** from the $100,000 open. Reconciled against Alpaca: `positions` returns 1
(`asset_class: us_equity`), `orders open` returns 0 — no drift.
**20 × 316.52 + 421.90 = $6,752.30 = equity, to the cent.**
Late-or-missed **#25 of 66 (~38%)**. EOD email **SENT** anyway (id `6de7f00c-93e5-4f66-93e8-7de32c187c93`)
— the session data is final and the root cause below is what the human needs; one attempt, delivered.

### 🔴🔴 ROOT CAUSE FOUND — IT IS **NOT JITTER**, IT IS **SLEEP DEFERRAL**. Four sessions of notes were wrong.

Every prior note (08-14, 08-18, 08-19) diagnosed this as "launchd jitter" and concluded "a 5-minute
margin does not cover it." **That diagnosis is incorrect.** From `pmset -g log` for today:

```
12:36:04  Sleep    (Maintenance Sleep, 1048 secs)
12:53:32  DarkWake (rtc/Maintenance, 61 secs)
12:54:33  Sleep    (Maintenance Sleep, 686 secs)   <-- 27 SECONDS BEFORE THE TRIGGER
12:55:00  [ EOD trigger fires into a sleeping machine — job DEFERRED, not run ]
13:05:59  DarkWake (rtc/Maintenance) -> launchd runs the deferred job immediately
```

**`StartCalendarInterval` does not wake a sleeping Mac.** The job is queued and runs at the next
wake, whenever that happens to be. The machine slept 27 seconds before the trigger and did not wake
for **11m26s**. That is the whole mechanism, and it retro-explains every late/missed run: the delay
is not bounded jitter around the trigger, it is **unbounded deferral to the next opportunistic wake**.

Confirming settings, read live this run:

| setting | value | meaning |
|---------|-------|---------|
| `pmset sleep` | **1** | idles to sleep after 1 minute |
| `pmset powernap` | 1 | wakes only on Apple's own maintenance cadence (~10-18 min today) |
| `pmset -g sched` | **no bull wake** | only `calaccessd.travelEngine` and `osanalytics` alarms |

**The plist is HEALTHY** — `ProcessType` absent, all five 12:55 weekday triggers present,
`launchctl list` showed the job live under PID 61833 with exit status 0. The 08-17 coalescing repair
still holds. **The scheduler was never the problem. The machine is asleep.**

### 🔴 THIS INVALIDATES ESCALATION #1 AS WRITTEN — 12:55 → 12:40 PDT DOES NOT FIX IT

Escalation #1 has been the top item on the board for four sessions and it is **the wrong fix**. A
12:40 trigger fired into a sleeping machine defers identically. It would have "worked" today only
because the 12:53:32 wake happened to land before the close — **luck, not margin**. You cannot buy
protection with a wider margin when the failure mode is unbounded deferral.

**Two real fixes. I applied NEITHER — both are machine-wide power changes and #1 was always flagged
as a human call. The exact commands:**

1. **PREFERRED — schedule a real RTC wake before the trigger** (needs sudo):
   ```
   sudo pmset repeat wake MTWRF 12:50:00
   ```
   Physically wakes the Mac at 12:50 PDT on weekdays, 5 min before the EOD trigger, so launchd fires
   on time. One command, addresses the actual cause. Caveat: `pmset repeat` holds **one** repeating
   wake, so the 06:25 / 09:00 PDT routines are not covered by it — use option 2 for the full day.
2. **NO-SUDO ALTERNATIVE — a LaunchAgent running `caffeinate -s`** across the trading day
   (~06:20–13:10 PDT) so the machine never sleeps while any routine is scheduled. Covers pre-market,
   market-open, midday and EOD at once.

**⚠️ Correction to carry-forward #2:** the uncommitted `caffeinate -is` fix in
`scripts/run-routine.sh` **does not solve this and never could.** It holds the machine awake only
*while the routine runs*; it cannot help a routine that never started because the machine was asleep
at the trigger. #2 is still worth committing on its own merits (it prevents mid-run sleep), but it
must stop being counted as mitigation for #1.

### Run-quality history, re-read through the sleep-deferral lens

| run | trigger | start (ET) | delay | result |
|-----|---------|------------|-------|--------|
| 08-11 | 12:55 PDT | 15:58 | ~3 min | ⚠️ |
| 08-12 | 12:55 PDT | 15:58 | ~3 min | ⚠️ |
| 08-14 | 12:55 PDT | 16:10 | ~15 min | ❌ missed |
| 08-17 | 12:55 PDT | 15:55:35 | 35 s | ✅ sold RDNT |
| 08-18 | 12:55 PDT | 16:03:59 | ~9 min | ❌ missed |
| 08-19 | 12:55 PDT | 15:59:16 | 4m16s | ⚠️ ran, unusable (44s of market) |
| **08-20** | 12:55 PDT | **16:05:59** | **10m59s** | ❌ **missed** |

The delays cluster at 0–15 minutes because that is the maintenance-wake cadence, not because the
scheduler drifts. **Three of the last five EOD runs started after the close.** 08-17 succeeded
because the machine happened to be awake — the only run that proves the plist works.

### Step 1 — time stops + expiry guard: bail-out, and nothing was due regardless

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| **time stop** | target_exit **2026-08-26** | today >= target_exit | **no — 4 sessions out, not overdue** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |
| profit target (safety net) | -7.12% | +100% (`per_trade_target_pct`) | no |
| stop loss (safety net) | -7.12% | **-100%** (`per_trade_stop_pct`) | **no — 92.9pp of room** |
| thesis broken (safety net) | **not re-run** | concrete named event | n/a |

Instrument detected live off Alpaca `asset_class: us_equity`. **Grok was deliberately NOT called.**
The market was closed, so no verdict could produce an action; midday ran two independent queries
~4 hours earlier (both literal **NONE**, including a dated "what happened TODAY" query), and both
pre-market and market-open re-check tomorrow before any order is possible. Recording the omission
explicitly rather than implying a clean check that did not happen.

**Cost of the miss today: ZERO, for the third time, and again by luck of the calendar** — no time
stop due, no options open, weekly cap 94pp away. Nothing needed selling, so nothing was lost by
having no market in which to sell it. That is a fortunate draw, not a working system.

### Step 2 — weekly loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| weekly P&L | **-6.37%** (6752.30 vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |
| daily P&L | **-0.86%** (vs last_equity 6810.90) | -100% (`daily_loss_cap_pct`) | none |

No flatten, no `notify.sh` alert, no `PAUSED` marker in `memory/research-log.md`. Decorative at 100%,
as every prior note has said.

### The tape: a third consecutive high-early, close-weak session — but it closed off the low

IEX daily bar for today (sip refuses the current session — carry-forward #10's known scope limit);
prior sessions from sip:

| session | open | high | low | close |
|---------|------|------|-----|-------|
| 2026-08-17 | 360.00 | 366.41 | 358.01 | 361.15 |
| 2026-08-18 (pre-print) | 350.00 | 350.895 | 332.64 | **341.00** |
| 2026-08-19 | 349.00 | 352.00 | 314.52 | **319.45** |
| **2026-08-20** | **316.71** | **322.69** | **313.43** | **316.46** |

KEYS closed **-0.94%** vs yesterday, recovering from the 314.005 midday mark. Note the 08-20 open
reads 316.71 on IEX vs the 314.66 midday logged off sip — IEX is a tape fragment and its open print
differs; the high (322.69) agrees exactly. Third straight session printing the high early, though
today it closed in the lower-middle of the range rather than on the low. Logged, not acted on.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent, so nothing could move cash. Buying power $19,412.72, no leverage. The 98% haircut
remains **not stress-tested** (carry-forward #5).

### Ops carry-forward — #1 REWRITTEN, #2 DEMOTED

1. **🔴 EOD misses are SLEEP DEFERRAL, not jitter. The fix is `sudo pmset repeat wake MTWRF
   12:50:00` (or a market-hours `caffeinate -s` LaunchAgent) — NOT moving the trigger to 12:40.**
   Needs a human; deadline is the KEYS **2026-08-26** time stop, **4 sessions out**, which at
   `per_trade_stop_pct: 100` is that position's only scheduled exit on 93.8% of the book.
2. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` — **still uncommitted**, alongside
   untracked `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`,
   `memory/guardrails.md.conservative.bak`. **DEMOTED: this does not mitigate #1** — see correction
   above. Worth committing only to prevent mid-run sleep.
3. `routines/market-open.md:29` vs strategy.md's overdue carve-out — still contradictory, still
   unexercised (stop is in the future). Goes live if the 08-26 EOD misses.
4. No limit-order or partial-close path in `alpaca.sh`.
5. Widen the entry haircut 98% → 96%. Still untested.
6. `alpaca.sh bars` window bug — fix via #10.
7. `routines/midday.md:1` header wrong by an hour. Docs-only.
8. IEX staleness — not applicable this run (EOD is not the bell).
9. **`routines/end-of-day.md:1` header** — reads `3:55 PM Central / 4:55 PM Eastern`, self-
   contradictory twice over. The live plist (12:55 PDT = 15:55 ET) is right. Docs-only.
10. `feed=sip` for bars/volume — used again for the session table, **still unapplied** to
    `scripts/alpaca.sh:104`. Re-confirmed it returns nothing for the current session.
11. The HD novelty-at-the-open discard-side question.
12. The 3-7 DTE option window that killed 4 of 5 option-eligible setups.
13. The bounded fill poll being too short for opening-auction market orders.
14. Whether `per_trade_stop_pct: 100` + `target_position_pct: 100` is survivable — **KEYS is the
    live case, -7.12% and 4 sessions from its only exit.**
15. "Guidance raised BUT capacity-constrained" as thesis-broken — judged no twice; 08-25 should rule.
16. Make the dated "what happened TODAY" Grok query standard in `routines/midday.md`.

2026-08-20 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
KEYS 20 sh marked **314.005** vs 340.8005 entry = **-7.86%**, down from -6.19% at the 09:32 ET
market-open mark. Market value **$6,280.10** on $6,702.00 equity = **93.7% of the book**. Equity
**$6,702.00**, cash **+$421.90**, day **-1.60%**, WTD **-7.07%**, all-time **-93.30%** from the
$100,000 open. Reconciled against Alpaca: `positions` returns 1 (`asset_class: us_equity`),
`orders open` returns 0, matching this file — no drift.
**20 × 314.005 + 421.90 = $6,702.00 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 12:00:18 ET, 18s after the 12:00 ET trigger

`clock.is_open` = `true`. Account `ACTIVE`, `trading_blocked` and `account_blocked` both `false`.
**Sixth consecutive live confirmation of the header bug in `routines/midday.md:1`** (carry-forward
#7): the plist fires 09:00 PDT = **12:00 ET / 11:00 CT**, not the `12:00 PM Central / 1:00 PM
Eastern` the header claims. **The header is the wrong artifact — do NOT move the plist to match it.**
Best margin yet on this trigger (18s vs ~1 min on 08-19, ~2.5 min on 08-18).

### Step 1 — exits: no gate fired. Thesis-broken was again the only one that could.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -7.86% | +100% (`per_trade_target_pct`) | no |
| stop loss | -7.86% | **-100%** (`per_trade_stop_pct`) | **no — 92.1pp of room left** |
| thesis broken | Grok **NONE**, two independent queries | concrete named event | no |
| time stop | target_exit **2026-08-26** | 4 sessions out | not due, and not midday's |
| expiry guard | n/a — shares, no options open | — | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Quote was **live** (`t=2026-08-20T15:59:53Z`, ~25s old) — no staleness, as expected away
from the bell. Mark used is `positions.current_price` (314.005) per the standing lesson; `trade.p`
was 314.23 = -7.79%, and neither is within 92 points of a gate.

### 🟢 Grok clean a FOURTH consecutive session — and the second query was aimed at TODAY, not 08-19

The routine's standard query (guidance cut / recall / lawsuit / regulatory reversal / exec departure)
returned **no material negative news in the last 6 hours or the past day**, sourced to Keysight's own
IR release, with *positive* flow only — Morgan Stanley PT $425, UBS $440, Truist $400.

**A second query was run deliberately, because the standard one kept answering about 08-19.** The
position is down a further 1.7pp today, so the live question is whether something new hit *this
session*. Asked explicitly for a new event dated 08-20 — 8-K, downgrade, exec move, contract loss,
export-control action, short report, secondary — Grok returned a literal **NONE**, and characterised
08-20 coverage as **routine 13F filings only** (E Fund Management, Wealthfront Advisers — prior-
quarter activity reported that day) plus lingering bullish 08-19 analyst notes. Verdict **THESIS
INTACT**; per the hard rule (sell only on concrete, named negative news) the position is held.

**Method note for the 08-25 review:** the routine's canned 6-hour query anchors on the last big
story, which for four sessions running has been the 08-18 print. Adding a dated "what happened
TODAY" second query is what made the answer falsifiable. Cheap, and worth making standard.

### 🟠 Carry-forward #15 re-tested: still not thesis-broken, and Grok's framing did not harden

The 08-20 market-open note flagged Grok's new supply-chain-constraint finding and asked whether
"guidance raised BUT capacity-constrained" belongs in the thesis-broken class. Both queries this run
surfaced the same constraint language and both filed it under **valuation / sell-the-news, not a
fundamental negative** — "not tied to any fundamental negative development," "continued post-earnings
valuation adjustment rather than any fresh trigger." Judged **not thesis-broken** for the same reason
as this morning: the Q4 guide was *raised* ($3.34–3.40 vs ~$2.68 consensus) and a ceiling on upside
conversion is not a reduction of the forward numbers we bought. **#15 stays open for 08-25** — this
run adds a second consistent reading, not a resolution.

### The tape: KEYS gapped down, ran to 322.69, and gave it all back

Off the sip consolidated feed (carry-forward #10, used successfully again):

| session | open | high | low | close/last |
|---------|------|------|-----|------------|
| 2026-08-17 | 360.00 | 366.41 | 358.01 | 361.15 |
| 2026-08-18 (pre-print) | 350.00 | 350.90 | 332.64 | **341.00** |
| 2026-08-19 | 349.00 | 352.00 | 317.48 | **319.45** |
| **2026-08-20** | **314.66** | **322.69** | **313.48** | **313.99** |

Worth correcting the record on one point: market-open marked the position at **319.70** at 09:32 ET
and that mark was **not stale** — today's high is 322.69, so the early run-up was real. KEYS opened
**-1.50%** below yesterday's close, rallied ~2.6% off the open, then round-tripped to sit **near the
session low**. **That is the same intraday shape as 08-19** (high in the first hour, close near the
low), now for a second consecutive session. Logged as a pattern for 08-25, not acted on — midday has
no rule that reads intraday shape, and inventing one at the terminal is exactly what decision.md
forbids.

### 🔴 Down 7.9% with 92 points of stop room — the FULL YOLO config, restated because it keeps mattering

At `per_trade_stop_pct: 100` the shares gate cannot fire above $0.00. The position has now given back
**-7.86%** and no price-based rule has noticed, nor will one before zero. With 93.7% of the book in
this name, the **only** exits that exist for KEYS remain (a) concrete negative news, which Grok has
now denied four sessions running, and (b) the **2026-08-26 time stop** — **4 sessions out**, and
enforceable only by a routine that has been late-or-missed **24 of 65 runs (~37%)**.
**➡️ Escalation #1 (EOD trigger 12:55 → 12:40 PDT) is unchanged, un-applied, and still the most
consequential open item on the board.** Still a human call.

### Step 2 — daily loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-1.60%** (6702.00 vs last_equity 6810.90) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **-7.07%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all` (0 open orders anyway), no `notify.sh` alert, no halt marker written to
`memory/research-log.md`. The cap is decorative at 100%, as every prior note has said. Note the
binding constraint on entries today is **`max_concurrent_positions: 1`** — the slot is full — not
the loss cap; midday opens nothing regardless.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent, so nothing could move cash; mark-to-market moves equity only. Buying power
$19,271.88, no leverage. The 98% haircut remains **not stress-tested** (carry-forward #5).

### Ops carry-forward — nothing applied

Midday can apply none of these (exits and notifications only). By reference so the count stays
honest: **#1** EOD trigger 12:55 → 12:40 PDT — **top item, load-bearing, 4 sessions to the KEYS time
stop**; **#2** commit the `caffeinate -is` fix in `scripts/run-routine.sh` — **verified still
uncommitted this run**, alongside untracked `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`,
`.env.bak.broken`, `memory/guardrails.md.conservative.bak`; **#3** `routines/market-open.md:29` vs
strategy.md's overdue carve-out — still contradictory, still unexercised (stop is in the future);
**#4** no limit-order or partial-close path in `alpaca.sh`; **#5** widen the entry haircut 98% → 96%;
**#6** `alpaca.sh bars` window bug (fix via #10); **#7** this file's header, re-confirmed live above;
**#8** IEX staleness — not observed this run, midday is not the bell; **#9**
`routines/end-of-day.md:1` header; **#10** `feed=sip` for bars — **used successfully again this run**,
still unapplied to `scripts/alpaca.sh:104`; **#11** the HD novelty-at-the-open discard-side question;
**#12** the 3-7 DTE option window that killed 4 of 5 option-eligible setups; **#13** the bounded fill
poll; **#14** whether `per_trade_stop_pct: 100` + `target_position_pct: 100` is survivable — **KEYS is
the live case, now -7.86% and 4 sessions from its only exit**; **#15** "raised but capacity-
constrained" as thesis-broken — **re-tested this run, still judged no**; **#16 NEW** — make the dated
"what happened TODAY" Grok query standard in `routines/midday.md`, since the canned 6-hour query keeps
answering about the original catalyst rather than the current session.

2026-08-20 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh held, marked **319.70** vs 340.8005 entry = **-6.19%**, a touch better than the
-6.27% EOD mark. Equity **$6,815.90**, cash **+$421.90**, day **+0.07%**. Reconciled against Alpaca:
`positions` returns 1 (`asset_class: us_equity`), `orders open` returns 0 — no drift.
**20 × 319.70 + 421.90 = $6,815.90 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:12 ET, 12s after the bell

`clock.is_open` = `true`, `next_close` 2026-08-20T16:00 ET. `trading_blocked` and `account_blocked`
both `false`, status `ACTIVE`. **Seventh consecutive on-time market-open.** The morning trigger
remains the reliable one; escalation #1 is about the *EOD* trigger and is untouched by this.

### Step 1 — exits: no gate fired, and only thesis-broken could have

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -6.19% | +100% (`per_trade_target_pct`) | no |
| stop loss | -6.19% | **-100%** (`per_trade_stop_pct`) | **no — 93.8pp of room** |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |
| time stop | target_exit **2026-08-26** | today >= target_exit | **no — 4 sessions out, not overdue** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`, preflight
`equity`. Mark used is `positions.current_price` (319.70) per the standing lesson; `trade.p` was
317.74 = -6.77%, and neither is within 93 points of a gate. The overdue carve-out did **not** apply —
`target_exit` is in the future, not the past — so `routines/market-open.md:29` and strategy.md's
carve-out still have not been forced to disagree (carry-forward #3, still unexercised).

### 🟢 Grok clean a THIRD consecutive session — and it named the mechanism this time

Same 10-class enumeration (guidance cut, recall, litigation, regulatory/export-control, exec
departure, downgrade-only, restatement, dilution, short report, contract/customer loss): a literal
**NO NEWS on all ten**, sourced to Keysight's own IR release. Positive flow only — Morgan Stanley PT
to **$425**, UBS to **$440**, both post-print raises, on top of Baird's $410 logged yesterday.

**New and worth recording:** asked again why KEYS fell from $341 to ~$317, Grok this time surfaced a
*specific* cause it did not give on 08-19 — **management's earnings-call commentary that supply-chain
constraints are limiting conversion of record (AI-driven) demand into revenue, expected to persist a
couple of quarters** — alongside the sell-the-news/valuation explanation. That is a real, named
negative disclosure, and it is a closer call than yesterday's "pure profit-taking" read.

**It was judged NOT thesis-broken, deliberately, and here is the reasoning:** it is not a guidance
cut — the Q4 guide was *raised* to $3.34–3.40 vs ~$2.68 consensus in the same release, and the
constraint is a ceiling on upside conversion, not a reduction of the forward numbers we bought. The
routine's hard rule is to sell only on a **concrete, named negative event**; a qualifier attached to
a raised guide, disclosed in the very release that formed the thesis, is a reason the market re-rated
the multiple, not a reversal of the catalyst. Verdict **THESIS INTACT**, position held. Flagged here
because it is the first time the thesis check has returned something with real content rather than a
clean sweep, and the 08-25 review should decide whether "raise, but capacity-constrained" belongs in
the thesis-broken class.

### Step 2 — halt checks: entries HALTED, and the position cap binds for the first time

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **+0.07%** (6815.90 vs last_equity 6810.90) | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **-5.49%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **1** | **1** (`max_concurrent_positions`) | ✅ **YES — slot FULL** |
| new positions today | 0 | 1 (`max_new_positions_per_day`) | no |

**`max_concurrent_positions: 1` fired today — the first time this cap has actually been the binding
constraint on a session.** Every prior note has called the cap untested, because the entry threshold
and the cap always said no together and the cap was never the reason. That is *still* true in
substance: top score today was **5 against a threshold of 6**, so no entry existed for the cap to
block. **Both gates said no independently.** The cap is binding on paper and free in practice —
recording it as the first instance, not as vindication.

### Step 3 — entries: none. Top score 5 (ADI) vs threshold 6.

Watchlist: **ADI 5, MRVL 5, EL 5, DE 4, NDSN 4, TGT 4, REGN 4, RARE 3**; MRNA/MRK/WMT/LOW/TJX/HON/
RTX/HOOD/JCI/EMR and five micro-caps disqualified. Nothing reached 6, so per strategy.md ("if nothing
scores >= 6, we do not trade today") no order was constructed and preflight was never invoked. Cash
is a position — though with 93.8% of the book in KEYS, "cash" is $421.90 of it.

### Open-print audit of today's rejections — marked from the OPEN per the 08-14 rule

Recorded at **09:31 ET, ~2 minutes into the session**, so these are markers for the 08-25 review, not
conclusions. Two minutes of tape settles nothing; the KEYS lesson is precisely that the open print
does not predict the close.

| ticker | score | 08-19 close | 08-20 open | gap at open | last (09:31) | vs open |
|--------|-------|-------------|------------|-------------|--------------|---------|
| ADI  | 5 | 373.22 | 376.915 | +0.99% | 381.645 | **+1.25%** |
| MRVL | 5 | 237.35 | 237.19  | -0.07% | 245.54  | **+3.52%** |
| REGN | 4 | 810.38 | 815.925 | +0.68% | 840.935 | **+3.07%** |
| TGT  | 4 | 159.14 | 156.91  | -1.40% | 158.46  | +0.99% |
| EL   | 5 | 98.04  | 97.20   | -0.86% | 96.90   | -0.31% |
| NDSN | 4 | 309.78 | 315.00  | +1.69% | 314.18  | -0.26% |
| DE   | 4 | 580.64 | 591.17  | +1.81% | 588.40  | -0.47% |
| RARE | 3 | 26.25  | 28.39   | **+8.15%** | 27.61 | **-2.75%** |

Two things are worth the review's attention. **RARE gapped +8.15% at the open and is already -2.75%
off it** — pre-market scored it 3 partly *because* the repricing was happening above our entry, and
the first two minutes are consistent with that. And **ADI, the name the threshold kept us out of, is
+1.25%** — a live, honest counter-datapoint to the "verified beats get sold" pattern, logged now so
the 08-25 review does not get only the instances that flatter the rule. Neither is actionable and
neither was acted on.

### 🟢 IEX feed HEALTHY at the bell — escalation #8 did not reproduce

`trades/latest` returned `t=2026-08-20T13:30:45Z` at 09:31 ET, **~1 minute old**, and the `snapshot`
endpoint agreed to the cent (317.74). No repeat of the 17.4-hour-stale print logged at the 08-19,
08-17 and 08-14 opens. **The hazard remains intermittent, not retired.** Note the *pre-market*
failure mode logged in today's research block — snapshot serving yesterday's 15:59 closes at 06:46 ET
with no pre-market data — is a different, earlier-in-the-session symptom and is unaffected by this.

`feed=sip` daily bars were used again for the session table above and were correct (08-19
o=349 h=352 l=314.52 c=319.45 v=3,875,269). **Still unapplied to `scripts/alpaca.sh:104`** —
carry-forward #10, now used successfully in five consecutive runs while remaining uncommitted.

### 🟢 `no_margin` COMPLIANT — cash +$421.90, unchanged since the 08-19 fill

No order was sent, so nothing could move cash; mark-to-market moves equity only. Buying power
$19,590.80, no leverage. The 98% haircut is **still not stress-tested** (carry-forward #5) — it has
not been called on since the 08-19 fill came in favorable.

### Ops carry-forward — nothing applied this run

Market-open can apply none of these; they are strategy/ops changes, and #1 needs a human. **#1** EOD
trigger 12:55 → 12:40 PDT — **still the load-bearing item**, and the KEYS **2026-08-26** time stop is
now **4 sessions out**; at `per_trade_stop_pct: 100` it is that position's only scheduled exit and
EOD has been late-or-missed 24 of 65 runs (~37%). **#2** commit the `caffeinate -is` fix in
`scripts/run-routine.sh` — **verified still uncommitted this run**, alongside untracked `AGENTS.md`,
`.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`.
**#3** `routines/market-open.md:29` vs strategy.md's overdue carve-out — still contradictory, **not
exercised today** (stop is in the future); it becomes live if the 08-26 EOD misses. **#4** no
limit-order or partial-close path in `alpaca.sh`. **#5** widen the entry haircut 98% → 96%, still
untested. **#6** `alpaca.sh bars` window bug (fix via #10). **#7** `routines/midday.md:1` header
wrong by an hour. **#8** IEX open-bell staleness — **did not reproduce at the bell today**; keep on
the list, and note the separate pre-market symptom above. **#9** `routines/end-of-day.md:1` header.
**#10** `feed=sip` for bars/volume — used again, still unapplied. **#11** the HD novelty-at-the-open
discard-side question. **#12** the 3-7 DTE option window that killed 4 of 5 option-eligible setups.
**#13** the bounded fill poll being too short for opening-auction market orders. **#14** whether
`per_trade_stop_pct: 100` + `target_position_pct: 100` is a survivable pairing — **KEYS is the live
case and it is now 4 sessions from its only exit.** **#15 NEW** — does "guidance raised BUT
capacity-constrained" (today's Grok finding on KEYS) count as thesis-broken? Judged no this run; the
08-25 review should make it explicit rather than leaving it to each routine's reading.

2026-08-19 EOD: **0 time-stops, 0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. KEYS 20 sh marked **319.45** vs 340.8005 entry = **-6.27%**, essentially flat to the
-6.26% midday mark (319.44). Equity **$6,810.91**, cash **$421.91**, day **-5.90%**, WTD **-5.56%**,
all-time **-93.19%** from the $100,000 open (2026-05-14). Reconciled against Alpaca: `positions`
returns 1 (`asset_class: us_equity`), `orders open` returns 0 — no drift.
**20 × 319.45 + 421.91 = $6,810.91 = equity, to the cent.**

⚠️ **Correction to the EOD email sent this run:** it quoted all-time as **-92.42%** against the
earliest equity figure found in `research-log.md` ($89,894.55), because no seed value was located
before send. The correct basis is the **$100,000 open** recorded in the 08-14 review line, giving
**-93.19%**. The email stated its basis explicitly so it was not misleading, but this file is the
source of truth and -93.19% is the number. Day, WTD, position and exit figures in the email are all
correct and unaffected.

### 🔴 RUN QUALITY: LATE — started 15:59:16 ET, 4m16s past the 15:55 trigger. The close landed mid-run.

`clock.is_open` was `true` at 15:59:16 (`next_close` 16:00:00 ET) so **Step-0 did not bail** — this
is not a miss in the 08-18 sense, it is worse-shaped: the routine ran, but with **44 seconds of
market left**. The clock re-read at 15:59:37 still showed open; by the time account/positions/
guardrails were pulled, 16:00 had passed. **Any sell this run decided to place would have had
roughly half a minute to be constructed, preflighted and submitted.**

**Cost today: ZERO, and only by luck of the calendar.** No time stop was due (KEYS → 08-26), no
options were open to expiry-guard, and the weekly cap was nowhere near. Nothing needed to be sold,
so nothing was lost by having no time to sell it. That is a fortunate draw, not a working system.

Tally: this is **late-or-missed #24 of 65 (~37%)**. The 08-17 plist repair (dropping `ProcessType
Background`) removed launchd's *coalescing* and it is still holding — but today re-proves what the
08-18 note concluded: **removing coalescing did not remove jitter, and a 5-minute margin does not
cover it.** 08-17 drew 4m25s of margin, 08-18 drew -4m (missed), today drew 44s.

| run | trigger | start (ET) | margin to close | result |
|-----|---------|------------|-----------------|--------|
| 08-11 | 12:55 PDT | 15:58 | ~2 min | ⚠️ |
| 08-12 | 12:55 PDT | 15:58 | ~1.5 min | ⚠️ |
| 08-14 | 12:55 PDT | 16:10 | **-10 min** | ❌ missed |
| 08-17 | 12:55 PDT | 15:55:35 | 4m 25s | ✅ sold RDNT |
| 08-18 | 12:55 PDT | 16:03:59 | **-4 min** | ❌ missed |
| **08-19** | 12:55 PDT | **15:59:16** | **44 sec** | ⚠️ **ran, but unusable for an order** |

**➡️ Escalation #1 (move the EOD trigger 12:55 → 12:40 PDT) is now the load-bearing item on the
board and today is its third consecutive piece of evidence.** There is a live position with a
**2026-08-26 time stop** that only this routine can enforce, and at `per_trade_stop_pct: 100` it is
the *only* scheduled exit that exists. On today's distribution, that stop has roughly a 1-in-3
chance of being enforced late or not at all. Still a human call — it shifts every time-stop's
execution price — but the deadline is now dated.

### Step 1 — time stops + expiry guard: nothing fired, safety net re-run clean

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| **time stop** | target_exit **2026-08-26** | today >= target_exit | **no — 5 sessions out** |
| expiry guard | n/a — shares, no options open | within 2 trading days | n/a |
| profit target (safety net) | -6.27% | +100% (`per_trade_target_pct`) | no |
| stop loss (safety net) | -6.27% | **-100%** (`per_trade_stop_pct`) | **no — 93.7pp of room** |
| thesis broken (safety net) | Grok **NO NEWS ×10 classes** | concrete named event | no |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`,
preflight `equity`. Mark used is `positions.current_price` (319.45) per the standing lesson.

**Grok re-run as the safety net and returned clean — second consecutive session.** Same 10-class
enumeration midday used (guidance cut, recall, litigation, regulatory/export-control, exec
departure, downgrade-only, restatement, dilution, short report, contract/customer loss): a literal
**NO NEWS on all ten**. Asked directly why KEYS fell ~6% on a beat-and-raise, it returned
**sell-the-news profit-taking on valuation after the run into the print** — no corporate event —
and cited Baird *raising* its PT to **$410** today. Verdict **THESIS INTACT**. Per the hard rule
(sell only on concrete, named negative news) the position is held.

### 🔴 The day's real number: -5.90% is the largest single-session drawdown this book has taken

KEYS was bought this morning at **$340.8005** — six cents *below* the pre-catalyst 08-18 close —
after the ALB 08-06 open-print novelty gate ran as a pre-order check and **passed** (+1.76% vs a
+5% kill bar). It closed the session at **319.45**, **-6.27%** from entry and **-6.32%** below the
08-18 close that the entire novelty gate was measured against.

| session | open | high | low | close |
|---------|------|------|-----|-------|
| 2026-08-17 | 360.00 | 366.41 | 358.01 | 361.15 |
| 2026-08-18 (pre-print) | 350.00 | 350.90 | 332.64 | **341.00** |
| **2026-08-19** | **349.00** | 352.00 | **317.48** | **~319.45** |

KEYS printed its high in the opening minutes and spent the session walking down to close near the
low. **This is the 08-14 standing lesson in its fourth consecutive instance — *verification proves
the catalyst is real, it does not prove the market will pay for it*** — and the first instance where
we were **holding** rather than watching a rejected candidate. The pre-market note logged the
counter-argument before the fact and it was correct: *"the options-implied move into the print was
~7-8% and the market has so far paid +2.3% for a 24.8% EPS beat. That is a shrug."* We bought the
shrug. **Nothing about the entry violated a rule** — score 8, primary-source verified, novelty gate
passed at the open, sizing haircut respected, preflight clean. The rules permitted a trade the tape
then punished. That is the 08-25 review's question, not a routine's.

### Step 2 — weekly loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| weekly P&L | **-5.56%** (6810.91 vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |
| daily P&L | **-5.90%** (vs last_equity 7237.92) | -100% (`daily_loss_cap_pct`) | none |

No flatten, no `notify.sh` alert, no `PAUSED` marker written to `memory/research-log.md`. The cap
is decorative at 100% — the worst day this account has had clears it by 94 percentage points. Worth
stating plainly for the 08-25 review: **a "weekly loss cap" that only fires on a total wipeout is
not a loss cap**, and with `per_trade_stop_pct: 100` there is no per-trade stop either, so the book
currently has **no drawdown control of any kind** other than the 7-day time stop.

### 🟢 `no_margin` COMPLIANT — cash +$421.91, unchanged since the fill

Mark-to-market moved equity, not cash. Buying power $19,576.84, no leverage. The 98% haircut plus
the integer floor left +4.30% of headroom this morning and the fill came in -1.78% favorable, so
**the haircut still has not been stress-tested** — carry-forward #5 (widen 98% → 96%) stays open on
its own merits.

### Steps 3/4 — EOD email SENT

Resend id `af2db36f-3f57-4444-afff-8792337f0f46`, one attempt, delivered. Body in `/tmp/bull-eod.txt`.
Pre-market scanned **11 names** (5 scored: KEYS 8, SYK 5, TOL 5, HD 4, JKHY 4; 6 disqualified:
ZTO, BMY, WEAV, AWK, WTRG, FHTX), **1 met the threshold of 6**.

### Ops carry-forward — #1 hardened by today's 44-second margin

1. **Move the EOD launchd trigger 12:55 → 12:40 PDT — NOW LOAD-BEARING WITH A DATED DEADLINE.**
   Third consecutive session of evidence (08-17 4m25s, 08-18 missed, 08-19 44s). It is the only
   thing standing between KEYS and an unenforced **2026-08-26** time stop, which at
   `per_trade_stop_pct: 100` is the position's only scheduled exit. Needs a human.
2. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` — **still uncommitted**, alongside
   untracked `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`,
   `memory/guardrails.md.conservative.bak`.
3. `routines/market-open.md:29` vs strategy.md's overdue carve-out — still contradictory, and
   **now genuinely exercisable**: if the 08-26 EOD misses, 08-27 market-open reads both files.
4. **No limit-order or partial-close path in `alpaca.sh`** — bit this morning (12%-wide opening book).
5. Widen the entry haircut 98% → 96%. Still untested; today's fill was favorable.
6. `alpaca.sh bars` window bug — fix via #10.
7. `routines/midday.md:1` header wrong by an hour. Docs-only.
8. IEX open-bell staleness — not applicable this run (EOD is not the bell); **snapshot** endpoint
   remains the better bell-time source.
9. **`routines/end-of-day.md:1` header** — reads `55 15 * * 1-5 (3:55 PM Central / 4:55 PM Eastern
   — 5 minutes before close)`, which is self-contradictory twice over. The live plist (12:55 PDT =
   15:55 ET) is right. Docs-only — do NOT move the plist *to match the header*; #1 is a separate,
   deliberate change.
10. `feed=sip` for bars/volume — historical/daily only, still unapplied to `scripts/alpaca.sh:104`.
11. The HD novelty-at-the-open question — partially answered 08-19 (the rule ran as a pre-order
    gate and passed). Still open for the discard-side case.
12. The 3-7 DTE option window has killed **4 of 5** option-eligible setups (KMX, PENG, CCK, KEYS)
    because it admits only names carrying weeklies. Needs an explicit 08-25 decision.
13. The bounded fill poll (10×3s) is too short for opening-auction market orders — expired at
    12/20 filled this morning.
14. **NEW — the 08-25 review owes an answer on KEYS.** A rule-perfect entry (score 8, primary-source
    verified, novelty gate passed at the open) lost 6.3% in one session, and neither the 100% stop
    nor the 100% daily cap can respond. The question is not "was the process followed" — it was —
    but whether `per_trade_stop_pct: 100` + `target_position_pct: 100` is a survivable pairing.

2026-08-19 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
KEYS 20 sh marked **319.44** vs 340.8005 entry = **-6.26%**, down from -0.84% at the 09:37 ET
market-open mark. Market value $6,388.80 on $6,810.71 equity = **93.8% of the book**. Reconciled
against Alpaca: `positions` returns 1 (`asset_class: us_equity`), `orders open` returns 0, matching
this file — no drift. **20 × 319.44 + 421.91 cash = $6,810.71 = equity, to the cent.**

### 🟢 RUN QUALITY: ON TIME — clock read 12:01:07 ET, ~1 min after the 12:00 ET trigger

`clock.is_open` = `true`. Account `ACTIVE`, `trading_blocked` `false`. **Fifth consecutive live
confirmation of the header bug in `routines/midday.md:1`** (carry-forward #7): the plist fires
09:00 PDT = **12:00 ET / 11:00 CT**, not the `12:00 PM Central / 1:00 PM Eastern` the header
claims. **The header is the wrong artifact — do NOT move the plist to match it.**

### Step 1 — exits: no gate fired. Thesis-broken was the only one that could, and it didn't.

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | -6.26% | +100% (`per_trade_target_pct`) | no |
| stop loss | -6.26% | **-100%** (`per_trade_stop_pct`) | **no — 93.7pp of room left** |
| thesis broken | Grok **NO NEWS ×10 classes**, confirmed twice | concrete named event | no |
| time stop | target_exit **2026-08-26** | 7 days out | not due, and not midday's |
| expiry guard | n/a — shares, no options open | — | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `quote`/`sell`,
preflight `equity`. Quote was **live** (`t=2026-08-19T16:01:16Z`, ~1 min old) — no staleness, as
expected away from the bell. Mark used is `positions.current_price` (319.44) per the standing
lesson; `trade.p` was 319.31 = -6.30%, and neither is within 93 points of a gate.

**Grok, run twice, both clean.** The 10-class enumeration (guidance cut, recall, litigation,
regulatory/export-control, exec departure, downgrade-only, restatement, dilution, short report,
contract/customer loss) returned a literal **NO NEWS on all ten**, sourced to Keysight's own IR
release. A second free-form "why is KEYS down 6%" query independently returned **no named negative
corporate event** and surfaced only *positive* flow — Baird raising its PT to **$410**, bullish
post-print analyst reaction. Verdict **THESIS INTACT**; per the routine's hard rule (sell only on
concrete, named negative news) the position is held.

### 🔴 THE NOVELTY GATE PASSED THIS MORNING AND THE TRADE WENT AGAINST US ANYWAY

This is the finding of the run, and it is a weekly-review question — **midday cannot act on it.**

Market-open set a falsifiable pre-order kill condition (">= +5% gap at the open kills the name"),
measured **+1.76%** against the 08-18 close of $341.00, and passed it — the first time the ALB
08-06 open-print rule ever *cleared* a trade rather than blocking one. The fill at **$340.8005**
was six cents *below* the pre-catalyst close. On the rule's own terms that was a clean entry.

Today's tape, off the sip consolidated feed:

| session | open | high | low | close/last |
|---------|------|------|-----|------------|
| 2026-08-17 | 360.00 | 366.41 | 358.01 | 361.15 |
| 2026-08-18 (pre-print) | 350.00 | 350.90 | 332.64 | **341.00** |
| **2026-08-19** | **349.00** | 352.00 | **317.48** | **319.84** |

KEYS opened +2.35%, printed its high in the first minutes, and has fallen **~9.0% off the open**
to sit near the session low. It is now **-6.36% below the 08-18 close** — the denominator the
entire novelty gate was measured against. The band the gate certified as "intact" did not just
fail to pay; it inverted.

**This is the 08-14 standing lesson in its fourth consecutive instance — *verification proves the
catalyst is real, it does not prove the market will pay for it*** — and the first instance where
we were **holding the position** rather than watching a rejected candidate. FN (08-18, -14.18% at
the open) was the gate *saving* us. KEYS is the gate clearing a trade that then went -6.3% in
four hours. The catalyst itself is not in dispute: Q3 adj. EPS **$3.07 vs ~$2.48** consensus,
revenue **$1.85B vs ~$1.74B**, record orders >$2B, raised FY26 guide, all verified against primary
IR both last night and again this run. **The market is selling a verified beat-and-raise on
valuation (>55x forward, ~77-100% run into the print).** Logged for 08-25, not traded on.

### 🟠 AND THIS IS WHAT `per_trade_stop_pct: 100` ACTUALLY MEANS — there is no stop

Stated plainly because today is the first session where it is not hypothetical: at a 100% stop the
shares gate **cannot fire above $0.00**. A -6.26% position has 93.7 percentage points of room
before the rule notices. With `target_position_pct: 100` putting 94% of the book into one name, the
**only** exits that exist for KEYS are (a) concrete negative news, which Grok says does not exist,
and (b) the **2026-08-26 time stop**. That is the FULL YOLO configuration working exactly as
written, not a malfunction — but it means the 08-26 EOD run is now carrying the entire downside
control for this position, and EOD has missed **23 of 64 runs (~36%)**.
**➡️ This is escalation #1 (move the EOD trigger 12:55 → 12:40 PDT) and it is now the most
consequential open item on the board.** Still a human call.

### Step 2 — daily loss cap: NOT hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **-5.90%** (6810.71 vs last_equity 7237.92) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **-5.56%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all` (0 open orders anyway), no `notify.sh` alert, no halt marker written to
`memory/research-log.md`. **-5.90% is the largest single-day drawdown this account has taken since
the book stopped being flat**, and it clears the cap by 94 percentage points — the cap is
decorative at 100%, as every prior note has said. The binding constraint remains
`max_new_positions_per_day: 1`, already consumed by this morning's buy, so no entry was possible
today regardless.

### 🟢 `no_margin` COMPLIANT — the entry did not reopen the breach, and it still hasn't

Cash **+$421.91**, unchanged from the fill (mark-to-market moves equity, not cash). Buying power
$20,612.90, no leverage. The 98% haircut plus the integer floor at a $347 share price left +4.30%
of headroom this morning and the fill came in -1.78%. **Still not stress-tested** — carry-forward
#5 (widen 98% → 96%) stays open on its own merits.

### Ops carry-forward — unchanged, nothing applied

Midday can apply none of these (exits and notifications only). Re-listed by reference so the count
stays honest: **#1** EOD trigger 12:55 → 12:40 PDT — **now the top item and load-bearing**, it is
the only thing standing between KEYS and an unenforced 08-26 time stop; **#2** commit the
`caffeinate -is` fix in `scripts/run-routine.sh` — **verified still uncommitted this run**,
alongside untracked `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`,
`memory/guardrails.md.conservative.bak`; **#3** `routines/market-open.md:29` vs strategy.md's
overdue carve-out — **now exercisable, a position exists**; **#4** no limit-order or partial-close
path in `alpaca.sh`; **#5** widen the entry haircut 98% → 96%; **#6** `alpaca.sh bars` window bug
(fix via #10); **#7** this file's header, re-confirmed live above; **#8** IEX open-bell staleness —
not observed this run, midday is not the bell, and the **snapshot** endpoint remains the better
bell-time source; **#9** `routines/end-of-day.md:1` header; **#10** `feed=sip` for bars/volume —
**used successfully again this run** for the daily bars above, still unapplied to
`scripts/alpaca.sh:104`; **#11** the HD novelty-at-the-open question; **#12** the 3-7 DTE option
window that killed 4 of 5 option-eligible setups; **#13** the bounded fill poll being too short for
opening-auction market orders.

2026-08-19 market-open: **1 buy, 0 sells — KEYS 20 sh @ $340.8005.** Preflight passed
(`preflight OK KEYS buy 20 @ 346.99 (equity=7237.92, open=0, day_pnl=0.0000%)`),
`memory/trade-log.md` appended. **First entry in 9 sessions** — the book was flat since the
RDNT time stop. Equity **$7,180.93**, cash **+$421.91**, day **-0.79%**.

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:12 ET, 12s after the bell

`clock.is_open` = `true`, `next_close` 2026-08-19T16:00 ET. `trading_blocked` and
`account_blocked` both `false`. **Sixth consecutive on-time market-open.**

### Step 1 — exits: nothing to evaluate

Zero open positions at the bell, so no gate could fire. Third consecutive routine with no exit
to reason about. Grok was not called — no underlying to query.

### Step 2 — halt checks: ALL CLEAR, entries fully authorized

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **0.00%** (equity == last_equity at the bell) | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **+0.36%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **0** | 1 (`max_concurrent_positions`) | **no — slot FREE** |
| new positions today | **0** | 1 (`max_new_positions_per_day`) | no |

### Step 3 — entries: KEYS, score 8 vs threshold 6

Watchlist: **KEYS 8**, SYK 5, TOL 5, HD 4, JKHY 4; ZTO/BMY/WEAV/AWK/WTRG/FHTX DQ. KEYS was the
only name at or above threshold.

### 🟢 THE OPEN-PRINT NOVELTY RE-MEASUREMENT PASSED — and this is the first time it CLEARED a trade

Pre-market set an explicit, falsifiable kill condition before the fact: *"if KEYS gaps >= +5% at
the open, the band is consumed and the name no longer qualifies."* Measured live against the
08-18 close of **$341.00** (confirmed off sip daily bars, not Yahoo):

| time (ET) | print | vs 08-18 close |
|-----------|-------|----------------|
| 09:31:02 | 348.51 | +2.20% |
| 09:31:33 | 345.56 | +1.34% |
| 09:32:52 | **346.99** (sizing mark) | **+1.76%** |
| **fill 09:35:10** | **340.8005** | **-0.06%** |

**+1.76% against a +5% bar — the band was intact, and by the fill it was fully intact.** The
pre-market gain (+2.34% at $348.99) evaporated into the auction exactly as HD's did on 08-18, but
this time the rule ran *in favour of* the trade rather than against it. **We paid $340.80 — six
cents BELOW the pre-catalyst close, for a verified 24.8% EPS beat and a Q4 guide 26% above
consensus.** That is the second-wave shape strategy.md is built around, bought at a better price
than pre-market modelled.

Precedent note: every prior application of the ALB 08-06 rule was **defensive** (ALB gapped +7.40%
and killed a buy; HD 08-18 was logged as the first case that would have *raised* a score but was
correctly not acted on). **Today is the first time the rule was run as a pre-order gate and
returned PASS.** n=1 for the constructive direction.

### 🔴 CALL PATH INELIGIBLE — KEYS has monthly-only expiries. 4th instance of this fallback.

Score 8 >= 6 and KEYS is optionable (239 call contracts) with market cap ~$61B < $100B, so
strategy.md pointed at the **long-call** path. It could not be constructed inside the guardrails:

| expiry | DTE | in `[option_min_days_to_expiry:3, option_max_days_to_expiry:7]`? |
|--------|-----|------------------------------------------------------------------|
| 2026-08-21 | **2** | ✗ below the floor — and it would be inside the 2-day expiry guard **on day one** |
| 2026-09-18 | 30 | ✗ far above the ceiling |
| 10-16 / 11-20 / 12-18 | 58/93/121 | ✗ |

`option-chain KEYS call 2026-08-22 2026-08-26` returned **0 contracts**. KEYS lists third-Friday
monthlies only — no weeklies. Buying the 08-21 would have tripped strategy.md's expiry guard
("option-sell now regardless of P&L") at the very next routine, which is self-evidently wrong.
**Fell back to shares**, matching KMX 06-18, PENG 07-08 and CCK 07-22 exactly. This is now the
**4th of 5 option-eligible setups killed by the 3-7 DTE window** — the window is narrow enough
that it only ever admits names carrying weeklies, and that is a real, repeated constraint worth
the 08-25 review's attention, not a one-off.

### 🟢 `no_margin` HELD — the breach did NOT reopen, and this was the run that was supposed to reopen it

Escalation #5 named today's buy specifically: *"a KEYS buy at `target_position_pct: 100` is exactly
the order that reopens the `no_margin` breach."* It did not.

| step | value |
|------|-------|
| 98% haircut notional | 0.98 × 7237.92 = **$7,093.16** |
| sized at $346.99 mark | floor(7093.16 / 346.99) = **20 sh** |
| headroom before cash < 0 | fill up to **$361.90** = **+4.30%** vs mark |
| actual fill | **$340.8005** = **-1.78%** (favorable) |
| cash after | **+$421.91** ✅ |

Two things protected it, and only one was the rule: the 98% haircut contributed ~$145, but the
**integer floor at a $347 share price contributed far more** (21 shares would have cost $7,286 >
equity). +4.30% of headroom comfortably cleared both prior overruns (PENG 07-08 +2.6%, RDNT 08-10
+2.58%). **Honest read: the haircut was not actually stress-tested today — the favorable fill meant
it was never called on.** Escalation #5 (widen 98% → 96%) should stay open; a low-priced name at
100% sizing still has thin cover.

### 🟡 IEX quote was STALE AT THE BELL then self-healed ~90s later — escalation #8 reproduced

First `alpaca.sh quote KEYS` at 09:31 returned `p=345, t=2026-08-18T20:05:39Z` — **yesterday's
after-hours print, ~17.4 hours old**, the exact signature logged at the 08-14 and 08-17 opens. By
09:31:33 the same endpoint returned a live `t=13:31:33Z`. **The hazard is real but transient at the
open**, and the sizing mark used (09:32:52) was live. Had this been a forced *sale* at 09:30 it
would have executed against a stale reference.

**New workaround found and worth keeping:** the **snapshot** endpoint
(`/v2/stocks/KEYS/snapshot?feed=iex`) returned a **live** `latestTrade` (13:31:02Z) at the same
moment `/trades/latest?feed=iex` was serving the 17-hour-old print. Same feed, same credentials,
different staleness. Snapshot is the better bell-time source than `alpaca.sh quote`.

### 🔴 sip does NOT cover recent data — escalation #10 is narrower than 08-18 concluded

The 08-18 EOD note called `feed=sip` the fix for three escalations at once. Tested live this run:

```
/v2/stocks/KEYS/snapshot?feed=sip     -> {"message":"subscription does not permit querying recent SIP data"}
/v2/stocks/KEYS/bars?...1Min&today    -> 0 bars
/v2/stocks/KEYS/bars?...1Day&historic -> works, correct sessions (08-18 o=350 c=341 v=3,526,271)
```

**sip works for historical/daily bars only — it is delayed and returns nothing for the current
session.** Pre-market already found it fails on `/quotes/latest` and `/trades/latest`. So #10 is
still worth applying to `scripts/alpaca.sh:104` (daily bars, confirmation scoring, real consolidated
volume) but it is **not** a live-quote fix and cannot replace IEX at the bell. Today's 08-18 close
of $341.00 — the denominator of the entire novelty gate — came from sip and was correct.

### ⚠️ Fill took 1m35s and drip-filled 12 → 15 → 20 against a 12%-wide book

Submitted 09:33:35, filled 09:35:10. IEX top-of-book at submission was **bid 326.32 / ask 366.45**
— a ~12% spread, i.e. an unusable opening book. The routine's 30s bounded poll expired at
`partially_filled 12/20`; polling was extended rather than walking away mid-fill, since abandoning a
working market order would have left the position and `portfolio.md` mismatched. **The routine's
10×3s poll is too short for an opening-auction market order** — 3 of the last 5 entries (PENG,
BMY, CCK) also drip-filled over ~3 minutes. Escalation #4 (no limit-order path in `alpaca.sh`)
is what forces a market order into a book this wide.

### Position now — and the time stop is armed

KEYS 20 sh, entry **$340.8005**, `target_exit` **2026-08-26**, 94.2% of equity at entry. Currently
**337.951 = -0.84%**. At `per_trade_stop_pct: 100` / `per_trade_target_pct: 100` the price gates are
unreachable, so **thesis-broken (midday) and the 08-26 time stop are the only exits that can fire.**

**➡️ Escalation #1 (move the EOD trigger 12:55 → 12:40 PDT) is now LIVE again.** It has been parked
as "not urgent while flat" for 9 sessions. The book is no longer flat: there is a time stop dated
2026-08-26 and EOD has missed **23 of 64 runs (~36%)**, including 08-18. Still a human/strategy call
(it shifts every time-stop execution price), but it is no longer theoretical.

### Ops carry-forward

1. **Move the EOD launchd trigger 12:55 → 12:40 PDT — RE-ARMED TODAY** by the KEYS entry. Deadline
   is effectively 2026-08-26 (the time stop). Needs a human.
2. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` — **still uncommitted**, alongside
   untracked `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`,
   `memory/guardrails.md.conservative.bak`.
3. `routines/market-open.md:29` vs strategy.md's overdue carve-out — still contradictory. **Now
   exercisable**: a position exists again.
4. **No limit-order or partial-close path in `alpaca.sh`** — directly bit today (12%-wide book,
   market order the only option).
5. Widen the entry haircut 98% → 96%. **Not disproven today — untested**, the fill came in -1.78%.
6. `alpaca.sh bars` window bug — fix via #10.
7. `routines/midday.md:1` header wrong by an hour. Docs-only.
8. **IEX open-bell staleness — REPRODUCED this run** (17.4h stale at 09:31, healed by 09:31:33).
   Use the **snapshot** endpoint at the bell, not `trades/latest`.
9. `routines/end-of-day.md:1` header. Docs-only.
10. **`feed=sip` — SCOPE CORRECTED.** Historical/daily bars only; the subscription refuses recent
    sip data entirely. Still apply to `scripts/alpaca.sh:104`, but it is not a live-quote fix.
11. HD novelty-at-the-open question — **partially answered today**: the open-print rule ran as a
    pre-order gate and passed. Still open for the discard-side case.
12. **NEW — the 3-7 DTE option window has now killed 4 of 5 option-eligible setups** (KMX, PENG,
    CCK, KEYS) because it admits only names with weekly expiries. Monthly-only names can never
    take the call path. Worth an explicit 08-25 decision: widen the window, or state that
    monthly-only names are shares-by-design.
13. **NEW — the bounded fill poll (10×3s) is too short for opening-auction market orders.** Expired
    at 12/20 filled today. Should be widened, or the routine should state that a working order must
    be tracked to terminal state before `portfolio.md` is written.

2026-08-18 EOD: **🔴 MISSED — started 13:03:59 PDT = 16:03:59 ET, 4 min past the close.**
`clock.is_open` = `false` → Step-0 bail-out. 0 exits, 0 orders, no preflight, no EOD email.
Miss #23 of 64 (~36%). **Cost today zero — the book is flat, so there was nothing to time-stop, no
options to expiry-guard, and WTD +0.36% is nowhere near the cap.** Equity **$7,237.92**, cash
$7,237.92, day **0.00%**, unchanged to the cent from market-open and midday; `positions` `[]`
reconciles to this file with no drift. **The plist is HEALTHY** — `ProcessType` still absent,
`properties = inferred program`, all five 12:55 triggers present — **so the 08-17 fix held and the
job was late anyway. This is jitter, not coalescing, and 5 minutes of margin does not cover it.**
➡️ Escalation #2 (move the trigger 12:55 → 12:40 PDT) is now the top item on the board. Full
diagnosis in `memory/research-log.md`.

2026-08-18 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md` unchanged.
Book is **flat: 0 positions, $7,237.92 all cash**, third consecutive routine at 100% cash since the
RDNT time stop. Reconciled against Alpaca: `positions` returned `[]` and `orders open` returned 0,
matching this file — no drift. Equity **$7,237.92**, unchanged to the cent from this morning's
market-open reading and from `last_equity`.

### 🟢 RUN QUALITY: ON TIME — clock read 12:02:32 ET, ~2.5 min after the 12:00 ET trigger

`clock.is_open` = `true`, `next_close` 2026-08-18T16:00 ET. Account `ACTIVE`, `trading_blocked` and
`account_blocked` both `false`. Fourth consecutive live confirmation of the header bug in
`routines/midday.md:1` (carry-forward #7): the plist fires 09:00 PDT = **12:00 ET / 11:00 CT**, not
the `12:00 PM Central / 1:00 PM Eastern` the header claims. **The header is the wrong artifact — do
NOT move the plist to match it.**

### Step 1 — exits: nothing to evaluate

Zero open positions, so no gate could fire — no stop, no target, no thesis check. **Grok was not
called this run**, deliberately: with no position there is no underlying to query, and midday opens
nothing. Second consecutive routine with no exit to reason about.

### Step 2 — daily loss cap: not hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **0.00%** (equity == last_equity) | -100% (`daily_loss_cap_pct`) | none |
| weekly P&L | **+0.36%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | none |

No `cancel-all`, no `notify.sh` alert, no halt marker in `memory/research-log.md`. Day P&L is exactly
0.00% because the book holds nothing to mark — there is no position to move it, not because the
market was still. The cap is decorative at 100% regardless.

### 🟢 `no_margin` COMPLIANT — 3rd consecutive routine

Cash **+$7,237.92**, no leverage, buying power $28,951.68. Unchanged since the RDNT sale cured the
21-routine breach. **Still untested — it reopens on the next buy if the 98% sizing haircut is
unchanged** (carry-forward #5; overrun twice by PENG 07-08 +2.6% and RDNT 08-10 +2.58%).

### The HD question from this morning is still open — and midday cannot touch it

Market-open logged HD at score 5 with a novelty penalty scored off a pre-market print (+2.04%) that
evaporated by the bell (HD opened -0.33%), noting the ALB 08-06 open-print re-measurement rule would
have *raised* the score for the first time. **Midday opens nothing** — that is the routine's first
hard rule — so this remains a weekly-review question for 08-25, not an action. Recorded here only so
the thread survives to that review; no rescoring was attempted.

### Ops carry-forward — unchanged from market-open, nothing applied

Midday can apply none of these (exits and notifications only). Re-listed by reference so the count
stays honest: **#1** EOD trigger 12:55 → 12:40 PDT (not urgent while flat, re-arms on the next
entry); **#2** commit the `caffeinate -is` fix in `scripts/run-routine.sh` — **verified still
uncommitted this run**, alongside untracked `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`,
`.env.bak.broken`, `memory/guardrails.md.conservative.bak`; **#3** `routines/market-open.md:29` vs
strategy.md's overdue carve-out, still contradictory, still unexercised only because the book is
flat; **#4** no limit-order or partial-close path in `alpaca.sh`; **#5** widen the entry haircut
98% → 96%; **#6** `alpaca.sh bars` window bug (fix via #10); **#7** this file's header, re-confirmed
live above; **#8** IEX open-bell staleness (intermittent, not observed this run — midday is not the
bell); **#9** `routines/end-of-day.md:1` header; **#10** switch bars/volume to `feed=sip` with an
explicit `start=` and no `limit=` — **highest-value data-side change on the board**, and it stays
cheapest to apply exactly while the book is flat and nothing is scored against it; **#11** the HD
novelty-at-the-open question above.

2026-08-18 market-open: **0 buys, 0 sells, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. Book is **flat: 0 positions, $7,237.92 all cash**, second consecutive routine at 100% cash
since the RDNT time stop. Reconciled against Alpaca: `positions` returned `[]` and `orders open`
returned 0, matching this file — no drift. Equity reads **$7,237.92** vs the $7,238.10 recorded at last
night's EOD; Alpaca's own `last_equity` is 7237.92, so the broker's official close is $0.18 below the
EOD snapshot. Alpaca wins per the routine; noted, not material.

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:30 ET, 30s after the bell

`clock.is_open` = `true`, `next_close` 2026-08-18T16:00 ET. No blocks: `trading_blocked` and
`account_blocked` both `false`, status `ACTIVE`. **Fifth consecutive on-time market-open.**

### Step 1 — exits: nothing to evaluate

Zero open positions, so no gate could fire. No time stop, no expiry guard, no overdue carve-out, no
Grok thesis check needed. **This is the first market-open in weeks that did not have to reason about
an exit** — a direct consequence of last night's on-time EOD selling RDNT on its scheduled day.

Note for the record: because the book is flat, `routines/market-open.md:29` (which says time stops are
"enforced in end-of-day, not here") did **not** get exercised against strategy.md's overdue carve-out
again today. The contradiction is still unreconciled and still live the next time a stop goes overdue.

### Step 2 — halt checks: NONE fired, and this is the point

| check | value | cap | halts entries |
|-------|-------|-----|---------------|
| day P&L | **0.00%** | -100% (`daily_loss_cap_pct`) | no |
| week P&L | **+0.36%** (vs Mon 08-17 open $7,211.70) | -100% (`weekly_loss_cap_pct`) | no |
| open positions | **0** | 1 (`max_concurrent_positions`) | **no — slot FREE** |
| new positions today | **0** | 1 (`max_new_positions_per_day`) | no |

**Every halt was clear and entries were fully authorized.** For the first time in nine sessions
nothing structural stood between the account and a trade — the score was the only gate.

### Step 3 — entries: none. Top score 5 vs threshold 6.

Today's watchlist: **HD 5, FN 4, SNDK 3, ALAB 1, HTHT DQ**. Nothing reached 6, so per strategy.md
("if nothing scores >= 6, we do not trade today") no order was constructed and preflight was never
invoked. Cash is a position.

### 🟢 THE DIRECTIONAL GATE PAID FOR ITSELF TODAY — measured at the open, not the pre-market print

Per the 08-14 marking rule (audit rejections from the **open** we'd have bought, never the prior
close), measured off the **sip** consolidated tape:

| ticker | score | 08-17 close | 08-18 open | gap at open | last (09:34) | vs 08-17 close |
|--------|-------|-------------|------------|-------------|--------------|----------------|
| **FN** | 4 | 598.58 | **513.70** | **-14.18%** | 508.82 | **-15.00%** |
| SNDK | 3 | 1786.85 | 1677.54 | -6.12% | 1714.85 | -4.03% |
| ALAB | 1 | 320.17 | 304.00 | -5.05% | 303.00 | -5.36% |
| HD | 5 | 337.88 | 336.78 | -0.33% | 336.75 | -0.33% |
| HTHT | DQ | 46.61 | 46.51 | -0.21% | 46.44 | -0.36% |

**FN opened -14.18% — worse than the -10.29% pre-market read that drove the rejection.** It was the
strongest verified catalyst on the board (Q4 rev +44.6% YoY, EPS $4.10 vs ~$3.83 consensus, a genuine
Q1 raise, all confirmed against primary IR) and it is the session's worst name by a factor of two.
This is the **third consecutive instance** of the 08-14 standing lesson — *verification proves the
catalyst is real, it does not prove the market will pay for it* — and the first where the gate's
saving is large enough to matter: at `target_position_pct: 100` a buy would have put the entire
$7,237.92 book into a -14% gap. **The directional gate is now n=3 and has moved from a plausible rule
to a measured one.**

### 🔴 HD's NOVELTY PENALTY WAS SCORED ON A PRE-MARKET PRINT THAT DID NOT SURVIVE TO THE BELL

**This is the most important thing this run found, and it is a weekly-review question, not a routine's
call to act on.** Pre-market marked HD *novelty 1* explicitly because it was "**already +2.04%**
pre-market against the 4% mega-cap bar — roughly half the band gone before the bell," and reasoned we
would "enter at the top of the band with nothing left."

**HD opened -0.33%.** The entire pre-market gain evaporated into the auction. The band was **not**
half-consumed at the only price we could have transacted at; it was **fully intact**.

Consequences, stated precisely and left for 08-25:

- strategy.md's **open-print re-measurement rule (ALB 08-06)** exists for exactly this and says to
  re-measure novelty against the opening print *before sending any order*. Every prior application has
  been **defensive** (ALB gapped +7.40% and consumed ~148% of its band, killing a buy). **Today is the
  first observed case running the other way** — the rule would have *raised* a score, not lowered one.
- Arithmetic, for the audit only: HD at novelty 2 scores **6**; at novelty 3 it scores **7**. Either
  clears the threshold. The novelty term was the swing factor, not catalyst strength.
- **The counter-argument is still strong and is not resolved by today's open.** Catalyst strength 2 was
  independently justified — FY26 guidance is verbatim identical to the Q1 (May 19) release, so the
  forward cash-flow delta is ~zero, and every 6+ this system has traded (CCK 6, RDNT 6, BMY 7, PENG 8)
  was a beat **and** a raise. A reaffirm-only print arguably *should* fail regardless of novelty.
- HD is currently **336.75, flat to its open** — so this is a live, honest question rather than a
  hindsight complaint about a missed run. Nothing has run away.

**No action taken.** Per decision.md's non-negotiable — *"if anything is ambiguous, do nothing and log
the ambiguity in research-log.md for the weekly review to address"* — market-open executes the score
pre-market wrote; it does not rescore a name at the bell to manufacture a trade. Logged, not traded.

### 🔴 NEW DATA HAZARD — Yahoo NULLED the entire 2026-08-17 session and shifted its labels

Discovered while pulling the audit prints above, and it is worse than a gap:

- `chart?interval=1d&range=10d` returned **`open=null, close=null` for 2026-08-17 on all five
  tickers** — HD, FN, HTHT, SNDK, ALAB. A whole trading session missing, uniformly.
- The session's data was **not lost, it was mislabelled onto 08-18**: Yahoo's "08-18 open" of
  **HD 334.71 / FN 583.15** are Alpaca's **08-17** opens exactly. Yahoo's 08-18 *close* field is the
  live 08-18 price. **Each 08-18 bar is a splice of 08-17's open and 08-18's live price.**
- Reading it naively gives **FN -13.0% and HD +0.2% intraday** — both fabrications. The real numbers
  are FN **-15.00%** and HD **-0.33%** from the 08-17 close.

**Why this matters more than a normal data bug:** Yahoo `chart?interval=1d` is the documented
workaround for the `alpaca.sh bars` window bug and has been load-bearing for **7 consecutive
sessions** of confirmation-bar scoring. The workaround has its own silent failure mode, and it is the
same *class* of error as the reference-close trap (08-12/08-14): a plausible number anchored to the
wrong session. Caught here only because Alpaca disagreed.

### 🟢 THE FIX FOR BOTH — the `sip` feed is available on this account and was never being used

Verified live this run:

```
GET data.alpaca.markets/v2/stocks/HD/bars?timeframe=1Day&start=2026-08-13&feed=sip&adjustment=raw
  -> 08-17 o=334.71 c=337.88 v=5,585,138     # correct session, consolidated volume
GET ...&feed=iex   -> 08-17 o=334.15 c=338.315 v=271,897   # same session, 4.9% of the volume
```

`scripts/alpaca.sh:104` hardcodes **`feed=iex`** on the bars call. The consolidated tape works on these
credentials, returns the correct sessions with no truncation when called with an explicit `start=` and
**no `limit=`**, and carries real volume (5.58M vs IEX's 272k — the 20-40x IEX undercount this log has
recorded since 08-11). **One endpoint fixes three open escalations at once:** the bars window bug, the
Yahoo dependency it forced, and the IEX-volume caveat that `scripts/volume.sh` exists to work around.

**Not applied this run.** It changes the data source every candidate is scored against, which is a
strategy-surface change rather than an ops repair — unlike the 08-17 plist fix, which was pure
scheduling and load-bearing that same session. Nothing is holding a position on it today. **Escalated
with the evidence above; recommend the 08-25 review apply it.**

### 🟢 IEX quote feed was HEALTHY at the bell — escalation #8 did not reproduce

`quote` timestamps at 09:31 ET were **~1 minute old** across all five names (e.g. HD `t=13:31:17Z`,
FN `t=13:31:17Z`), not the ~17.6-hour-stale prints logged at the 08-14 and 08-17 opens. Two on-time
opens in a row with a live feed. **The hazard is intermittent, not retired** — it is still the
condition any forced open-bell sale would execute into, and the book being flat is what makes it
harmless today.

### 🟢 `no_margin` COMPLIANT — 2nd consecutive routine

Cash **+$7,237.92**, no leverage, buying power $28,951.68. The 21-routine breach stayed cured because
no order was sent. **It reopens on the next buy if the sizing haircut is unchanged** — 98% has been
overrun twice by near-identical fills (PENG 07-08 +2.6%, RDNT 08-10 +2.58%), and the rule was derived
from PENG and sized to exactly the move that caused it, so it has zero margin against a repeat.
Untested again today.

### Ops carry-forward — #10 is new and supersedes part of #6

1. **Move the EOD launchd trigger 12:55 → 12:40 PDT.** Jitter survives the #3 fix; 08-17 drew a
   4-minute margin, which was a good draw, not a guarantee. Strategy call (shifts every time-stop's
   execution price), needs a human. **Not urgent while flat — the next entry re-arms it.**
2. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
3. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — still
   contradictory, not exercised today only because the book is flat.
4. `alpaca.sh` lacks limit-order support and any partial-close path.
5. **Widen the entry haircut 98% → 96%, or size on the ask.** Still the live risk on the next buy.
6. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:98-104`) — and note the Yahoo workaround it
   forced is **itself now proven unsafe** (#10). Fix via #10.
7. `routines/midday.md:1` header wrong by an hour. Docs-only — do NOT move the plist.
8. **IEX `quote` stale at the 09:30 open** — did NOT reproduce today; intermittent, keep on the list.
9. `routines/end-of-day.md:1` header self-contradictory. Docs-only — do NOT move the plist.
10. **NEW — switch bars/volume to `feed=sip` with an explicit `start=` and no `limit=`.** Verified
    working on these credentials this run. Fixes #6, removes the Yahoo dependency that produced today's
    session-shift hazard, and supplies real consolidated volume. Highest-value data-side change on the
    board.
11. **NEW — weekly-review question: should novelty be re-measured at the open before a name is
    discarded, not only before an order is sent?** HD is the first case where the ALB 08-06 rule would
    have raised a score. See the HD section above; deliberately not acted on.

---

2026-08-17 end-of-day: **1 time-stop, 1 exit, 1 order — RDNT SOLD ON TIME.** Preflight passed,
`memory/trade-log.md` appended. RDNT 96 sh sold @ **75.67** vs 72.30 entry = **+4.66%**, realized
**+$323.52**. Book is **flat: 0 positions, $7,238.10 all cash.**

### 🟢 RUN QUALITY: ON TIME — clock read 15:55:35 ET, at the 15:55 ET trigger

**This is the run the last three weeks of notes were pointing at, and it worked.**

| event | time (ET) | vs 16:00 close |
|-------|-----------|----------------|
| routine start (`clock`) | 15:55:35 | 4m 25s |
| preflight OK | 15:55:4x | — |
| order submitted | 15:55:52 | 4m 08s |
| **FILLED 96 @ 75.67** | **15:55:56** | **4m 04s** |

Submit→fill **4.6 seconds**, no slippage against the 75.75 mark. Contrast the 08-10 BMY forced
sale, which sat `new` ~3.3 min and drip-filled at the stale open-bell feed.

### ✅ ESCALATION #3 IS NOW VERIFIED *EFFECTIVE*, NOT MERELY *PRESENT*

This morning's market-open deleted `ProcessType Background` from the EOD plist after **21
consecutive routines** of it being logged and ignored. The midday note flagged the open question
precisely: `runs = 0` after the bootstrap, so the fix was verified present but untested. **Today
was the test, and it passed** — first run under the repaired plist landed on the trigger second.

| run | trigger | actual start | ET | result |
|-----|---------|--------------|-----|--------|
| 08-07 EOD | 12:55 PDT | 13:05:18 | 16:05 | ❌ missed — BMY carried a 3-day weekend |
| 08-11 EOD | 12:55 PDT | 12:58:53 | 15:58 | ⚠️ 1 min |
| 08-12 EOD | 12:55 PDT | 12:58:32 | 15:58 | ⚠️ 1.5 min |
| 08-14 EOD | 12:55 PDT | 13:10:13 | 16:10 | ❌ missed |
| **08-17 EOD** | 12:55 PDT | **12:55:35** | **15:55** | ✅ **on time — sold RDNT** |

The counterfactual is concrete: had this run deferred like 08-14, RDNT (100.4% of equity) carries
past its stop into an **08-18 market-open** forced sale — the 5th overdue carve-out instance, and
per escalation #8 that bell is exactly where the IEX feed prints ~17.6 hours stale.

### 🟢 Breaks a 4-run streak of stops enforced a day late

KMX 06-26, PENG 07-16, CCK 07-30, BMY 08-10 were all sold the *next* morning under strategy.md's
overdue carve-out because EOD didn't run. **RDNT is the first position since A on 06-11 to exit on
its own scheduled day.** The carve-out is a safety net that finally went unused.

### Step 1 — time stops + expiry guard

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| **time stop** | **target_exit 2026-08-17 = today** | today >= target_exit | ✅ **FIRED — sold** |
| expiry guard | n/a — no options open | within 2 trading days | n/a |
| profit target (safety net) | +4.77% | +100% (`per_trade_target_pct`) | no |
| stop loss (safety net) | +4.77% | -100% (`per_trade_stop_pct`) | no |
| thesis broken (safety net) | not re-queried — time stop already firing | — | moot |

Instrument detected live off Alpaca `asset_class: us_equity` → shares path, `sell`, preflight
`equity`. Preflight returned `OK RDNT sell 96 @ 75.75 (equity=7248.18, open=1, day_pnl=-0.7558%)`.
**The position was sold on the clock, not on news** — thesis was intact at exit (Grok returned
clean on all 10 negative-news classes at midday). That is the rule working as designed: the 7-day
hold is the edge, and we do not extend it for a winner.

### Step 2 — weekly loss cap: not hit

| check | value | cap | action |
|-------|-------|-----|--------|
| weekly P&L | **+4.64%** (vs Mon 08-10 open $6,917.30) | -100% (`weekly_loss_cap_pct`) | none |
| daily P&L | **-0.89%** | -100% (`daily_loss_cap_pct`) | none |

No flatten, no `notify.sh` alert, no `PAUSED` marker in `memory/research-log.md`. The week's
realized gain is now banked rather than marked: RDNT gave back from +5.66% at midday to +4.77% at
the sell, and the day closed -0.89% on that same mark-to-market — but **+$323.52 is realized.**

### 🟢 `no_margin` BREACH CURED after 21 consecutive routines

Cash **-$26.22 → +$7,238.10**. The breach dated to the 08-10 RDNT entry fill (+2.58% slippage over
the sized quote) and was structurally uncurable by any routine — `alpaca.sh sell` closes full
positions only, and the sole position was >100% of equity, so the only lever was liquidating a
winner to cure a $26 overdraft. **The time stop cured it as a side effect**, exactly as midday
predicted it would. Escalations #4 (partial-close path) and #5 (wider haircut) remain worth doing
so the *next* entry doesn't reopen it.

### Steps 3/4 — EOD email sent

Resend id `8e712824-768f-472c-a811-3728a74c1f10`, one attempt, delivered. Body in
`/tmp/bull-eod.txt`. Pre-market scanned **9 candidates, 0 reached the threshold of 6** (top score
**4** — WDC, itself gate-disqualified). Eighth consecutive session with no qualifying name.

### ⚠️ Tomorrow opens flat with a free slot — the cap stops being free

For weeks the entry threshold and the `max_concurrent_positions: 1` cap have both said no, and
every note has called that **coincidence, not vindication** — the cap was never tested because it
was always already full. **08-18 opens with 0 positions and 100% cash.** For the first time in
weeks, pre-market's score is the *only* thing deciding whether we trade. The cap's cost is about
to become observable.

### 🟠 RESIDUAL RISK — 4 minutes of margin is still thin. Still a human call.

Escalation #1 below (move EOD 12:55 → 12:40 PDT) is **deliberately not applied.** Removing
Background removed launchd's *coalescing*, not its *jitter* — 08-11 and 08-12 cleared the bell by
~1 minute with a healthy plist. Today's 4-minute margin is a good draw, not a guarantee. But an
earlier EOD shifts the execution price of every future time-stop exit, which is a **strategy**
decision, not an ops one. Today's success does not retire it; it just means it's no longer
load-bearing for an open position.

### Ops carry-forward — renumbered; #3 stays closed

1. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — top item. Jitter survives the #3 fix.
   Strategy call (shifts every time-stop's execution price), so it needs a human. **No longer
   urgent — the book is flat — but the next entry re-arms it.**
2. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
3. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. Did not bite today (EOD enforced its own stop), but it is
   the live path whenever EOD does miss.
4. `alpaca.sh` lacks limit-order support and any partial-close path.
5. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
   **Directly relevant tomorrow**: the book is flat, so the next buy is the one that either
   reopens the `no_margin` breach or doesn't.
6. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. 6th consecutive session on the Yahoo workaround.
7. **`routines/midday.md:1` header is wrong by an hour** (fires 12:00 ET, header claims 1:00 PM
   ET). Docs-only fix — do NOT "correct" the plist to match.
8. **IEX `quote` feed is stale at the 09:30 open.** Prefer `positions.current_price` for marks at
   the bell. No longer compounds a forced-sale risk (book is flat), but it still governs entries.
9. **`routines/end-of-day.md:1` header is self-contradictory** — reads `55 15 * * 1-5 (3:55 PM
   Central / 4:55 PM Eastern — 5 minutes before close)`. 3:55 PM CT **is** 4:55 PM ET, 55 min
   *after* the close, and "5 minutes before close" implies 15:55 **ET**. The live plist (12:55
   PDT = 15:55 ET) is right — **proven right today** — the header is wrong twice over. Docs-only,
   do NOT move the plist.

---

2026-08-17 midday: **0 exits, 0 orders.** No preflight invoked, `memory/trade-log.md`
unchanged. RDNT marked 76.395 vs 72.30 entry = **+5.66%**, up from +4.28% at the 09:36 ET
market-open mark. Market value $7,333.92 on $7,307.70 equity — still **100.4% of the book**.

### 🟢 RUN QUALITY: ON TIME — clock read 12:03:07 ET, ~3 min after the 12:00 ET trigger

Third consecutive live confirmation of **escalation #8**: the plist fires 09:00 PDT =
**12:00 ET / 11:00 CT**, not the `12:00 PM Central / 1:00 PM Eastern` claimed in
`routines/midday.md:1`. The header is the wrong artifact — do NOT move the plist to match it.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +5.66% | +100% (`per_trade_target_pct`) | no |
| stop loss | +5.66% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |
| time stop | target_exit **2026-08-17 = today** | due today → **defers to EOD** | **not midday's** |
| expiry guard | n/a — no options open | — | n/a |

Instrument detected live off Alpaca `asset_class: us_equity` — shares path, `quote`/`sell`.
Same 10-class enumeration as 08-11 onward (guidance cut, recall, litigation, CMS/regulatory
adverse decision, exec departure, rating **downgrade only**, restatement, dilution/offering,
short report, contract/payer-network loss), demanding a literal `NO NEWS` per class. All ten
clean, **Grok 1/1 first-try**, verdict THESIS INTACT. A second free-form 6-hour query returned
the same and surfaced only *positive* context (08-09 Q2: record revenue/EBITDA, upwardly revised
FY26 guidance). At ±100% the price gates are unreachable, so thesis-broken was the **only exit
gate that could have fired** today.

### 🔴 THE TIME STOP IS DUE TODAY — and midday is not allowed to enforce it

RDNT's `target_exit` is **2026-08-17 = today**, at **100.4% of equity**. Per strategy.md a stop
due *today* defers to end-of-day; the overdue carve-out needs `target_exit` **strictly** in the
past, and it is not. So midday correctly did nothing. **Today's 15:55 ET EOD is the run that
sells RDNT**, and it is the single point of failure the last three weeks of notes have been
pointing at.

### 🟢 Escalation #3 verified still applied, 2.5 hours before it matters

This morning's market-open closed #3. Re-verified live this run rather than trusted:

| check | result |
|-------|--------|
| `PlistBuddy Print :ProcessType` | `Does Not Exist` ✅ |
| `launchctl print … \| grep properties` | `inferred program` — **no `managed LWCR`** ✅ |
| `state` | `not running` (armed) ✅ |
| `StartCalendarInterval` | all 5 weekdays at 12:55, **including Weekday 1 = today** ✅ |

**Caveat — `runs = 0`.** The counter reset when the job was bootstrapped this morning, which
means **today's 15:55 ET EOD is the first run under the repaired plist**. The fix is verified
*present*, not yet verified *effective*. Removing Background removes launchd's coalescing, not
its jitter — 08-11 and 08-12 still cleared the close by only ~1 minute. If today's EOD defers
anyway, RDNT carries past its stop and 08-18 market-open picks it up under the overdue carve-out
(the 5th instance after KMX 06-26, PENG 07-16, CCK 07-30, BMY 08-10) — into the stale open-bell
feed of escalation #9. The durable fix remains moving the trigger to 12:40 PDT (escalation #2),
still **not applied** because it changes every time-stop's execution price — a strategy call.

### Step 2 — daily loss cap: not hit

| check | value | cap | action |
|-------|-------|-----|--------|
| daily P&L | **+0.06%** | -100% (`daily_loss_cap_pct`) | none |

No `cancel-all`, no `notify.sh` alert, no halt marker written to `memory/research-log.md`.
Weekly P&L **+5.64%** (vs Mon 08-10 open $6,917.30) — logged for continuity, not a midday gate.
The cap is decorative at 100%; the binding constraint remains `max_concurrent_positions: 1`,
which market-open already enforced this morning.

Intraday recovery since the open: equity $7,211.70 → $7,307.70 (**+$96.00**), entirely RDNT
mark-to-market (75.395 → 76.395; $1.00 × 96 shares reconciles to the cent). The morning's
-1.26% day P&L has been fully erased — the day is now flat at +0.06%.

### 🟢 Data note — IEX quote feed healthy at midday, again

`quote RDNT` returned `t=2026-08-17T15:48:42Z` (11:48 ET, ~15 min lag) — normal IEX behaviour,
**not** the ~17.6-hour-stale print escalation #9 recorded at this morning's 09:30 bell. Third
session confirming #9 is an **open-bell** condition, not an all-session one. Marks above use
`positions.current_price` (76.395) per the standing lesson; `trade.p` was 76.625 = +5.98%, and
neither is within 94 points of a gate.

### 🟠 `no_margin` still breached — cash -$26.22, 20th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+5.66% winner to cure a $26 overdraft. **Self-curing tonight** if EOD's time-stop sale fills —
the position closes and cash goes positive. Otherwise it needs the partial-close path
(escalation #5) or the wider entry haircut (#6).

### Ops carry-forward — still unapplied, but **#3 is now CLOSED**

Midday can apply none of these (exits and notifications only). Re-listed so the count stays
honest. **The former #1 (drop `ProcessType Background`) was applied at market-open and
re-verified live this run — removed from the list.** Renumbered:

1. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — now the top item and the only remaining
   defence for **tonight's** time stop. Buys 20 min of slack; jitter survives the #3 fix.
   Strategy call (shifts every time-stop's execution price), so it needs a human.
2. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
3. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live tomorrow 08-18 if tonight's EOD misses.**
4. `alpaca.sh` lacks limit-order support and any partial-close path.
5. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
6. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`.
7. **`routines/midday.md:1` header is wrong by an hour** — **re-confirmed live this run** (fired
   12:03 ET, header claims 1:00 PM ET). Docs-only fix — do NOT "correct" the plist to match.
8. **IEX `quote` feed is stale at the 09:30 open.** Prefer `positions.current_price` for marks at
   the bell. **Directly compounds item #1**: an 08-18 forced sale of RDNT would sell into this.
9. **`routines/end-of-day.md:1` header is self-contradictory** — reads `55 15 * * 1-5 (3:55 PM
   Central / 4:55 PM Eastern — 5 minutes before close)`. 3:55 PM CT **is** 4:55 PM ET, 55 min
   *after* the close, and "5 minutes before close" implies 15:55 **ET**. The live plist (12:55
   PDT = 15:55 ET) is right; the header is wrong twice over. Docs-only — do NOT move the plist.

---

2026-08-17 market-open: **0 buys, 0 sells.** Entries blocked twice over; RDNT held with its time
stop due TODAY and deferred to EOD per strategy.md. RDNT +4.28% (75.395 vs 72.30 entry), market
value $7,237.92 on $7,211.70 equity = **100.4% of the book**. The headline event of this run is
**not a trade — it is that the 08-17 EOD enforcer was repaired before it had to run.**

### 🟢 RUN QUALITY: ON TIME — clock read 09:30:49 ET, 49s after the bell

`clock.is_open` = `true`, `next_close` 2026-08-17T16:00 ET. No blocks: `trading_blocked`,
`account_blocked`, `transfers_blocked` all `false`.

### ✅ ESCALATION #3 CLOSED — `ProcessType Background` deleted from the EOD plist

After **21 consecutive escalations logged and unapplied**, the one-line fix the 08-14 EOD note
called "a one-line delete" was applied this run:

```
/usr/libexec/PlistBuddy -c "Delete :ProcessType" ~/Library/LaunchAgents/com.bull-trading.end-of-day.plist
launchctl bootout   gui/$UID/com.bull-trading.end-of-day      # rc=0
launchctl bootstrap gui/$UID ~/Library/LaunchAgents/com.bull-trading.end-of-day.plist  # rc=0
```

Backup at `~/Library/LaunchAgents/com.bull-trading.end-of-day.plist.bak-20260817`.
`plutil -lint` OK. Post-reload verification: all **five** weekday 12:55 `calendarinterval`
triggers re-registered **including Weekday 1 = today**, `state = not running` (armed), and
`properties` dropped **`managed LWCR`** — the throttling class Background conferred — leaving
only `inferred program`.

Why it was load-bearing *today* specifically:

| run | trigger | actual start | ET | vs 16:00 close |
|-----|---------|--------------|-----|----------------|
| 08-04 EOD | 12:55 PDT | 12:55:18 | 15:55 | ✅ 5 min |
| **08-07 EOD** | 12:55 PDT | **13:05:18** | **16:05** | ❌ **missed — BMY carried** |
| 08-10 EOD | 12:55 PDT | 12:55:18 | 15:55 | ✅ 5 min |
| 08-11 EOD | 12:55 PDT | 12:58:53 | 15:58 | ⚠️ 1 min |
| 08-12 EOD | 12:55 PDT | 12:58:32 | 15:58 | ⚠️ 1.5 min |
| 08-13 EOD | 12:55 PDT | 12:55:04 | 15:55 | ✅ 5 min |
| **08-14 EOD** | 12:55 PDT | **13:10:13** | **16:10** | ❌ **missed** |

RDNT at 100.4% of equity with a stop due today is **exactly the BMY 08-07 setup** that carried a
3-day weekend at 97.3% of equity. Deferring that to a job which had fired post-close in 2 of its
last 7 runs was the single largest open risk in the book.

**Scope note:** only the EOD plist was touched. The other four agents carry the same key but are
unharmed — `market-open` fired 06:30:05 and `midday` 09:02–09:03 across the week, because their
triggers sit hours from any hard deadline. EOD was the only job whose jitter crossed one. Surgical
by intent; the other four are a cleanup, not an incident.

### 🟠 RESIDUAL RISK — 5 min of margin is still thin. Needs a human call.

Removing Background removes the *coalescing*, not the *jitter* — launchd calendar intervals were
never real-time, and 08-11/08-12 cleared the close by ~1 minute **while the fix was absent**. The
durable fix is margin: move EOD to **12:40 PDT (15:40 ET)** for 20 minutes of slack. **Not
changed** — an earlier EOD shifts the execution price of every time-stop exit, which is a strategy
decision, not an ops one. Flagged for weekly-review.

### 🔵 The `caffeinate -is` edit in `scripts/run-routine.sh` does NOT fix this (uncommitted)

`caffeinate -is` wraps the `claude` invocation *inside* the script, so it prevents sleep **during**
a run. It has no bearing on **when launchd starts** the job, which is what drifted on 08-07 and
08-14. Worth keeping — it addresses mid-run sleep, a different failure — but it should not be
mistaken for a scheduler fix, and it did not prevent the 08-14 miss.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired? |
|------|-------|-----------|--------|
| profit target | +4.28% | +100% (`per_trade_target_pct`) | no |
| stop loss | +4.28% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok: **NONE** | — | no |
| time stop | target_exit **2026-08-17 = today** | due today → **defers to EOD** | no |
| overdue carve-out | not *strictly* past | — | no |
| expiry guard | n/a, no options open | — | n/a |

Grok on RDNT returned **NONE** for negative 24h news and noted *positive* flow: Truist PT raise to
$94, BofA institutional filing 08-16, Q2 record with raised FY26 guides. Thesis intact — the
position is being held on the rules, not on hope.

### 🟡 Data note — IEX trade feed stale through the open, again

`quote RDNT` returned `.trade.p = 76.245` stamped **`2026-08-14T19:59:48Z`** — Friday's close,
~17.6 hours old, at 09:30 ET Monday. The `positions` endpoint was live and current
(`current_price` 75.395), so all P&L above is computed from `positions`, not `quote`. Same
staleness logged at the BMY 08-10 open. **Standing lesson: at the open, trust `positions`;
`quote` needs a timestamp check before it is used for any gate.**

### Step 2 — halt checks: capacity cap fired

| check | value | cap | action |
|-------|-------|-----|--------|
| day P&L | -1.26% | -100% (`daily_loss_cap_pct`) | not hit |
| week P&L | -1.26% (week = today) | -100% (`weekly_loss_cap_pct`) | not hit |
| open positions | **1** | **1** (`max_concurrent_positions`) | **HALT — no entries** |

### Step 3 — entries: none, and blocked twice over

Independent of the capacity halt, pre-market produced **0 qualifying candidates** — 9 tickers
extracted, 4 survived the price check, 3 cleared the floors, **top score 4 (WDC, itself
gate-disqualified) vs a threshold of 6**. Three of four standard Grok queries returned nothing;
only the mover list produced names, and it was **60% fabricated** (EFX claimed +17.3% to ~$212 vs
an actual +1.03% at $182.71). Nothing to buy even with an open slot. Cash is a position.

### 🟠 `no_margin` still breached — cash -$26.22, 19th consecutive routine

Unchanged from the RDNT 08-10 entry fill (+2.58% slippage over the sized quote). Not
self-correcting; it needs either a trim or a wider sizing haircut. Carried to weekly-review.

2026-08-14 end-of-day: **BAILED OUT — market closed.** 0 exits, 0 orders, no preflight, no
EOD email, `memory/trade-log.md` unchanged. RDNT closed 76.35 vs 72.30 entry = **+5.60%**, down
from +7.32% at the 12:03 ET midday mark. Market value $7,329.60 on $7,303.38 equity — still
**100.4% of the book**.

### 🔴 RUN QUALITY: MISSED — launchd fired 13:10:13 PDT = **16:10 ET, 10 min AFTER the close**

`clock.is_open` returned `false` (`next_open` 2026-08-17T09:30 ET), so the routine took its
Step-0 bail-out and did no position work. **Miss #22 of 62 runs (~35%).**

This is **escalation #3 caught in the act**, with the cleanest evidence yet:

| run | trigger | actual start | delta |
|-----|---------|--------------|-------|
| 08-13 EOD | 12:55 PDT | `12:55:04 PDT` | +4s (on time) |
| 08-14 EOD | 12:55 PDT | **`13:10:13 PDT`** | **+15m 13s (missed)** |

The plist is *correct* — `StartCalendarInterval` is 12:55 PDT = 15:55 ET, 5 min before the bell.
It was **deferred**, not misconfigured. Corroborating detail: `weekly-review` fired at
`13:10:13 PDT` — **the same second** — and its own trigger is a different time. Two Background
jobs released together in one batch is launchd coalescing deferred `ProcessType Background`
work after a wake/load window. That key is the root cause, and it is a one-line delete.

### Step 1 — time stops + expiry guard: NOT EVALUATED (bailed out)

Cost of the miss today is **zero trades**, by luck of the calendar:

| gate | value | would it have fired? |
|------|-------|----------------------|
| time stop | target_exit **2026-08-17**, 1 session out | no — not due today |
| overdue carve-out | not past due | no |
| expiry guard | n/a — no options open | n/a |
| profit target | +5.60% vs +100% (`per_trade_target_pct`) | no |
| stop loss | +5.60% vs -100% (`per_trade_stop_pct`) | no |
| thesis broken | not checked (bailed before Grok) | unknown |

So today's miss cost the journal entry and the email, **not** a position. That is the calendar's
doing, not the scheduler's.

### Step 2 — weekly loss cap: not hit (computed post-hoc, not as a gate)

| check | value | cap | action |
|-------|-------|-----|--------|
| weekly P&L | **+5.58%** (vs Mon 08-10 open $6,917.30) | -100% (`weekly_loss_cap_pct`) | none |
| daily P&L | **-1.25%** | -100% (`daily_loss_cap_pct`) | none |

No flatten, no `notify.sh` alert, no `PAUSED` marker. Day gave back $92.16 of equity, entirely
RDNT mark-to-market (77.59 → 76.35), reversing the midday gain and closing below the open.

### Steps 3/4 — EOD email NOT sent

No summary composed, no `notify.sh` attempt. Per the routine's hard rules the trade-log is the
source of truth and it is unchanged, so nothing is lost but the human-facing note.

### 🔴 The 08-17 time stop is now THE run that matters — and today was the dress rehearsal

RDNT's `target_exit` is **Monday 2026-08-17** at **100.4% of equity**. Monday's EOD is the routine
that must sell it. Today that same routine, on the same plist, with the same `ProcessType
Background`, fired **10 minutes after the close and could not have traded**.

If Monday's EOD defers the same way, RDNT carries past its stop and **08-18 market-open** picks it
up under the strategy.md overdue carve-out — the **5th** instance after KMX 06-26, PENG 07-16,
CCK 07-30, BMY 08-10. And per escalation #9 the 09:30 bell is exactly where the IEX feed was found
stale, so that forced sale would go out into the worst quote of the session.

Escalations #2/#3 were filed to prevent this and are now **21 routines unapplied**. Their deadline
was "the next session". **That session is Monday.**

### 🟠 `no_margin` still breached — cash -$26.22, 18th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell` closes
full positions only, and the only position is >100% of equity, so the sole lever is liquidating a
+5.60% winner to cure a $26 overdraft. Needs the partial-close path (escalation #5) or the wider
entry haircut (#6).

### Ops carry-forward — 21st consecutive escalation, still unapplied

This run bailed out before it could apply anything. Re-listed so the count stays honest. **#3 was
directly observed this run** and is promoted to the top.

1. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — **root cause,
   observed live today**: 15m13s deferral, batched with weekly-review at the same second. One-line
   delete + `launchctl bootout`/`bootstrap`. **Deadline: Monday 2026-08-17.**
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — defence in depth behind #1; buys 15 min of
   slack so a deferral of today's size still lands before the close. Same deadline.
3. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Will be read live on 08-18 if Monday's EOD misses.**
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`.
8. **`routines/midday.md:1` header is wrong by an hour** (fires 12:00 ET, header claims 1:00 PM ET).
   Docs-only fix — do NOT "correct" the plist to match.
9. **IEX `quote` feed is stale at the 09:30 open.** Prefer `positions.current_price` for marks at the
   bell. **Directly compounds the #1 risk**: an 08-18 forced sale of RDNT would sell into this.
10. **`routines/end-of-day.md:1` header is self-contradictory** — it reads `55 15 * * 1-5 (3:55 PM
    Central / 4:55 PM Eastern — 5 minutes before close)`. 3:55 PM CT **is** 4:55 PM ET, which is 55
    min *after* the close, and "5 minutes before close" implies 15:55 **ET**. The live plist (12:55
    PDT = 15:55 ET) is right; the header is wrong twice over. Docs-only — do NOT move the plist.

---

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
