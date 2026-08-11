# portfolio.md
# Updated 2026-08-11 11:05 CT (09:05 PDT / 12:05 ET) by midday routine.

## Account
- equity: 7281.06
- cash: -26.22
- buying_power: 20355.50
- day_pnl_pct: -1.51  # vs last_equity 7392.66

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +5.30              |

## Notes

2026-08-11 midday: **0 exits.** No orders sent, so no preflight was invoked and
`memory/trade-log.md` is unchanged. Alpaca reconciled clean against the table above
(96 sh, `avg_entry_price: 72.3`, `asset_class: us_equity`) — no drift to correct.

RDNT marked 76.13 (last trade) vs 72.30 entry = **+5.30%**, down from +6.34% at the open.
The book gave back -1.51% on the day; all of it is RDNT, which is 100% of equity.

**Ran on time** — 09:05 PDT against a 09:00 PDT trigger, a normal 5-minute launchd delay and a
welcome contrast to the morning routines' recent lateness.

Verified against the actual scheduler rather than the routine header, and they disagree:
`com.bull-trading.midday.plist` fires **Hour 9 / Minute 0 local (PDT)** = **12:00 ET / 11:00 CT**,
but `routines/midday.md:1` documents the slot as `0 12 * * 1-5 (12:00 PM Central / 1:00 PM
Eastern)`. All five plists are authored in host-local PDT and anchored to ET market hours
(pre-market 03:30 = 06:30 ET, market-open 06:30 = 09:30 ET, midday 09:00 = 12:00 ET, EOD
12:55 = 15:55 ET, weekly 13:00 = 16:00 ET). **The schedule is correct; the header comment is
wrong by an hour.** Harmless today, but it is exactly the kind of stale comment that makes a
future timing bug hard to diagnose — the file a reader checks first says something the system
does not do. Added as escalation #8 (docs-only, no behavior change).

Same inspection confirms escalation #2 quantitatively: EOD fires **12:55 PDT = 15:55 ET, five
minutes before the close**, which is why the standing recommendation is 12:40 PDT (15:40 ET).

### Exit gates — RDNT (the only position)

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| stop loss | +5.30% | -100% (`per_trade_stop_pct`) | no |
| profit target | +5.30% | +100% (`per_trade_target_pct`) | no |
| thesis broken | Grok: **NO NEWS** ×2 passes | concrete named event | no |
| time stop | exit 2026-08-17 (4 sessions out) | today >= target_exit | n/a — EOD's job |
| expiry guard | n/a — `asset_class: us_equity` | within 2 trading days | n/a |

Thesis check ran twice: the standard 6-hour negative-news sweep (guidance cut, recall,
lawsuit, regulatory reversal, exec departure) returned NO NEWS, and a second pass asked
specifically what was driving the -1.5% intraday print. That also returned NO NEWS, with
Grok citing the Aug 9-10 Q2 release (record revenue $622.7M +25% YoY, adj. EBITDA $99.7M
+22.7%, Imaging Center guidance raised) as the standing catalyst and attributing today's
fade to unnamed drift. **Per the hard rule, drift with no named event is not a sell.**

One caveat on that citation: Grok is describing the *headline* Q2 print, which is not what
this entry was scored on. The 08-10 entry went in at score 6 with **novelty 1** and
**cleanliness 0** precisely because the underlying detail was worse than the headline —
adj EPS -14.7% YoY and a raised cash interest expense guide. Grok reciting the good half
back is not new confirmation, and today's three-session-green mark still does not
retroactively validate an at-threshold entry. The verdict belongs to 2026-08-17.

### Daily loss cap — not hit

`day_pnl_pct: -1.51` vs `daily_loss_cap_pct: 100`. No cancel-all, no alert, no halt marker.
Worth stating plainly: at a 100% cap this gate is decorative — it can only fire on a
near-total wipeout, so it provides no intraday protection at all in FULL YOLO mode. That is
the configured intent, not a malfunction, but it means RDNT's -100% stop is the *only* real
downside gate on 100% of the book.

### 🟠 `no_margin` still breached — cash -$26.22, 6th consecutive routine

Unchanged again (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell`
closes full positions only, and the only position is 100% of equity, so the sole available
lever is liquidating a +5.30% winner to cure a $26 overdraft. Needs the partial-close path
(escalation #5) or the wider entry haircut (#6).

### Ops carry-forward — 10th consecutive escalation, still unapplied

Midday can apply none of these; re-listed so the count stays honest.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change. Live again
   today: RDNT's time stop lands 08-17 and EOD is the routine that enforces it.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist`.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the
   two files still contradict each other.
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`.
8. **NEW — `routines/midday.md:1` header is wrong by an hour.** It claims `0 12 * * 1-5 (12:00 PM
   Central / 1:00 PM Eastern)`; the live plist fires 09:00 PDT = **12:00 ET / 11:00 CT**. Docs-only
   fix — do NOT "correct" the plist to match the comment, the plist is the right one.
