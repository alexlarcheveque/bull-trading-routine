# research-log.md
# Append-only. One block per research pass or notable event.
# Pre-market.md writes a daily watchlist block. Preflight-check.sh appends a
# rejection block whenever an order is blocked. Halt events get a marker.

## 2026-05-13 seed
Initial empty log. First watchlist will be appended by pre-market.md on the next
6:00 AM CT run. Preflight smoke-test entries from setup were intentionally
discarded.

## 2026-05-14T00:11:01Z market-open SKIPPED
- alpaca clock: is_open=false, next_open=2026-05-14T09:30:00-04:00
- routine fired after session close (timestamp ~11 PM CT 2026-05-13)
- no exits, no entries, no portfolio refresh
- no pre-market watchlist exists yet for today; pre-market.md has not run

## 2026-05-14 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- NBIS (Nebius): Q1 revenue $399M (~8x YoY vs $50.9M), EPS beat; stock rallied ~17%. Source: TheStreet, Yahoo Finance, ~May 13.
- AVGO (Broadcom): Analyst PT raise to $500 from $475, AI semis optimism. Source: QuiverQuant, ~May 14.
- MU (Micron): +4-5% on AI demand momentum, chip strength. Source: TOI, May 13.
- NVDA: +2.4% on Jensen joining Trump China trip. Source: TOI, May 13.
- AKAM (Akamai): Q1 beat, CIS cloud +40% YoY. Source: Benzinga, May 13.
- SATS (EchoStar): FCC approval of $40B wireless spectrum sale to SpaceX/AT&T. Source: TipRanks, May 13.
- UNH: +3% as Dow component. Source: Yahoo Finance, May 13.

**Q2 — pre-market movers >2% on news:**
- CSCO +14.85%: AI solutions/products unveil. Source: Bloomberg, Chartmill.
- HPE +5.52%: AI data readiness / unified private cloud press release. Source: Chartmill.
- BIIB +4.63%: Positive Phase 2 CELIA study, tau reduction + cognitive benefit in early Alzheimer's. Source: Chartmill.
- AIIO +66%: NeuroStream AI storage tech launch. Source: Benzinga.
- FISV +2.43%: Investor Day strategy press release. Source: Chartmill.

**Q3 — beat-and-raise earnings after yesterday's close:**
- CSCO: Q3 FY26 EPS $1.06 vs $1.04 cons (+$0.02), revenue $15.84B vs ~$15.56B. FY26 revenue guide raised to $62.8-63.0B from $61.2-61.7B; Q4 EPS guide $1.16-1.18 vs $1.07 cons. Source: CNBC, Morningstar/DJ, May 13-14.
- No other major US tickers reported beat-AND-raise.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- ONC (BeOne Medicines): FDA accelerated approval for Beqalzi (sonrotoclax), BCL2 inhibitor for r/r mantle cell lymphoma post-BTKi. Source: CureToday, Drugs.com, May 13.
- QSEA: $515M SPAC merger with Eight Directions Technology. (Excluded: SPAC.)
- No other material approvals/contracts/deals.

### Candidate filter pass

Already in portfolio: none. Disqualified before Alpaca check:
- AVGO, MU, NVDA, UNH: analyst-only / narrative / macro / no new material corporate news.
- AIIO: micro-cap, well below $2B universe floor.
- FISV: Investor Day with no specific guidance change cited.
- QSEA: SPAC (universe exclusion).

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume:

| ticker | tradable | 30d avg vol  | passes min_avg_daily_volume_shares (1M)? |
|--------|----------|--------------|------------------------------------------|
| NBIS   | yes      | 431,461      | NO                                       |
| AKAM   | yes      | 256,428      | NO                                       |
| SATS   | yes      | 278,254      | NO                                       |
| CSCO   | yes      | 916,989      | NO (just under)                          |
| HPE    | yes      | 1,230,118    | YES                                      |
| BIIB   | yes      | 59,904       | NO                                       |
| ONC    | yes      | 12,957       | NO                                       |

(Sandbox bars feed is sparse vs real-world volumes; filter applied as written in guardrails.md.)

### Scoring (only volume-eligible survivors)

**HPE** — AI data readiness / unified private cloud platforms press release; +5.52% pre-market.
- Catalyst strength: **1** — product/marketing announcement, no contract or revenue delta disclosed. Not a clear cash-flow event.
- Novelty: **2** — fresh, but ~5.5% already moving pre-market.
- Confirmation: **2** — latest daily bar (2026-05-08) closed 29.7→31.33 (+5.5%) on volume 1.69M vs 1.23M 30d avg.
- Cleanliness: **1** — no offsetting news, no earnings within 3 days.
- **Total: 6 — below threshold.**

### Watchlist

| ticker | score | catalyst | source |
|--------|-------|----------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- CSCO (catalyst ~9, would-be top pick): 30d avg vol 917k < 1M filter; also novelty ~0 after +14.85% pre-market — move already in.
- NBIS: blowout earnings but stock already +17%, novelty ~0; also fails volume filter.
- ONC: FDA approval (would be high catalyst strength) but 30d avg vol 13k — far below liquidity floor.
- BIIB: positive Phase 2 CELIA data, fails volume filter (60k).
- SATS: $40B FCC spectrum approval, fails volume filter (278k).
- AKAM: Q1 beat, fails volume filter (256k).
- HPE: only volume-eligible survivor, but catalyst too soft (product PR, no numbers) → score 6.

Action items for operator:
- Volume filter at 1M shares against the current sandbox bars feed eliminates almost every real large-cap. Consider either (a) lowering `min_avg_daily_volume_shares` in guardrails.md to match the data source (~250k looks closer to "liquid" in this feed), or (b) wiring a real-volume data source. Leaving guardrails.md alone for now — pre-market.md is forbidden from editing it.
- CSCO is the cleanest fundamental catalyst (beat + raise) but the novelty is already gone after the +14.85% pre-market gap. Strategy correctly excludes it on novelty grounds, independent of the volume filter.

## 2026-05-15 pre-market watchlist

Note: routine fired Friday 2026-05-15 ~20:21 ET (after Friday close). Next session is Monday 2026-05-18. Watchlist applies to Monday open. Volume filter recently calibrated to 150k (commit e8d9833).

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- MSFT: Ackman/Pershing Square new position (13F upcoming); stock +2-3%. Source: Reuters, WSJ, May 15.
- NVDA: TD Cowen PT raise $235→$275, Buy. Source: Investing.com, TipRanks, May 15.

**Q2 — pre-market movers >2% on news (May 15):**
- HCWB +217%: biotech catalyst, $1.07, low-float. Source: Benzinga.
- TDIC +101%: news-driven surge, $1.61. Source: Benzinga.
- AUUD +73%: catalyst move, $2.11. Source: Benzinga.
- SLE +68.67%: news catalyst, $6.87. Source: Benzinga.
- PZZA ~+5%: takeover speculation. Source: x.com/marketsday.
- DXCM +5.5%: earnings/news. Source: Benzinga.

**Q3 — beat-and-raise earnings after May 14 close:**
- AMAT: Q2 FY26 non-GAAP EPS $2.86 vs $2.68 cons (+$0.18, +20% YoY); Q3 revenue guide $8.95B (±$500M) and EPS $3.36 (±$0.20), above Street. Source: MarketBeat, IBD/Investors.com, Applied Materials IR, May 14/15.
- No other beat-and-raise reports identified.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- None in the 24h window.

### Candidate filter pass

Already in portfolio: none. Disqualified before Alpaca check (per strategy):
- MSFT, NVDA: analyst/investor narrative only — no new material corporate event.
- HCWB, TDIC, AUUD: sub-$5 price floor + likely <$2B market cap; low-float penny moves.
- SLE: $6.87 but Alpaca asset attributes include `overnight_halted` AND likely micro-cap; skip per cleanliness and universe.

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume + latest trade:

| ticker | tradable | 30d avg vol | passes 150k filter? | last trade (5/15) | last daily bar close (5/8) |
|--------|----------|-------------|---------------------|--------------------|-----------------------------|
| AMAT   | yes      | 218,607     | YES                 | $434.27            | $435.34                     |
| DXCM   | yes      | 227,710     | YES                 | $61.63             | $60.61                      |
| PZZA   | yes      | 38,838      | NO                  | —                  | $31.15                      |

### Scoring

**AMAT** — Q2 FY26 beat-and-raise: EPS $2.86 vs $2.68 (+$0.18), Q3 revenue guide $8.95B / EPS $3.36 above Street.
- Catalyst strength: **4** — hard cash-flow event with raised forward guidance on a semicap leader.
- Novelty: **2** — post-earnings tape essentially flat ($434.27 latest vs $435.34 prior week close); pre-earnings run ($387→$435, +12%) was largely the anticipation move, so additional rerate is plausible. Not 3 (some of the move pre-printed).
- Confirmation: **0** — flat-to-down on a beat-and-raise is the OPPOSITE of confirmation. Honest scoring: muted post-print reaction is a yellow flag, not a green light.
- Cleanliness: **1** — earnings just released (event risk past, not within next 3 days); no offsetting news; not halted.
- **Total: 7 — tradeable at threshold.** Confirmation gap noted.

**DXCM** — +5.5% pre-market on "earnings/news" (Grok unclear on specifics).
- Catalyst strength: **2** — unspecified earnings/news; can't verify material beat-and-raise.
- Novelty: **2** — latest trade $61.63 vs $60.61 prior close = +1.7%; the claimed +5.5% pre-market faded into the regular session.
- Confirmation: **1** — slight green close on the news.
- Cleanliness: **1**.
- **Total: 6 — below threshold.**

### Watchlist

| ticker | score | catalyst                                                              | source                |
|--------|-------|-----------------------------------------------------------------------|-----------------------|
| AMAT   | 7     | Q2 FY26 EPS $2.86 vs $2.68 (+$0.18); Q3 guide $8.95B rev / $3.36 EPS  | MarketBeat / IR May 14|

Skipped (below threshold or filtered):
- DXCM (score 6): vague "earnings/news" catalyst; pre-market +5.5% faded to +1.7% by close — novelty largely gone.
- PZZA (takeover rumor): 30d avg vol 38k fails 150k filter; also rumor only, not confirmed M&A.
- MSFT (Ackman 13F), NVDA (PT raise): analyst/investor narrative only — strategy excludes.
- HCWB, TDIC, AUUD: sub-$5 + micro-cap, fails universe.
- SLE: overnight_halted flag on Alpaca asset; skip per cleanliness.

Action items for operator (informational only, pre-market.md does not edit guardrails):
- AMAT made the cut largely because the post-earnings reaction was muted (confirmation=0). If Monday's open shows a gap >5% on the news, novelty will collapse and market-open.md should re-evaluate before firing the buy. Strategy's intent is "early on the second wave," not "buy a stock the market already rejected the catalyst on."
- IEX-feed bars are 5 days stale (latest 5/8 vs today 5/15). Confirmation scoring is therefore weak across the board until a real data feed is wired. Operator may want to add `quote`-based intraday-change cross-check to the scoring step.

---

# Format examples (for reference, not real entries)

## YYYY-MM-DD pre-market watchlist

| ticker | score | catalyst (one line)                                       | source        |
|--------|-------|-----------------------------------------------------------|---------------|
| TICK1  | 8     | FDA approved drug X for indication Y                      | reuters.com/..|
| TICK2  | 7     | Q1 beat $0.12 vs $0.08 consensus, raised FY guidance 8%   | bloomberg/..  |

Skipped:
- TICK3 (score 5): catalyst already +9% intraday, no novelty left
- TICK4 (score 4): analyst upgrade only, no new corporate news

## YYYY-MM-DDTHH:MM:SSZ preflight reject
- ticker: ___  side: ___  qty: ___  price: ___
- reason: ___

## YYYY-MM-DDTHH:MM:SSZ HALT daily-loss-cap
- day_pnl_pct: -3.4
- action: no new entries for the rest of the day

## 2026-05-15T20:25:30Z market-open SKIP
- reason: market closed at fire time (is_open=false, next_open 2026-05-18T09:30 ET)
- action: no exits, no entries; portfolio unchanged
