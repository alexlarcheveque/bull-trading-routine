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
- **Excluded:** options, futures, crypto, OTC, leveraged/inverse ETFs (anything with
  2x/3x/UltraPro/Direxion in the name), SPACs pre-merger, anything halted, anything
  with earnings inside the next 3 trading days (event risk dominates our signal).

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

## Entry rules

- Buy at the **open** following the pre-market research pass that produced the score.
- Market order, full target size in one shot (no laddering for now — keep simple).
- Target position size: **5% of account equity** per name.
- Max **2 new positions per day**, max **5 open positions** at any time.

## Exit rules (the 14-day discipline)

For every position, on entry, we record `entry_price`, `entry_date`, `target_exit_date`
(= entry_date + 14 calendar days). Exits trigger on whichever comes first:

1. **Profit target hit**: +12% from entry → sell full position.
2. **Stop loss hit**: −7% from entry → sell full position. No averaging down. Ever.
3. **Thesis broken**: the original catalyst is contradicted by new news (acquisition
   falls through, FDA reverses, guidance cut, etc.) → sell full position next bar.
4. **Time stop**: at `target_exit_date`, sell full position regardless of P&L. The
   edge has decayed; do not become a long-term investor by accident.

The midday routine enforces (2) and (3). The end-of-day routine enforces (4).

## What "best 14-day returns" means for journaling

`memory/trade-log.md` tracks each closed trade's realized return AND the
hypothetical 14-day return if we had held to the time stop. The weekly review uses
this to detect whether stops are too tight (lots of stop-outs that would have been
winners) or too loose (winners we should have let run).
