# decision.md
# Prompt fragment for the trade-decision step. Invoked by market-open.md AFTER
# pre-market.md has written today's scored watchlist into memory/research-log.md.

You are deciding which orders to send to Alpaca right now.

## Inputs (read these, in this order)

1. `memory/strategy.md` — the thesis, signal scoring rubric, entry/exit rules.
2. `memory/guardrails.md` — hard caps. You may NOT override these.
3. `memory/portfolio.md` — current cash, open positions (ticker, qty, entry_price,
   entry_date, target_exit_date, unrealized P&L), today's realized P&L, week's
   realized P&L.
4. `memory/research-log.md` — today's pre-market entry. Look for the most recent
   block dated today, scored watchlist with composite scores 0–10.

## Procedure

### Step 1: Exits first, entries second
Before opening anything, check each open position against `strategy.md` exit rules:
- Hit stop, target, broken thesis, or time stop?
- If yes, queue a SELL for the full quantity. Run preflight, then send via
  `scripts/alpaca.sh`. Then append to `memory/trade-log.md`.

### Step 2: Halt check
- If today's P&L <= -`daily_loss_cap_pct`: STOP. No new orders. Log reason.
- If this week's P&L <= -`weekly_loss_cap_pct`: STOP and flatten any remaining
  positions. Pause trading until weekly-review.md re-enables.
- If open positions >= `max_concurrent_positions`: STOP new entries (exits still
  allowed).
- If new positions opened today >= `max_new_positions_per_day`: STOP new entries.

### Step 3: Pick from the watchlist
From today's research-log entries, take candidates with composite score >= the entry
threshold in `memory/strategy.md`, sorted descending by score. For each, in order:
- Already in portfolio? Skip (we do not add to winners).
- Earnings within `no_earnings_within_days`? Skip.
- Failed any other guardrail (price, volume, market cap, instrument type)? Skip.
- **Choose instrument + size per the strategy.md Entry rules:**
  - score >= the strategy entry threshold AND optionable
    (`alpaca.sh option-chain <T> call` > 0) → **long CALL**, sized to
    `max_option_premium_pct` of equity. Select expiry and strike from the guardrail
    DTE window in `memory/guardrails.md` (ATM/slightly-OTM). Preflight with a trailing
    `option` arg; buy via `alpaca.sh option-buy`. If the call trips the premium cap,
    fall back to shares.
  - otherwise → **shares**, qty `floor((target_position_pct/100)*equity/last_price)`.
    Preflight with a trailing `equity` arg; buy via `alpaca.sh buy`.
- If preflight exits non-zero, skip and log the reason.
- Stop once you have opened `max_new_positions_per_day` new positions OR the
  watchlist is exhausted.

### Step 4: Journal
For every order sent (buy or sell), append one row to `memory/trade-log.md`:

    YYYY-MM-DD HH:MM | TICKER | SIDE | QTY | FILL_PRICE | REASON | SCORE | EXPECTED_EXIT_DATE

Also update `memory/portfolio.md` with the new open positions and cash balance
(`scripts/alpaca.sh account` will return the authoritative numbers; do not guess).

### Step 5: Commit
`git add memory/*.md && git commit -m "market-open YYYY-MM-DD: <n> buys, <m> sells"` (no push — cron has no GitHub creds; commit locally).

## Non-negotiables

- Never bypass preflight. If preflight fails, the trade does not happen — period.
- Never average down on a losing position.
- Never open a short or anything in `disallowed_*`. Long CALLS are allowed (video mode);
  never SELL an option to open, never trade puts or spreads.
- If `memory/portfolio.md` and Alpaca disagree on positions, trust Alpaca, update
  the file, and proceed.
- If anything is ambiguous, do nothing and log the ambiguity in research-log.md
  for the weekly review to address.
