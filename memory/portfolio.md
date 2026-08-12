# portfolio.md
# Updated 2026-08-12 15:00 CT (16:00 ET) by end-of-day routine.

## Account
- equity: 7360.02
- cash: -26.22
- buying_power: 20576.59
- day_pnl_pct: +0.79  # vs last_equity 7302.42

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +6.42              |

## Notes

2026-08-12 end-of-day: **0 time-stops, 0 exits, 0 orders.** No preflight invoked,
`memory/trade-log.md` unchanged. RDNT marked 76.94 vs 72.30 entry = **+6.42%**, up from
+5.81% at this morning's open.

### 🟠 RUN QUALITY: DEGRADED — started 15:58:44 ET, ~76 seconds of open market

**Second consecutive degraded EOD** (08-11 started 15:59 ET). The plist fires 12:55 PDT =
15:55 ET; this run began **3m44s late**. Nothing was owed today, so nothing was missed —
the same "completed but only by luck" outcome as yesterday, not evidence of a fix.

Contrast with this morning's market-open, which fired at 09:30:16 ET (16s after the bell).
**The lateness is specific to the EOD job.** Two on-time market-opens and two degraded EODs
in the same 48 hours is as clean a diagnostic as this will produce: escalation #2 is a
one-line plist change and it is still the highest-value fix on the board.

**RDNT's 08-17 time stop is EOD's to enforce**, and 08-17 is a Monday — the first EOD of
next week. That is the exact shape of the 08-07 failure that forced the 08-10 BMY cleanup
at market-open.

### Step 1 — time stops + expiry guard: neither fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| time stop | exit 2026-08-17 (3 sessions out) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |
| expiry guard | n/a — `asset_class: us_equity` | within 2 trading days | n/a |

No options held, so the expiry guard had nothing to act on. Instrument detected live off
Alpaca `asset_class`, not off this file.

### Step 1 (cont.) — safety-net re-check of midday's gates

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +6.42% | +100% (`per_trade_target_pct`) | no |
| stop loss | +6.42% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |

Same 10-class enumeration as 08-11 and this morning (guidance cut, recall, litigation,
CMS/regulatory adverse decision, exec departure, rating **downgrade only**, restatement,
dilution/offering, short report, contract/payer-network loss), demanding a literal `NO NEWS`
per class. All ten clean, **Grok 1/1 first-try**. This was the only price-independent gate
that could have fired — at ±100% the price gates are unreachable.

### Step 2 — weekly loss cap: not hit

WTD **+6.40%** (equity $7,360.02 vs Monday 08-10 opening equity $6,917.30) against
`weekly_loss_cap_pct: 100`. No flatten, no `PAUSED` marker written to research-log.

At 100% the cap is decorative — it can only fire on a near-total wipeout. RDNT's -100% stop
remains the only real downside gate on 100% of the book.

### Entries: none — EOD never opens positions

Pre-market scored **0 tradeable candidates, top score 3 (CAH)** against a threshold of 6.
**Fourth consecutive session** where the threshold and the capacity cap agree; as noted at
the open, the agreement is coincidence and the cap's cost is unpaid, not retired. No slot
opens before 08-17.

### 🟠 `no_margin` still breached — cash -$26.22, 10th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell`
closes full positions only, and the only position is 100% of equity, so the sole lever is
liquidating a +6.42% winner to cure a $26 overdraft. Needs the partial-close path
(escalation #5) or the wider entry haircut (#6).

**Do not let four green sessions relitigate the RDNT entry.** It went in at exactly
threshold (score 6, novelty 1, cleanliness 0). Green marks are the predicted second wave.
The verdict belongs to the **08-17** close.

### Ops carry-forward — 13th consecutive escalation, still unapplied

EOD can apply none of these; re-listed so the count stays honest. Nothing new today.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change, and today
   is the second consecutive run to demonstrate it. RDNT's stop lands Monday 08-17 on this routine.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist` — that key licenses
   the deferral that produces these 3-4 minute late starts.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. Will be read live on 08-18 if this routine misses 08-17.
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`. Ranks with the >=5d reference-close rule as an entry-side data hazard.
8. **`routines/midday.md:1` header is wrong by an hour.** It claims `0 12 * * 1-5 (12:00 PM
   Central / 1:00 PM Eastern)`; the live plist fires 09:00 PDT = **12:00 ET / 11:00 CT**. Docs-only
   fix — do NOT "correct" the plist to match the comment, the plist is the right one.
