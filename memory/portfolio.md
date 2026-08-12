# portfolio.md
# Updated 2026-08-12 08:31 CT (09:31 ET) by market-open routine.

## Account
- equity: 7317.78
- cash: -26.22
- buying_power: 20458.32
- day_pnl_pct: +0.21  # vs last_equity 7302.42

## Open positions

| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| RDNT   | equity     | 96  | 72.30       | 2026-08-10 | 2026-08-17  | +5.81              |

## Notes

2026-08-12 market-open: **0 sells, 0 buys, 0 orders.** No preflight invoked,
`memory/trade-log.md` unchanged. Alpaca reconciled clean (96 sh, `avg_entry_price: 72.3`,
`asset_class: us_equity`) — no drift against yesterday's EOD file.

RDNT marked 76.50 vs 72.30 entry = **+5.81%**, up from +5.74% at yesterday's bell.

### 🟢 RUN QUALITY: HEALTHY — bail-out check at 09:30:16 ET, 16 seconds after the open

First on-time open in three sessions. Contrast with 08-11 EOD (15:59 ET, 60 seconds of
market) and the 08-06 / 08-07 EODs that fired after the close. The market-open trigger is
not the broken one — escalation #2 is specifically the *end-of-day* launchd trigger, and
RDNT's time stop lands **08-17** on exactly that routine.

### Step 1 — exits: no gate fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| profit target | +5.81% | +100% (`per_trade_target_pct`) | no |
| stop loss | +5.81% | -100% (`per_trade_stop_pct`) | no |
| thesis broken | Grok **NO NEWS ×10 classes** | concrete named event | no |
| time stop | exit 2026-08-17 (3 sessions out) | today >= target_exit | no |
| overdue carve-out | not past due | target_exit strictly in past | no |
| expiry guard | n/a — `asset_class: us_equity` | within 2 trading days | n/a |

Thesis check used the same 10-class enumeration as 08-11 (guidance cut, recall, litigation,
CMS/regulatory adverse decision, exec departure, rating **downgrade only**, restatement,
dilution/offering, short report, contract loss), demanding a literal `NO NEWS` per class.
All ten clean, Grok 1/1 first-try. Grok volunteered that the 08-09 IR release **raised**
FY26 Imaging Center guidance and reaffirmed Digital Health — that is the original entry
catalyst restated, not new information, and it does not upgrade the position.

The 08-10 entry still stands on its own scorecard (score 6, novelty 1, cleanliness 0). Four
green sessions do not retroactively upgrade an at-threshold entry. The verdict belongs to
2026-08-17.

### Step 2 — halt checks: capacity cap fired

| gate | value | threshold | fired |
|------|-------|-----------|-------|
| daily loss cap | +0.21% | -100% (`daily_loss_cap_pct`) | no |
| weekly loss cap | +5.79% WTD | -100% (`weekly_loss_cap_pct`) | no |
| concurrent positions | 1 open (RDNT) | 1 (`max_concurrent_positions`) | **YES — no new entries** |
| new positions today | 0 | 1 (`max_new_positions_per_day`) | no |

WTD +5.79% (equity $7,317.78 vs Monday 08-10 opening equity $6,917.30). At 100% both loss
caps remain decorative — they can only fire on a near-total wipeout. RDNT's -100% stop is
still the only real downside gate on 100% of the book.

### Step 3 — entries: none, and the cap was not the binding constraint

Pre-market scored **0 tradeable candidates, top score 3 (CAH)** against a threshold of 6, so
the watchlist was empty before capacity was ever consulted. **Fourth consecutive session**
where the threshold and the capacity cap agree.

As on 08-11 and in this morning's pre-market note, the agreement is coincidence and does not
show the cap is free. Yesterday's CRWV was a genuine catalyst-4 turned away only by the
freshness gate. **No slot opens before 08-17** — RDNT holds the single seat for three more
sessions, so any catalyst that appears between now and then is unbuyable regardless of score.

### 🟠 `no_margin` still breached — cash -$26.22, 9th consecutive routine

Unchanged (no orders sent). Still structurally uncurable by any routine: `alpaca.sh sell`
closes full positions only, and the only position is 100% of equity, so the sole lever is
liquidating a +5.81% winner to cure a $26 overdraft. Needs the partial-close path
(escalation #5) or the wider entry haircut (#6).

### Ops carry-forward — 12th consecutive escalation, still unapplied

Market-open can apply none of these; re-listed so the count stays honest. Nothing new today.

1. Commit the `caffeinate -is` fix in `scripts/run-routine.sh` (still uncommitted, with untracked
   `AGENTS.md`, `.agents/`, `_raw/`, `_edited/`, `.env.bak.broken`, `memory/guardrails.md.conservative.bak`).
2. **Move the EOD launchd trigger 12:55 → 12:40 PDT** — highest-value single change. RDNT's stop
   lands 08-17 and EOD is the routine that enforces it. Today's open was healthy; EOD is the
   one still at risk.
3. **Drop `ProcessType Background`** from `com.bull-trading.end-of-day.plist`.
4. Reconcile `routines/market-open.md:29` with strategy.md's overdue-time-stop carve-out — the two
   files still contradict each other. **Not exercised today** (nothing overdue), but it will be
   read live on 08-18 if the 08-17 EOD misses RDNT's stop.
5. `alpaca.sh` lacks limit-order support and any partial-close path.
6. **Widen the entry haircut 98% → 96%, or size on the ask** (PENG 07-08 +2.6%, RDNT 08-10 +2.58%).
7. **`alpaca.sh bars` window bug** (`scripts/alpaca.sh:105`, `back_days=$(( lim * 8 / 5 + 3 ))`)
   silently truncates the most recent sessions. Fix the script **and** the Step 3 instruction in
   `routines/pre-market.md`.
8. **`routines/midday.md:1` header is wrong by an hour.** It claims `0 12 * * 1-5 (12:00 PM
   Central / 1:00 PM Eastern)`; the live plist fires 09:00 PDT = **12:00 ET / 11:00 CT**. Docs-only
   fix — do NOT "correct" the plist to match the comment, the plist is the right one.
