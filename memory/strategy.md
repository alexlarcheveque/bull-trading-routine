# strategy.md
# The edge, in plain English. Read by every routine before research and before deciding.

## Thesis

Material, fresh news catalysts on liquid US large-caps are reliably mispriced for the
**next ~14 calendar days** before mean-reversion or follow-on coverage closes the gap.
We are trying to be early-but-not-first on the *second wave* of price discovery, not
front-running the headline itself.

## Universe (what we are allowed to trade)

- US common stock and standard ETFs listed on NYSE / Nasdaq.
- Market cap ≥ $2B.
- 30-day average daily consolidated volume ≥ 100,000 shares (measured via scripts/volume.sh from Yahoo's consolidated tape, enforced by guardrails.md).
- **Excluded:** futures, crypto, OTC, leveraged/inverse ETFs (anything with
  2x/3x/UltraPro/Direxion in the name), SPACs pre-merger, anything halted, anything
  with earnings inside the next 3 trading days (event risk dominates our signal).
- **Options (AGGRESSIVE / video mode):** long CALLS allowed on a qualifying catalyst
  for leveraged upside. Long-only — never sell to open, no spreads, no puts. Sizing is
  on premium-at-risk (can go to zero), capped by guardrails.md (max_option_premium_pct,
  max_total_option_premium_pct). The underlying must still pass the universe + catalyst
  tests. Option exits: +80% premium take-profit, -50% premium stop, or close on the
  underlying's 7-day time stop (whichever first). Never let a contract ride to expiry.

## What counts as a "tradeable catalyst"

A news item qualifies only if it is **all three**:

1. **Material** — directly changes forward cash flows, demand, supply, regulation, or
   competitive position. (Earnings beat/raise, FDA approval, large contract win, M&A,
   regulator decision, secular demand shift, credible guidance change.)
2. **Fresh** — first surfaced in the last 24 hours, not already 5%+ priced in
   intraday. If the move already happened, we missed it.
3. **Directional** — clearly bullish for the named ticker (we do not short).

Things that do NOT qualify, even if loud:
- Generic macro takes ("rates might fall").
- Pundit price targets / analyst upgrades with no new information.
- Social-media hype with no underlying corporate event.
- Lawsuits, short reports, accounting concerns (asymmetric downside — pass).

## Signal scoring (research routine ranks the watchlist 0–10)

Each candidate gets a composite score:

- **Catalyst strength** (0–4): how big is the cash-flow / narrative delta?
- **Novelty** (0–3): how much of the move is still ahead vs. already priced in today?
- **Confirmation** (0–2): price up on above-average volume since the catalyst hit?
- **Cleanliness** (0–1): no offsetting bad news, no earnings inside 3 days, no halts?

Only score ≥ 7 trades. If nothing scores ≥ 7, **we do not trade today**. Cash is a
position.

## Entry rules (AGGRESSIVE / video mode)

- Buy at the **open** following the pre-market research pass that produced the score.
- **Instrument choice:**
  - If score **>= 8** AND the name is optionable
    (`./scripts/alpaca.sh option-chain <T> call` returns > 0 contracts):
    buy a **LONG CALL** for leveraged upside.
  - Otherwise: buy **SHARES**.
- **Shares sizing:** `target_position_pct` of equity (guardrails; currently 20%),
  market order, full size in one shot.
- **Call sizing:** target `max_option_premium_pct` of equity in premium (currently 5%).
  `contracts = floor((equity * max_option_premium_pct/100) / (ask * 100))`, min 1.
  If even 1 contract trips the premium cap (preflight rejects), **fall back to shares**.
- **Call contract selection:** type=call; expiry = nearest listed expiration in
  `[option_min_days_to_expiry, option_max_days_to_expiry]` DTE (target ~3–5 weeks);
  strike = nearest strike **at or just above** spot (ATM / slightly OTM).
- Caps: max `max_new_positions_per_day` new/day, max `max_concurrent_positions` open.
  **All sizes and caps live in guardrails.md — never hardcode them in a routine.**

## Exit rules

On entry we record `entry_price` (the **premium** for options), `entry_date`, and
`target_exit_date` (= entry_date + `max_hold_days` calendar days; currently 7). All
thresholds below come from guardrails.md — never hardcode them.

**Detecting instrument at exit time:** a position is an option iff its Alpaca
`asset_class == "us_option"`. Options use `option-quote` / `option-sell` and preflight
with a trailing `option` arg; shares use `quote` / `sell` and preflight `equity`.

**SHARES** (use `per_trade_target_pct` / `per_trade_stop_pct`):
- current = `./scripts/alpaca.sh quote <T> | jq -r .trade.p`; return = (current-entry)/entry*100.
1. Profit target: return >= +`per_trade_target_pct` (currently +25%) → sell full.
2. Stop loss:   return <= -`per_trade_stop_pct` (currently -12%) → sell full. Never average down.
3. Thesis broken (Grok on the name) → sell next bar.
4. Time stop: today >= `target_exit_date` → sell regardless of P&L.

**OPTIONS / long calls** (premium-based; use `option_target_pct` / `option_stop_pct`):
- entry premium = the BUY fill price; current premium =
  `./scripts/alpaca.sh option-quote <OCC> | jq -r '.quotes|to_entries[0].value.bp'` (bid).
- return = (current-entry)/entry*100.
1. Profit target: return >= +`option_target_pct` (currently +80%) → option-sell full.
2. Stop loss:   return <= -`option_stop_pct` (currently -50%) → option-sell full.
3. Thesis broken on the underlying → option-sell.
4. Time stop: today >= `target_exit_date` → option-sell.
5. **Expiry guard:** if the contract expires within 2 trading days, option-sell now
   regardless of P&L. NEVER let a call ride into expiration.

The midday routine enforces stop / target / thesis (both instruments). The end-of-day
routine enforces time stop + expiry guard, and re-checks the rest as a safety net.

## What "best 14-day returns" means for journaling

`memory/trade-log.md` tracks each closed trade's realized return AND the
hypothetical 14-day return if we had held to the time stop. The weekly review uses
this to detect whether stops are too tight (lots of stop-outs that would have been
winners) or too loose (winners we should have let run).
