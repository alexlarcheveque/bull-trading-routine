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
  blocked by the `no_earnings_within_days` guardrail (currently 0 in FULL YOLO
  paper-video mode, so earnings proximity is allowed).
- **Options (FULL YOLO / paper-video mode):** long CALLS allowed on a qualifying catalyst
  for leveraged upside. Long-only — never sell to open, no spreads, no puts. Sizing is
  on premium-at-risk (can go to zero), capped by guardrails.md (max_option_premium_pct,
  max_total_option_premium_pct). The underlying must still pass the universe + catalyst
  tests. Option exits: +100% premium take-profit, -100% premium stop, or close on the
  underlying's 7-day time stop / expiry guard (whichever first). Never let a contract
  ride to expiry.

## What counts as a "tradeable catalyst"

A news item qualifies only if it is **all three**:

1. **Material** — directly changes forward cash flows, demand, supply, regulation, or
   competitive position. (Earnings beat/raise, FDA approval, large contract win, M&A,
   regulator decision, secular demand shift, credible guidance change.)
2. **Fresh** — first surfaced in the last 24 hours, not already 5%+ priced in
   intraday. If the move already happened, we missed it.
   **Mega-caps (>= $100B): the priced-in bar is 4%, not 5%.** If the overnight/
   pre-market move is already >= 4%, novelty = 0 AND the name does not qualify —
   the 1–4% mega-cap drift band is consumed and there is no second wave to catch.
   (INTC 07-24: scored 7 at +4.4% pre-market, closed -7.8% same day; AMD 07-23:
   scored 7 after a +9.7% two-session stack, -5.5% two days later.) [added
   2026-07-24 weekly review]
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
- **Cleanliness** (0–1): no offsetting bad news, no halts, and passes the current
  earnings-proximity guardrail?

**Verify against the company's own IR release before scoring.** Any candidate heading for
a score ≥ 6 must have its beat/raise numbers confirmed against the primary source (company
IR / Business Wire / PR Newswire release), not an X post, screener, or secondary aggregator.
Score the primary source when they disagree. Two names moved materially on this check in one
session: PLNT 8 → 5 (the "EPS guide raise" was buyback share-count math and the underlying
guidance had gotten *worse*) and ALB 8 → 9 (secondaries said "reaffirmed"; the release showed
a raised segment guide and a 15% capex cut). PLNT then fell -12.0% and ALB rose +4.2%. [added
2026-08-07 weekly review]

FULL YOLO paper-video threshold: score ≥ 6 trades. If nothing scores ≥ 6, **we do
not trade today**. Cash is still a position when there is no named, directional
corporate catalyst.

## Entry rules (FULL YOLO / paper-video mode)

- Buy at the **open** following the pre-market research pass that produced the score.
- **Instrument choice:**
  - If score **>= 6** AND the name is optionable
    (`./scripts/alpaca.sh option-chain <T> call` returns > 0 contracts)
    AND market cap **< $100B**:
    buy a **LONG CALL** for leveraged upside.
  - Otherwise: buy **SHARES**. Mega-caps (>= $100B) take shares even when optionable:
    their catalyst drift (~1-4%) sits below the breakeven+theta hurdle of a 3-7 DTE
    ATM call — MRK 07-17 turned a -1.4% underlying move into -53% of premium in one
    session. [added 2026-07-17 weekly review]
- **Shares sizing:** `target_position_pct` of equity (guardrails; currently 100%),
  market order, full size in one shot. Compute share count at **98% of target
  notional** — `floor(0.98 × equity × target_position_pct/100 ÷ quote)` — because
  opening-auction fills on gapping catalyst names run 2–3% above the pre-open quote
  (PENG 2026-07-08 filled +2.6%, pushing cash negative against `no_margin`). The 2%
  haircut keeps a 100%-sized market order inside the cash balance. [added 2026-07-10
  weekly review]
- **Call sizing:** target `max_option_premium_pct` of equity in premium (currently 100%).
  `contracts = floor((equity * max_option_premium_pct/100) / (ask * 100))`, min 1.
  If even 1 contract trips the premium cap (preflight rejects), **fall back to shares**.
- **Call contract selection:** type=call; expiry = nearest listed expiration in
  `[option_min_days_to_expiry, option_max_days_to_expiry]` DTE (target ~3–7 days);
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
1. Profit target: return >= +`per_trade_target_pct` (currently +100%) → sell full.
2. Stop loss:   return <= -`per_trade_stop_pct` (currently -100%) → sell full. Never average down.
3. Thesis broken (Grok on the name) → sell next bar.
4. Time stop: today >= `target_exit_date` → sell regardless of P&L.

**OPTIONS / long calls** (premium-based; use `option_target_pct` / `option_stop_pct`):
- entry premium = the BUY fill price; current premium =
  `./scripts/alpaca.sh option-quote <OCC> | jq -r '.quotes|to_entries[0].value.bp'` (bid).
- return = (current-entry)/entry*100.
1. Profit target: return >= +`option_target_pct` (currently +100%) → option-sell full.
2. Stop loss:   return <= -`option_stop_pct` (currently -100%) → option-sell full.
3. Thesis broken on the underlying → option-sell.
4. Time stop: today >= `target_exit_date` → option-sell.
5. **Expiry guard:** if the contract expires within 2 trading days, option-sell now
   regardless of P&L. NEVER let a call ride into expiration.

The midday routine enforces stop / target / thesis (both instruments). The end-of-day
routine enforces time stop + expiry guard, and re-checks the rest as a safety net.

**OVERDUE time stops are enforced by whichever routine sees them first, including
market-open.** If `target_exit_date` is **strictly in the past** (not merely due today),
the position is sold at the first opportunity by any routine that runs — the end-of-day
carve-out does not apply to a stop that is already late. A stop due *today* still defers
to end-of-day as before. Rationale: EOD is a single point of failure with a ~35% miss
rate (21 of 60 runs), and this is already the de-facto practice — KMX 06-26, PENG 07-16
and CCK 07-30 were each sold at the next market-open on exactly this logic. BMY 08-07 is
the fourth instance and the first to carry over a weekend at 97% of equity. [added
2026-08-07 weekly review]

## What "best 14-day returns" means for journaling

`memory/trade-log.md` tracks each closed trade's realized return AND the
hypothetical 14-day return if we had held to the time stop. The weekly review uses
this to detect whether stops are too tight (lots of stop-outs that would have been
winners) or too loose (winners we should have let run).

**Auditing rejected candidates: mark from the OPEN of the session we would have bought,
never from the prior close.** Entries happen at the open following the research pass, so
the overnight gap is return no order of ours could have earned; crossing it inflates the
apparent cost of every rejection. HLIT 08-13 is the proof: from the 08-12 close it returned
+16.0% and read as the week's worst miss; from the 08-13 open — the only price available to
us — it returned **-3.87%**, and the rejection was correct. A 19.9pp swing that inverted the
sign of the largest finding in that review. Prior audits were inconsistent on this (the
08-07 review marked its capacity-cap cohort from the signal-day open but its freshness-DQ
tally from logged pre-market reference prices, so the two were never comparable). [added
2026-08-14 weekly review]
