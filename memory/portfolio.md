# portfolio.md
# Updated 2026-08-19 14:59 CT (15:59 ET) by end-of-day routine.

## Account
- equity: 6810.91
- cash: 421.91
- buying_power: 19576.84
- day_pnl_pct: -5.90  # vs last_equity 7237.92

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| KEYS   | equity     | 20  | 340.8005    | 2026-08-19 | 2026-08-26  | -6.27              |

## Notes

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
