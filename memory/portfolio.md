# portfolio.md
# Updated 2026-08-11 15:00 CT (13:00 PDT / 16:00 ET) by end-of-day routine.

## Account
- equity: 7312.98
- cash: -26.22
- buying_power: 20444.88
- day_pnl_pct: -1.08  # vs last_equity 7392.66

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +5.74              |

## Notes

2026-08-11 EOD: **0 time stops, 0 exits, 0 orders.** No preflight invoked,
`memory/trade-log.md` unchanged. Alpaca reconciled clean (96 sh, `avg_entry_price: 72.3`,
`asset_class: us_equity`) — no drift.

RDNT marked 76.45 vs 72.30 entry = **+5.74%**. The day's -1.08% is entirely RDNT
(100% of equity); it faded from +6.34% at the open to +5.74% at the bell.

### 🟠 RUN QUALITY: DEGRADED — started 15:59 ET, 1 minute before the close

The clock read `2026-08-11T15:59:02-04:00` on the bail-out check. The routine had
roughly 60 seconds of open market. **Nothing was missed** — no gate fired, so no order
was owed — but that is luck, not design. Had RDNT's time stop been due today, this run
would have had one minute to price, preflight and fill 96 shares at 100% of equity.

This is the same failure class as 08-06 and 08-07 (both logged DEGRADED, both fired
*after* the close), except today it landed just inside the window instead of just
outside. Escalation #2 remains the highest-value single fix in the backlog.

### Step 1 — time stops + expiry guard: none due

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| time stop | exit 2026-08-17 (4 sessions out) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |
| expiry guard | n/a — `asset_class: us_equity` | within 2 trading days | n/a |

### Step 1 (safety net) — stop / target / thesis re-checked

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| stop loss | +5.74% | -100% (`per_trade_stop_pct`) | no |
| profit target | +5.74% | +100% (`per_trade_target_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |

Thesis check used the 10-class enumeration (guidance cut, recall, litigation, CMS/regulatory
adverse decision, exec departure, rating **downgrade only**, restatement, dilution/offering,
short report, contract loss) demanding a literal `NO NEWS` per class. All ten clean, Grok 1/1
first-try. Attribution for the day: post-earnings momentum plus a **Truist price-target hike**.

Per strategy.md a PT change is explicitly *not* a catalyst and not new information — it is
noted as tape colour, not as confirmation. The 08-10 entry still stands on its own scorecard
(score 6, novelty 1, cleanliness 0, because adj EPS was -14.7% YoY and the cash-interest guide
went up underneath a good headline). Three green sessions do not retroactively upgrade an
at-threshold entry. The verdict belongs to 2026-08-17.

### Step 2 — weekly loss cap: not hit

WTD **+5.72%** (equity $7,312.98 vs Monday 08-10 opening equity $6,917.30) against
`weekly_loss_cap_pct: 100`. No flatten, no `PAUSED` marker.

As with the daily cap, at 100% this gate is decorative — it can only fire on a near-total
wipeout. RDNT's -100% stop remains the only real downside gate on 100% of the book.

### 🟠 `no_margin` still breached — cash -$26.22, 7th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell`
closes full positions only, and the only position is 100% of equity, so the sole lever is
liquidating a +5.74% winner to cure a $26 overdraft. Needs the partial-close path
(escalation #5) or the wider entry haircut (#6).

### Ops carry-forward — 11th consecutive escalation, still unapplied

EOD can apply none of these; re-listed so the count stays honest.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change, and today
   it nearly cost something: this run had 60 seconds of open market. RDNT's stop lands 08-17
   and EOD is the routine that enforces it.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist`.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the
   two files still contradict each other.
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`.
8. **`routines/midday.md:1` header is wrong by an hour.** It claims `0 12 * * 1-5 (12:00 PM
   Central / 1:00 PM Eastern)`; the live plist fires 09:00 PDT = **12:00 ET / 11:00 CT**. Docs-only
   fix — do NOT "correct" the plist to match the comment, the plist is the right one.
