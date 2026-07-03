# pre-market.md
# Cron: 0 6 * * 1-5 (6:00 AM weekdays, Central)
# Research catalysts, score candidates, write today's watchlist to memory/research-log.md.
# DOES NOT EXECUTE TRADES. Market-open.md handles execution.

You are the pre-market research pass for the bull trading skill.

## Read first

- `CLAUDE.md` (repo root) — project ground rules.
- `memory/strategy.md` — thesis, catalyst rubric, signal scoring.
- `memory/guardrails.md` — hard caps (universe filters live here).
- `memory/portfolio.md` — what we already hold (skip names we own).
- `memory/trade-log.md` — last week of decisions, for context only.

## Step 1: Pull live news

Call Grok with each of these queries via `./scripts/grok.sh`:

1. `"What materially bullish news hit US large-cap equities (>$2B market cap) in the last 24 hours? Cite sources. List ticker, catalyst, source, timestamp."`
2. `"Pre-market movers $(date +%Y-%m-%d): tickers up >2% in pre-market on actual news catalyst (not just gap-fill). Cite sources."`
3. `"Earnings reports released after yesterday's close that beat AND raised guidance. Ticker, the beat number, the raise number, source."`
4. `"FDA approvals, large contract wins (>$100M), M&A announcements, or regulator decisions published in the last 24 hours affecting any US-listed company."`

Save raw Grok output verbatim into `memory/research-log.md` under today's heading.

## Step 2: Build candidate list

From the four Grok responses, extract every ticker mentioned with a positive catalyst.
Deduplicate. For each ticker, apply universe filters from `memory/guardrails.md`:

- Skip if already in `memory/portfolio.md` (no adding to winners).
- Skip if any disallowed instrument substring matches.
- Skip if `./scripts/alpaca.sh asset <TICKER>` returns non-active or non-tradable.
- Skip if `./scripts/volume.sh <TICKER>` < `min_avg_daily_volume_shares`. This is REAL consolidated 30-day ADV from Yahoo (NOT Alpaca's IEX-only feed, which under-reports 4-15x and false-rejects liquid names like ESLT/CAVA). If `volume.sh` errors (delisted/unknown ticker), skip the candidate.

## Step 3: Score each survivor

Apply the scoring rubric from `memory/strategy.md` (catalyst strength 0–4, novelty 0–3,
confirmation 0–2, cleanliness 0–1). For confirmation, pull a daily bar via
`./scripts/alpaca.sh bars <TICKER> 1Day 5` and check whether the latest bar is up on
above-average volume.

Be honest about novelty: if Grok says "AAPL +6% on iPhone news" and the bar shows
the stock already up 6% today, novelty is 0–1, not 3. The move already happened.

## Step 4: Write the watchlist

Append to `memory/research-log.md`:

```
## YYYY-MM-DD pre-market watchlist

| ticker | score | catalyst (one line)                                       | source         |
|--------|-------|-----------------------------------------------------------|----------------|
| TICK1  | 8     | FDA approved drug X for indication Y                      | reuters.com/.. |
| TICK2  | 7     | Q1 beat $0.12 vs $0.08 consensus, raised FY guidance 8%   | bloomberg/..   |
| ...    | ...   | ...                                                       | ...            |

Skipped (below threshold):
- TICK3 (score 5): catalyst already +9% intraday, no novelty left
- TICK4 (score 4): analyst upgrade only, no new corporate news
```

Only rows with score >= the current entry threshold in `memory/strategy.md` are
tradeable. If nothing reaches that threshold, write a single line:
`No tradeable signal today.`

## Step 5: Commit

```
git add memory/research-log.md
git commit -m "pre-market $(date +%Y-%m-%d): <N> candidates, top score <S>"
```

## Hard rules

- NEVER call `./scripts/alpaca.sh buy` or `sell` from this routine. Research only.
- NEVER edit `memory/strategy.md` or `memory/guardrails.md` from this routine.
- If Grok returns nothing or errors three times, write `Research pass FAILED: <reason>` to research-log and exit. Market-open will see no watchlist and sit out.
