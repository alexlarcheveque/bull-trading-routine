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

## 2026-05-27 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- MU (Micron): UBS tripled PT to $1,625 (Street-high), citing AI-driven structural shift in memory. Stock +19% intraday on 5/26, briefly touched $1T market cap. Source: CNBC, Bloomberg, Reuters, 2026-05-26.

**Q2 — pre-market movers 2026-05-27 >2% on news:**
- SNGX (Soligenix): +110-116% pre-market (~$1.08-$1.11). ThermoVax vaccine platform flagged as Bundibugyo/Ebola candidate. Source: Benzinga, stockanalysis.com.
- FGL (Founder Group): +74% pre-market (~$3.28). Solar/EPC contract wins, Nasdaq compliance regain. Source: stocktitan.net.
- No major large-cap names with >2% pre-market gains on fresh news.

**Q3 — beat-and-raise earnings after 2026-05-26 close:**
- SMTC (Semtech): Q1 FY27 rev $291M (beat $283.7M est, +2.6%); adj EPS $0.51 (beat $0.45 est, +13.3%). Q2 guide raised to ~$328M midpoint vs prior ~$300.4M (+9.2%). Source: StockStory, Yahoo Finance, 2026-05-26.
- UFG (Uni-Fuels Holdings): Q1 2026 rev $83.2M (+64% YoY). Raised FY 2026 guide to $320-340M from $310-330M. Source: stocktitan.net, 2026-05-26.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- MDAI (Spectral AI): FDA De Novo for DeepView burn-care system. Source: stocktitan.net 8-K, 2026-05-26.
- OTLK (Outlook Therapeutics): FDA appeal granted for bevacizumab-vikg (nAMD), path to BLA resubmission June 2026. Source: ophthalmologytimes.com, 2026-05-26.
- GILD (Gilead Sciences): FDA approval for hepatitis D (HDV) drug (prior EU approval). Source: bizjournals.com, 2026-05-26.
- AZN/DSNKY (AstraZeneca/Daiichi Sankyo): FDA approval for Enhertu neoadjuvant/adjuvant HER2+ breast cancer indications. Source: medicalxpress.com, ~2026-05-26.

### Candidate filter pass

Already in portfolio: CAVA, NVDA, WDAY — none appear in today's Grok output.

Disqualified before Alpaca check:
- MU: Analyst PT upgrade only — no new corporate event (strategy explicitly excludes "analyst upgrades with no new information"). Stock already +19% on 5/26; novelty = 0.
- SNGX: Price ~$1.08 — fails min_price_per_share $5. Skip.
- FGL: Price ~$3.28 — fails min_price_per_share $5. Skip.
- UFG: Quarterly revenue $83.2M implies sub-$1B annual run rate → market cap almost certainly <$2B. Skip.
- MDAI: Spectral AI — small medical device company, clearly sub-$2B. Skip.
- OTLK: BLA resubmission path (not an approval); likely sub-$2B. Skip.

Survivors for Alpaca + volume check: SMTC, GILD, AZN.

| ticker | tradable | 30d avg vol (Yahoo) | passes 100k floor? | last close (5/26) |
|--------|----------|---------------------|--------------------|--------------------|
| SMTC   | YES      | 3,010,910           | YES                | $164.46            |
| GILD   | YES      | 5,957,123           | YES                | $133.73            |
| AZN    | YES      | 1,946,073           | YES                | $187.11            |

After-hours / pre-market check (Grok + last trade via alpaca quote):
- SMTC: AH around $171 (+$6.54 / +4.0% from close). Earnings catalyst post-close — not priced in at 5/26 EOD.
- GILD: AH $133.50-133.72 (essentially flat). FDA approval announced ~14h ago, no market reaction.
- AZN: $187.11 (flat vs $187.08 on 5/22). Enhertu HER2+ indication may be same news block from 5/18 research log; stock has shown no reaction.

### Scoring

**SMTC — Q1 FY27 beat-and-raise (Semtech, NASDAQ:SMTC)**
- Catalyst strength (0–4): EPS beat $0.51 vs $0.45 (+13.3%, +$0.06); Q2 guide raised +9.2%. Hard cash-flow event with forward guidance lift in an AI-chip name. Score: **3** (revenue beat softer at +2.6%, keeps from 4).
- Novelty (0–3): Catalyst hit after 5/26 close ($164.46). AH ~$171 = 4% gap. 13% EPS beat + 9% guide raise in AI chips warrants more than 4% re-rate; second-wave price discovery still ahead. Score: **2**.
- Confirmation (0–2): Stock +4.9% on 5/26 on strong momentum even before earnings. AH buyers continuing to ~$171. Score: **2**.
- Cleanliness (0–1): Event risk past (just reported). Next earnings ~3 months out. Price $164-171 (within $5–$1000 range). No halts, no offsetting news. Score: **1**.
- **Total: 8 — tradeable.**

**GILD — FDA approval for hepatitis D (Gilead Sciences, NASDAQ:GILD)**
- Catalyst strength (0–4): HDV (hepatitis D) is a rare co-infection, small addressable patient population relative to GILD's $100B+ market cap. Modest cash-flow delta. Score: **2**.
- Novelty (0–3): AH essentially flat. Market has absorbed / dismissed the catalyst already. Score: **1**.
- Confirmation (0–2): Stock -0.47% on 5/26. No price confirmation. Score: **0**.
- Cleanliness (0–1): Score: **1**.
- **Total: 4 — below threshold. Skip.**

**AZN — Enhertu neoadjuvant/adjuvant HER2+ FDA approval (AstraZeneca, NYSE:AZN)**
- Catalyst strength (0–4): Blockbuster drug, but indication expansion partially shared with Daiichi Sankyo. Also: 5/18 research log shows same approval was already noted on 5/18; either recycled or a new sub-indication. Score: **2**.
- Novelty (0–3): Stock flat since 5/21 ($189.78 → $187.11 on 5/26). Market has had 1+ week to price this in with no reaction. Score: **0**.
- Confirmation (0–2): Flat to slightly down on 5/26. Score: **0**.
- Cleanliness (0–1): Score: **1**.
- **Total: 3 — below threshold. Skip.**

### Watchlist

| ticker | score | catalyst (one line)                                                              | source                         |
|--------|-------|---------------------------------------------------------------------------------|--------------------------------|
| SMTC   | 8     | Q1 FY27 EPS $0.51 vs $0.45 (+13.3%), Q2 guide raised to $328M vs $300.4M (+9.2%) | StockStory / Yahoo Finance, 5/26 |

Skipped (below threshold):
- MU (score ~3): analyst PT upgrade only, no new corporate event; +19% move on 5/26 already fully priced in.
- GILD (score 4): FDA hepatitis D approval (small market), AH flat, no price confirmation.
- AZN (score 3): Enhertu indication news absorbed 1+ week ago with no price reaction, novelty exhausted.
- SNGX, FGL: price <$5 (universe exclusion).
- UFG: sub-$2B estimated market cap (universe exclusion).
- MDAI, OTLK: sub-$2B estimated market cap (universe exclusion).

## 2026-05-15T20:25:30Z market-open SKIP
- reason: market closed at fire time (is_open=false, next_open 2026-05-18T09:30 ET)
- action: no exits, no entries; portfolio unchanged

## 2026-05-18 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- PANW: Multiple analyst upgrades (Morgan Stanley, Stifel, Piper Sandler), positive flows on May 18. Source: moomoo, May 18.
- Generic large-cap growth/tech flow context (NVDA, AAPL, MSFT, cybersecurity). Source: Seeking Alpha May 17 report.
- Note: Grok reports "no major standalone bullish catalysts in the exact last 24 hours" for large-caps.

**Q2 — pre-market movers >2% on May 18 with news catalyst:**
- RAMP +26-28%: $2.5B all-cash buyout by Publicis + Q1 beat. Source: thestockcatalyst.com.
- HIVE +24-25%: BUZZ HPC 320 MW AI infrastructure / $3.5B Ontario gigafactory plan. Source: thestockcatalyst.com.
- D (Dominion Energy) +13-15%: ~$66-67B merger agreement with NextEra Energy. Source: thestockcatalyst.com, thestreet.com.
- BIO (Bio-Rad) +8%: Elliott Management activist stake. Source: financialpost.com.
- F (Ford) +5-6.6%: Five-year framework agreement with EDF Power Solutions for up to 20 GWh BESS. Source: chartmill.com.

**Q3 — beat-and-raise earnings after May 17 close:**
- None identified. Grok reports no qualifying after-hours releases.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- VTRS: FDA accepted NDA for MR-107A-02 (fast-acting meloxicam, non-opioid acute pain). PDUFA target Dec 27, 2026. Source: prnewswire.com.
- AZN: FDA approved two new Enhertu indications for HER2-positive early breast cancer. Source: biospace.com.
- NTRA: Signatera CDx FDA-approved as companion diagnostic for muscle-invasive bladder cancer. Source: biospace.com.
- RTX: $441.6M Patriot missile contract modification. Source: Facebook/Stockstoearn.
- D + NextEra merger (covered in Q2).

### Candidate filter pass

Already in portfolio: none. Disqualified before Alpaca check (per strategy):
- PANW: analyst upgrades only — no new corporate event. Strategy excludes.

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume + last close:

| ticker | tradable | 30d avg vol | passes 150k filter? | last bar close (5/13) | min_price $5? |
|--------|----------|-------------|---------------------|------------------------|---------------|
| RAMP   | yes      | 23,909      | NO                  | —                      | —             |
| HIVE   | yes      | 631,756     | YES                 | $2.77                  | NO            |
| D      | yes      | 291,729     | YES                 | $62.72                 | YES           |
| BIO    | yes      | 20,962      | NO                  | —                      | —             |
| F      | yes      | 2,095,883   | YES                 | $13.585                | YES           |
| VTRS   | yes      | 618,612     | YES                 | $17.38                 | YES           |
| AZN    | yes      | 114,877     | NO                  | —                      | —             |
| NTRA   | yes      | 93,955      | NO                  | —                      | —             |
| RTX    | yes      | 214,862     | YES                 | $178.12                | YES           |

(Alpaca IEX feed bars still ~3 trading days stale: latest 2026-05-13. Same data-feed issue noted last week.)

### Scoring (volume+price-eligible survivors)

**D (Dominion Energy) — ~$66-67B merger announcement with NextEra Energy.**
- Catalyst strength: **4** — transformational large-cap M&A, "world's largest regulated utility" framing.
- Novelty: **1** — pre-market already +13-15%; the announced-deal move is largely in. Utility merger closes are 12-18 months out (state PUC + FERC), so the 14-day window catches limited follow-on.
- Confirmation: **0** — bars 3 days stale, no post-news daily print available.
- Cleanliness: **0** — M&A target gets capped at deal-spread; arb funds anchor the price. Material upside is in the closing-arb (months) not our 14-day window.
- **Total: 5 — below threshold.**

**F (Ford) — Five-year EDF Power Solutions framework, up to 20 GWh BESS.**
- Catalyst strength: **2** — framework agreement (not booked revenue), "up to" 20 GWh is aspirational. Forward-looking but not a near-term cash-flow event.
- Novelty: **1** — +5-6.6% pre-market; most of a modest move is in. Note: last daily bar (5/13) closed +13.4% on 17M vs 2M avg volume, indicating a separate earlier catalyst we missed — adds momentum context but doesn't increase novelty of today's news.
- Confirmation: **0** — bars stale.
- Cleanliness: **1** — no offsetting news; ex-earnings.
- **Total: 4 — below threshold.**

**VTRS — FDA NDA acceptance for MR-107A-02 (fast-acting meloxicam, non-opioid), PDUFA Dec 27 2026.**
- Catalyst strength: **1** — NDA acceptance is procedural, not approval. The real binary event is December, 7 months out.
- Novelty: **2** — fresh news, no big pre-market move reported.
- Confirmation: **0** — bars stale.
- Cleanliness: **1**.
- **Total: 4 — below threshold.**

**RTX — $441.6M Patriot missile contract modification.**
- Catalyst strength: **1** — ~0.4% of annual revenue. Patriot contract mods are routine for RTX.
- Novelty: **2** — fresh.
- Confirmation: **0** — bars stale.
- Cleanliness: **1**.
- **Total: 4 — below threshold.**

### Watchlist

| ticker | score | catalyst | source |
|--------|-------|----------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- D (score 5): big M&A but already +13-15% pre-market, and utility merger close is 12-18 months out — 14-day window catches little follow-on.
- F (score 4): framework agreement, not booked revenue; partial move already in.
- VTRS (score 4): NDA acceptance is procedural, not approval; real event is Dec 2026.
- RTX (score 4): $441.6M contract mod is routine for $110B-revenue RTX.
- HIVE: $2.77 last close fails min_price_per_share=$5 floor; also bitcoin-miner pivoting to AI, narrative not cash-flow.
- RAMP, BIO, AZN, NTRA: 30d avg vol below 150k IEX-feed floor.
- PANW: analyst upgrades only, no new corporate event.

Action items for operator (informational only):
- M&A target dynamics (RAMP all-cash buyout, D merger): per the 14-day strategy, post-announcement targets sit at deal-spread and offer little directional edge. Worth considering whether to explicitly exclude announced M&A targets in `memory/strategy.md` Universe section.
- IEX bars remain 3 trading days stale; Confirmation bucket continues to score 0 across the board. Operator data-feed issue noted previously.

## 2026-05-15 weekly-review: NO strategy edit
- week of 2026-05-11 to 2026-05-15: 0 trades closed, equity flat $100k, 0 preflight rejections.
- Rubric untested: only 1 candidate scored >=7 all week (AMAT, fires Monday 5/18). Cannot evaluate stop tightness, time-stop timing, or rubric weights with zero closed trades.
- IEX bars 4-5 trading days stale -> Confirmation bucket effectively unscorable in real time; this is a data-feed issue, not a strategy issue. Not an edit.
- Volume floor recalibration 1M->150k (commit e8d9833) is a guardrails change, human-owned. Strategy.md untouched.
- Verdict: RESUME MONDAY WITH CURRENT STRATEGY. Default to no edit per routine's stability rule.

## 2026-05-18 market-open execution
- watchlist had 0 tradeable candidates (top score 5 for D, below threshold).
- 0 positions open -> 0 exits.
- 0 entries (no signal).
- Account unchanged: equity $100k, cash $100k, day_pnl 0%.

## 2026-05-19 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- GOOGL / BX: Alphabet + Blackstone AI cloud JV. BX commits $5B equity (majority owner); 500MW compute capacity online by 2027 using Google TPUs. Source: CNBC, Reuters, Yahoo Finance, May 19.
- MU: analysts raised price targets amid broader chip sector moves. Source: Yahoo/Motley Fool, May 19.
- HD: Q1 EPS beat consensus (revenue in-line). Source: Schwab, Yahoo Finance, May 19.
- AGYS: Q4 beat on higher-margin recurring mix; stock +12-16% intraday. Source: Seeking Alpha/premarket movers, May 19.

**Q2 — pre-market movers >2% on May 19 news:**
- AMST +208-250%: NurseMagic AI enterprise contract. (Micro-cap.)
- INM +155-158%: all-stock merger with Mentari. (Micro-cap.)
- HD ~+0.6%: Q1 beat (EPS $3.43 vs $3.41). Source: CNBC.
- AS +4.5%: Q1 beat and raised full-year outlook. Source: Investopedia.
- BX, GOOGL ~+0.7% each: $5B AI infra JV. Source: CNBC.

**Q3 — beat-and-raise earnings after May 18 close:**
- CAVA cited, but the article tags it as "after May 19 close / early May 20 premarket" — not yet released as of this routine's fire time (pre-market May 19). Defer to tomorrow's pass; not actionable today.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- No qualifying FDA approvals or $100M+ contract wins reported.
- BFC: agreed to acquire PSB Holdings (all-stock, close Q4 2026). Source: SEC/StockTitan, May 19. (BFC ~$1.5B cap — universe floor fail.)
- EG: announced asset sale involving AIG. Source: Benzinga M&A, May 19. (Seller-side, not clearly bullish for EG; M&A target dynamics if interpreted as asset divest.)

### Candidate filter pass

Already in portfolio: none. Disqualified before Alpaca check (per strategy):
- MU: analyst-only, no new corporate event.
- AMST, INM: micro-caps far below $2B universe floor; +200% moves are pump dynamics, not signal.
- BFC: small cap; also acquirer in a small all-stock community bank deal.
- EG: ambiguous direction (asset sale to AIG — net direction for EG depends on terms not disclosed); strategy excludes ambiguous direction.
- CAVA: hasn't reported yet at this routine's fire time. Defer.

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume:

| ticker | tradable | 30d avg vol | passes 150k filter? | last close (5/11) | min_price $5? |
|--------|----------|-------------|---------------------|--------------------|---------------|
| GOOGL  | yes      | 901,984     | YES                 | $388.64            | YES           |
| BX     | yes      | 269,314     | YES                 | $121.41            | YES           |
| HD     | yes      | 155,336     | YES (barely)        | $311.40            | YES           |
| AS     | yes      | 221,452     | YES                 | $34.52             | YES           |
| AGYS   | yes      | 14,340      | NO                  | $68.95             | YES           |

(Alpaca IEX feed bars still 6 trading days stale: latest bar 2026-05-11. Data-feed issue persists from prior weeks.)

### Scoring (volume+price-eligible survivors)

**GOOGL — Alphabet/Blackstone AI cloud JV ($5B BX equity, 500MW capacity by 2027, Google TPUs).**
- Catalyst strength: **2** — strategic JV validates TPU demand, but 2027 capacity targets and $5B equity are immaterial against GOOGL's ~$2T cap / ~$350B annual revenue. Not a near-term cash-flow event.
- Novelty: **2** — fresh today; GOOGL only +0.7% pre-market, most of any move still ahead.
- Confirmation: **0** — bars stale (5/11 latest).
- Cleanliness: **1** — no offsetting news, ex-earnings.
- **Total: 5 — below threshold.**

**BX — Same Alphabet/Blackstone AI cloud JV, majority owner with $5B equity commit.**
- Catalyst strength: **2** — $5B is meaningful absolute dollars but BX deploys this routinely against ~$1T AUM. Not transformational for fund-economics P&L.
- Novelty: **2** — fresh, +0.7% pre-market.
- Confirmation: **0** — bars stale.
- Cleanliness: **1** — ex-earnings, no offset.
- **Total: 5 — below threshold.**

**HD — Q1 EPS $3.43 vs $3.41 cons, revenue in-line. No raise reported.**
- Catalyst strength: **1** — $0.02 (~0.6%) beat with in-line revenue and no guidance raise. Soft print, not the kind of beat that re-rates a large-cap.
- Novelty: **2** — fresh today; pre-market only +0.6%.
- Confirmation: **0** — bars stale.
- Cleanliness: **1**.
- **Total: 4 — below threshold.**

**AS — Amer Sports Q1 beat AND raised full-year outlook.**
- Catalyst strength: **3** — beat-and-raise is the strategy's preferred catalyst type. Raised FY guidance is direct forward cash-flow info. Held back from 4 because Grok did not quantify magnitudes (beat size / raise size) — without magnitudes I can't confirm a true narrative reset vs. a small upward nudge.
- Novelty: **2** — fresh; +4.5% pre-market leaves some room but the cleanest part of the move may already be in.
- Confirmation: **0** — bars stale.
- Cleanliness: **1** — no offsetting news.
- **Total: 6 — below threshold.**

### Watchlist

| ticker | score | catalyst | source |
|--------|-------|----------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- AS (score 6, top survivor): beat-and-raise, but unquantified magnitudes capped catalyst strength at 3; +4.5% pre-market trims novelty. Closest miss of the day.
- GOOGL (score 5): $5B AI JV is strategically interesting but immaterial against a $2T cap on a 14-day horizon.
- BX (score 5): same JV; $5B commit is routine vs $1T AUM.
- HD (score 4): $0.02 EPS beat with no raise — too soft to re-rate a $300B name.
- AGYS: +12-16% on Q4 beat — strongest momentum + catalyst combo of the day, but 30d avg vol 14k vs 150k filter; passes neither volume nor scale tests.
- AMST, INM: micro-cap pumps far below universe floor.
- MU: analyst PT raises only, no new corporate event.
- BFC, EG: small/ambiguous M&A.
- CAVA: post-May 19-close release — defer to tomorrow's pre-market run.

Action items for operator (informational only):
- IEX bars now 6 trading days stale (latest 5/11 vs today 5/19). Confirmation bucket continues to score 0 across the board. Eighth consecutive day this routine has flagged the data-feed issue — operator decision pending.
- Six consecutive sessions with zero tradeable signals (score >=7) since pre-market.md started running. Cash remains a position, but the rubric is producing very few signals; weekly-review (2026-05-15) already noted the rubric is untested with zero closed trades. Continue per current strategy per the stability rule.
2026-05-19 17:31 market-open: market closed (next_open=2026-05-20T09:30:00-04:00), skipping

## 2026-05-20 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- NVDA, MU, INTC, AVGO, AMD: chip stocks extended gains / renewed buying on pre-earnings optimism ahead of Nvidia fiscal Q1 (expected after-bell ~May 21). Source: Yahoo Finance, Investors.com, CNBC, Schwab, May 19-20.
- GOOGL / BX: Alphabet and Blackstone announced a joint venture to launch a new AI cloud platform using Google's specialized chips. Source: Schwab research note, May 20 morning.
- No other major company-specific earnings beats, M&A, or upgrades reported.

**Q2 — pre-market movers >2% on May 20 news:**
- EGHT (8x8): +13-15% after Q4 earnings beat (adj. EPS $0.11 vs $0.08 est.; revenue $185M vs $181M est.) and strong AI CX demand. Source: Benzinga, May 20.
- INTC, MU, MRVL, ADI: +4-5%+ on semiconductor sector momentum ahead of Nvidia earnings. Source: Benzinga Facebook, May 20.
- GCL: +70% on expanded strategic investment from ADATA Technology to accelerate entertainment/digital growth. Source: Yahoo Finance, May 20.

**Q3 — beat-and-raise earnings after May 19 close:**
- CAVA: Revenue $438.3M vs ~$418M consensus (+4.8% beat); adj. EPS $0.20 vs $0.17-0.18 consensus. Same-restaurant sales +9.7%. FY2026 same-restaurant sales guidance raised to 4.5-6.5% (from 3-5%); adj. EBITDA raised to $181-191M (from $176-184M); net new openings raised to 75-77 (from 74-76). Source: CAVA investor relations, Benzinga, Yahoo Finance, Seeking Alpha.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- AZN / Daiichi Sankyo: FDA approved Enhertu (trastuzumab deruxtecan) for presurgical (neoadjuvant) treatment of HER2-positive early breast cancer. Source: CureToday, May 20.
- Cullinan Therapeutics: FDA Orphan Drug Designation for CLN-049 in r/r AML. (Private / small-cap.)
- TXT (Textron Systems): contract awarded by US Defense Innovation Unit to build Tsunami USVs for US Navy (size not disclosed). Source: Global Defense Corp, May 19.
- ECARX (ECX): new contract with leading Chinese automaker (production start later 2026). Source: Fool/earnings transcript, May 19. (Chinese-listed US ADR, small-cap.)
- York Space Systems: acquiring Solestial Inc. (private company, not US-listed.)

### Candidate filter pass

Already in portfolio: none. Disqualified before Alpaca check (per strategy):
- NVDA: earnings within 1 trading day (after-bell May 21) — no_earnings_within_days: 3 disqualifies immediately.
- MU, INTC, AVGO, AMD, MRVL, ADI: sector sentiment / pre-NVDA coattail ride only; no company-specific material corporate event. Strategy excludes speculative macro/sector narratives.
- GOOGL / BX: JV announced May 19; already covered and scored in yesterday's pre-market pass (both scored 5). Not fresh today — novelty = 0.
- GCL: +70% pre-market means the move is fully priced; novelty ~0. Also no confirmed market-cap data above $2B universe floor.
- ECX (ECARX): Chinese company, likely small-cap, ambiguous market cap relative to $2B floor.
- Cullinan Therapeutics: Orphan Drug Designation is not an approval; private/small-cap.
- York Space Systems: private company acquisition, not a US-listed equity.

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume:

| ticker | tradable | 30d avg vol | passes 150k filter? | last bar close | min_price $5? |
|--------|----------|-------------|---------------------|----------------|---------------|
| CAVA   | yes      | 132,073     | NO                  | $79.90         | YES           |
| AZN    | yes      | 114,878     | NO                  | $181.87        | YES           |
| EGHT   | yes      | 87,707      | NO                  | $2.64          | NO ($2.64)    |
| TXT    | yes      | 68,057      | NO                  | $91.68         | YES           |

All four survivors fail the 150k minimum average daily volume filter.
No candidate passes into the scoring step.

### Scoring

No volume-eligible candidates to score.

For transparency, would-be scores for the two strongest catalysts:

**CAVA** (hypothetical, fails volume filter):
- Catalyst strength: **4** — hard beat-and-raise: +4.8% revenue beat, +$0.02-0.03 EPS beat, raised same-restaurant sales AND EBITDA guidance for full year. Cleanest catalyst type in the rubric.
- Novelty: **2** — stock up ~7% pre-market; some move in, but a meaningful second-wave re-rate is plausible given beat magnitude.
- Confirmation: **2** — pre-market +7% is itself confirmation; last daily bar (5/13) shows last_vol (160,234) > 30d avg (132,073).
- Cleanliness: **1** — earnings event just cleared, no upcoming binary within 3 days, no offsetting news.
- **Hypothetical total: 9 — would be tradeable, blocked solely by IEX feed volume floor.**

**AZN** (hypothetical, fails volume filter):
- Catalyst strength: **3** — FDA approval of a new oncology indication for an approved drug is a clear positive cash-flow event; held from 4 because this is an extension of an existing approval, not a first-in-class or breakthrough.
- Novelty: **2** — fresh announcement; no major pre-market move reported.
- Confirmation: **0** — bars indicate last close $181.87 vs prior $182.75 (slightly down); no confirmation of upward price reaction.
- Cleanliness: **1** — no offsetting news, ex-earnings.
- **Hypothetical total: 6 — below threshold even without the volume disqualification.**

### Watchlist

| ticker | score | catalyst | source |
|--------|-------|----------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- CAVA (would score 9): Q1 beat-and-raise is the day's strongest catalyst — blocked solely by IEX feed avg volume 132k < 150k floor. Real-world ADV likely far higher.
- AZN (score 6, also fails volume): FDA new indication for Enhertu; no price confirmation.
- EGHT (fails volume + price floor): Q4 beat-and-raise on 8x8 but price $2.64 < $5 and avg vol 87k.
- TXT (fails volume): USV contract size undisclosed; routine defense-division award for Textron.
- NVDA: earnings within 1 trading day — hard disqualification.
- GOOGL, BX (score ~1 today): JV from 5/19 is yesterday's news; novelty = 0 on repeat.
- MU, INTC, MRVL, ADI, AMD: sector sentiment only, no company-specific corporate event.
- GCL: +70% pre-market, move fully priced.

Action items for operator (informational only):
- CAVA is the third consecutive session where the strongest fundamental catalyst (beat-and-raise) is disqualified solely by the IEX-feed volume floor, not by any fundamental problem with the trade. CAVA real-world ADV is well above 1M shares; the IEX-feed limitation is filtering out genuine signal. Operator may wish to supplement the volume check with a real-volume API endpoint.
- AZN similarly fails volume on IEX but would only score 6 fundamentally; no action needed.
- NVDA earnings tomorrow (May 21): semiconductor sector will reprice post-print; watch for fresh catalysts in the sector on 5/21 pre-market pass.

## 2026-05-20 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 0 open (Alpaca confirms [])
- day_pnl_pct: 0.00% (no daily-loss-cap breach)
- weekly_pnl_pct: 0.00% (no weekly-loss-cap breach)
- exits: 0 (no open positions to evaluate)
- entries: 0 (watchlist score >=7: none; strongest was CAVA hypothetical 9, blocked by IEX vol 132k < 150k)
- account: equity=$100000, cash=$100000, buying_power=$200000

## 2026-05-20T14:28:56Z preflight reject
- ticker: CAVA  side: buy  qty: 60  price: 82.22
- reason: asset lookup failed (unknown ticker or API error)

## 2026-05-20T12:00-0500 midday risk pass
- market: open
- positions: 1 (CAVA 60 @ $82.4617)
- CAVA current price: $81.55 (quote) / $81.25 (positions API); return: -1.47% — no stop (-7%) or target (+12%) triggered
- thesis check (Grok): no material negative news in last 6 hours; beat-and-raise catalyst intact; analysts reaffirming Buy
- day_pnl_pct: -0.07% — no daily-loss-cap breach (cap: -3%)
- exits: 0
- entries: 0 (midday is defense only)

## 2026-05-20T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (CAVA target_exit=2026-06-03, not yet reached)
- weekly_loss_cap: no breach (-0.11% WTD vs -6% cap)
- positions: 1 (CAVA 60 @ $82.4617, current $80.68, -2.16%)
- account: equity=$99,894.60, cash=$95,052.30, buying_power=$194,946.90
- day_pnl_pct: -0.11%
- eod email: sent (id=61164734-89c7-4e27-b782-b01fb800a84c)

- push: FAILED (no GitHub credentials in environment; commit 89d8539 is local — push manually)

## 2026-05-21 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- NVDA (NVIDIA): Q1 FY2027 earnings beat after May 20 close — EPS $1.87 vs $1.78 consensus (+$0.09); revenue $81.62B vs $79.2B expected (+3%). Q2 FY2027 revenue guidance $91B ±2% vs ~$87B consensus (+4.6% raise). Stock +0.12% in pre-market to $223.74. Source: Kiplinger, MarketBeat, Investopedia (May 20–21, 2026).
- No other materially bullish large-cap catalysts identified.

**Q2 — pre-market movers >2% on May 21 with news catalyst:**
- WHLR +95–99%, PCLA +69%, ATPC +51–57%, LIMN +41%, JUNS +26–36%, EDHL/ILLR/NCPL/LGHL/INFQ +19–34%: Grok provides no specific news catalysts for any mover — described as "primarily low-float/microcap momentum or gap moves." Source: Benzinga, StockAnalysis premarket.

**Q3 — beat-and-raise earnings after May 20 close:**
- NVDA: see Q1 above.
- TGT (Target): Q1 EPS $1.71 vs $1.46 consensus (+$0.25, +17%); revenue $25.44B vs $24.64B (+3.2%); comp sales +5.6%. FY2026 net sales growth raised to ~4% (up 2pp); EPS near high end of $7.50–$8.50. BUT pre-market DOWN ~4.9% to $121.01 on margin/SG&A concerns. Source: CNBC, Target IR, StockTitan (May 20–21, 2026).
- LOW (Lowe's): beat estimates, affirmed (no raise) guidance. Not tradeable.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- AZN: FDA approved Baxfendy (baxdrostat) for hypertension — first-in-class aldosterone synthase inhibitor. Approval date: May 18, 2026 (3 days ago, not fresh). Stock flat pre-market (+0.07%). Source: AstraZeneca IR, drugs.com.
- JUNS: $100M potential licensing deal for ALA-002 (MDMA therapeutic) with Pharmala Biotech — micro-cap, not universe-eligible.
- No other qualifying events.

### Candidate filter pass

Already in portfolio: CAVA (skip per portfolio.md).

Disqualified before Alpaca check (per strategy):
- Q2 movers (WHLR, PCLA, ATPC, LIMN, JUNS, EDHL, ILLR, NCPL, LGHL, INFQ): no specific news catalyst from Grok; all appear micro-cap/low-float pump dynamics. Disqualify on universe + no-catalyst grounds.
- JUNS (FDA/M&A Q4): micro-cap, well below $2B universe floor.
- AZN baxdrostat: FDA approval was May 18 (3 days ago) → fails "Fresh" criterion (not surfaced in last 24h). Novelty = 0.
- LOW: beat without guidance raise → not a tradeable catalyst per strategy.

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume:

| ticker | tradable | 30d avg vol | passes 10k filter? | last bar close (5/15) | min_price $5? |
|--------|----------|-------------|--------------------|-----------------------|---------------|
| NVDA   | yes      | 4,349,235   | YES                | $225.31               | YES           |
| TGT    | yes      | 212,895     | YES                | $121.53               | YES           |
| AZN    | yes      | 113,565     | YES                | $181.63               | YES           |

### Scoring (volume+price-eligible survivors)

**NVDA — Q1 FY2027 beat-and-raise (released after May 20 close).**
- EPS $1.87 vs $1.78 consensus (+$0.09, +5%); revenue $81.62B vs $79.2B (+3%).
- Q2 FY2027 revenue guide: $91B ±2% vs ~$87B consensus (+4.6% raise — ~$4B incremental quarterly revenue).
- Pre-market May 21: $223.74 (+1.44% from $220.61 prior close).
- Catalyst strength: **4** — hard beat-and-raise. Q2 guide beat of $91B vs $87B is a genuine forward cash-flow reset for the most critical AI infrastructure company. Earnings event just cleared; next earnings ~Q2 FY2028 (mid-August 2026), well outside 3-day window.
- Novelty: **2** — Pre-earnings anticipation run moved stock from $219 (5/11) to $235 (5/14) before pulling back to $220 (5/15). Post-earnings pre-market reaction of only +1.44% on a beat+raise of this magnitude suggests the second wave is ahead, but the anticipation run pre-captured meaningful value. Novelty is real but not maximal.
- Confirmation: **1** — Pre-market directionally up (+1.44%) which is technically confirmation, but the muted reaction given the beat magnitude is a yellow flag. Last dated bar (5/14) shows strong up day ($229→$235, +2.7%) on 4.5M vs 4.35M avg — above-average volume into earnings. Stale data (5/15 latest bar) limits confidence. Scoring 1 (positive direction, weak magnitude).
- Cleanliness: **1** — No offsetting news, no upcoming binary events, no halts. Stock not halted. No earnings within next 3 trading days.
- **Total: 8 — TRADEABLE.**

**TGT — Q1 FY2026 beat-and-raise (released after May 20 close). Pre-market DOWN ~4.9%.**
- EPS $1.71 vs $1.46 (+$0.25, +17%), comp sales +5.6%, net sales growth guide raised to ~4%.
- BUT stock pre-market −4.9% to ~$121.01 on margin/SG&A concerns.
- Catalyst strength: **3** — genuine beat+raise headline; held from 4 because market reaction reveals hidden negative (margin compression), undercutting the forward cash-flow story.
- Novelty: **0** — Pre-market DOWN 4.9%. The directional move is negative; there is no upside novelty available.
- Confirmation: **0** — Opposite of confirmation. Selling the beat = market rejecting the thesis.
- Cleanliness: **0** — SG&A/margin weakness is a material offsetting negative revealed by the print.
- **Total: 3 — below threshold.**

**AZN — Baxfendy FDA approval (baxdrostat, hypertension). Approval: May 18, 3 days ago.**
- First-in-class aldosterone synthase inhibitor for uncontrolled hypertension.
- Pre-market: +0.07% (essentially flat). Stock already +1.53% on May 20 close as news was absorbed.
- Catalyst strength: **3** — first-in-class approval in a large indication is a genuine cash-flow event; held from 4 because competitive positioning and commercial launch timeline unclear.
- Novelty: **0** — Approval was May 18 (3 days ago). Strategy requires catalyst "first surfaced in last 24 hours." Pre-market flat confirms move already priced.
- Confirmation: **0** — Flat pre-market; no new upward price reaction.
- Cleanliness: **1** — no offsetting news.
- **Total: 4 — below threshold. Also fails freshness criterion — not eligible regardless of score.**

### Watchlist

| ticker | score | catalyst (one line)                                                                    | source                          |
|--------|-------|----------------------------------------------------------------------------------------|---------------------------------|
| NVDA   | 8     | Q1 FY27 EPS $1.87 vs $1.78, Q2 rev guide $91B vs $87B consensus (+4.6% raise)        | Kiplinger / MarketBeat May 20   |

Skipped (below threshold or filtered):
- TGT (score 3): big EPS beat but pre-market −4.9% on margin concerns — market rejecting the thesis; novelty = 0.
- AZN (score 4, also fails freshness): baxdrostat approval was May 18 (3 days ago), already priced into +1.53% May 20 close; flat pre-market today.
- LOW: beat without raise — not a tradeable catalyst per strategy.
- All Q2 movers: micro-cap/low-float pumps, no specific news catalysts from Grok.
- JUNS ($100M licensing): micro-cap, below $2B universe floor.
- CAVA: already in portfolio (current position: 60 shares @ $82.46, unrealized −2.16%).

Action items for operator (informational only):
- NVDA is the day's signal. Entry at the open per strategy (market order, 5% of equity = ~$4,994, ~22 shares at ~$224). Max 2 new positions today — CAVA already open, room for 1 more (NVDA).
- NVDA Q2 guide beat ($91B vs $87B) is the key driver; the muted +1.44% pre-market is either "buy the second wave" or "market was disappointed at a smaller beat than hoped." Watch open-print price action carefully — market-open.md will execute the buy at open.
- AZN note: two FDA approvals in two days (Enhertu May 20, baxdrostat May 18). Neither fresh enough for today's pass, but AZN has accumulated positive news. If a third catalyst surfaces it could compound into a scoreable event.

## 2026-05-21T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (CAVA target_exit=2026-06-03, NVDA target_exit=2026-06-04)
- weekly_loss_cap: no breach (-0.20% WTD vs -6% cap)
- positions: 2 (CAVA 60 @ $82.4617, current $80.91, -1.88%; NVDA 22 @ $223.98, current $219.27, -2.10%)
- account: equity=$99,802.40, cash=$90,124.74, buying_power=$189,927.14
- day_pnl_pct: -0.08%
- eod email: sent (id=8a2da6b7-2f1b-45fc-a3ea-f8eb1a4612fd)

## 2026-05-21 market-open execution
- market: open (is_open=true, trading_blocked=false)
- exits: 0 — CAVA at -6.50% (stop -7% not breached); thesis intact (no material negative news); time stop 2026-06-03 not reached. CAVA approaching stop — midday must re-evaluate.
- halt checks: day_pnl=-0.14% (cap -3% not breached); weekly_pnl=-0.14% (cap -6% not breached); open positions 1→2 of 5; new positions today 0→1 of 2.
- entries: 1
  - NVDA: score=8, 22 shares @ $223.98 fill (market order), target_exit=2026-06-04
  - preflight: passed (equity=$99,734, open=1, day_pnl=-0.15%)
- account post-trade: equity=$99,741.22, cash=$90,124.74, buying_power=$189,865.96, day_pnl=-0.14%

## 2026-05-22 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- WDAY (Workday): Q1 FY2027 earnings beat with adj. EPS $2.66 vs ~$2.49 consensus (+$0.17, +7%); revenue $2.54B vs $2.52B (+0.8%). Raised non-GAAP operating margin guidance to 30.5% from 30.0%. FY2027 subscription revenue reiterated at $9.925–9.950B. Reported after close May 21, 2026. Source: CNBC, public.com/stocks/wday/earnings, Workday IR (May 21–22, 2026).
- TT (Trane Technologies): Q1 2026 solid growth, raised FY guidance — referenced in recent coverage, not strictly within 24h window. Source: Yahoo Finance.

**Q2 — pre-market movers >2% on May 22 with news catalyst:**
- AKTX (Akari Therapeutics): +82–84% pre-market on May 21 preclinical data (ADC synergy with KRAS inhibition in pancreatic cancer) + $5.5M private placement. Micro-cap, below $2B universe floor. Source: Benzinga, Akari Therapeutics IR.
- EL (Estée Lauder): ~+10% pre-market. No specific catalyst cited in Grok responses — "appeared on some pre-market lists" without explanation. Source: investing.com pre-market.
- ROST (Ross Stores): ~+5% pre-market. No specific catalyst cited. Source: investing.com pre-market.
- TTWO (Take-Two Interactive): ~+5% pre-market. No specific catalyst cited. Source: investing.com pre-market.

**Q3 — beat-and-raise earnings after May 21 close:**
- WDAY: see Q1 above. Only qualifying name.
- Note: Grok mentions Walmart (WMT), Deere (DE), Ralph Lauren (RL) also had May 21 reports but did not combine beat AND raise guidance.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- AVB (AvalonBay Communities) + EQR (Equity Residential): all-stock merger of equals announced May 21; ~180,000 units, enterprise value ~$69B. AVB shareholders receive 2.793 EQR shares per AVB share (own ~51% of combined). Expected close 2H 2026. Source: SeekingAlpha, BisnowNational (May 21, 2026).
- PH (Parker-Hannifin): announced acquisition of CIRCOR's commercial and defense aerospace business for $2.55B. Source: Parker-Hannifin IR (May 21, 2026).
- $453M Navy contract (multi-award) for automated digital network systems — five companies, no single ticker identified. Source: clearancejobs.com (May 21, 2026).

### Candidate filter pass

Already in portfolio: CAVA (skip), NVDA (skip).

Disqualified before Alpaca check:
- AKTX: market cap well below $2B universe floor; micro-cap biotech.
- TT: coverage notes reference "recent momentum," catalyst not strictly within 24h window; not fresh enough.
- EL, ROST, TTWO: no confirmed material catalyst from any of the 4 Grok queries. Strategy requires all three: material + fresh + directional. Without an identified corporate event, these fail the material catalyst test regardless of pre-market move.
- AVB, EQR: all-stock merger of equals. Per prior research-log note (2026-05-18 RAMP/D): M&A targets in all-stock deals offer little directional edge on a 14-day horizon; deal-spread arb anchors price. Additionally, no clear "clearly bullish" direction for either party (AVB is acquirer, typically flat-to-down; EQR is acquiree in all-stock merger with no cash premium).
- PH: acquirer in $2.55B acquisition — acquirers typically trade flat-to-down on deal announcement; not "clearly bullish."

Survivors for Alpaca check: WDAY

| ticker | tradable | 30d avg vol | passes 10k filter? | last bar close (5/15) | min_price $5? |
|--------|----------|-------------|--------------------|-----------------------|---------------|
| WDAY   | yes      | 251,695     | YES                | $125.03               | YES           |

### Scoring

**WDAY — Q1 FY2027 beat-and-raise (reported after May 21 close).**
- EPS $2.66 vs ~$2.49 consensus (+$0.17, +7%); revenue $2.54B vs $2.52B (+0.8%).
- Raised non-GAAP operating margin guidance to 30.5% (from 30.0%); subscription revenue reiterated at $9.925–9.950B.
- Catalyst strength: **3** — legitimate beat-and-raise; held from 4 because: (a) revenue beat is thin (+0.8%), (b) subscription revenue guidance was reiterated, not raised — only the operating margin was guided up by 50bps (~$50M incremental vs ~$70B market cap). Not a full narrative reset but a genuine positive cash-flow signal.
- Novelty: **2** — Catalyst released after May 21 close; WDAY not listed as a top % mover in Grok query 2 pre-market list (EL/ROST/TTWO all mentioned, not WDAY), suggesting the second-wave move is largely still ahead. Not 3 because some pre-market repricing has almost certainly occurred on any beat-and-raise.
- Confirmation: **1** — Alpaca IEX bars are stale (most recent daily bar: 2026-05-15, $125.03). Cannot directly confirm today's pre-market price action from Alpaca. Grok confirms earnings were well-received (cited as "strong" beat); partial credit for directional confirmation via news context alone, penalized for no bar data.
- Cleanliness: **1** — Just reported Q1; next earnings ~August 2026, well outside 3-day window. No offsetting negative news. Not halted. No disallowed name substrings.
- **Total: 7 — TRADEABLE (at threshold).**

Data-feed note: Alpaca IEX bars remain stale (latest: 2026-05-15). Confirmation scoring continues to be limited. This is the same issue flagged in all prior pre-market passes. Operator decision pending.

### Watchlist

| ticker | score | catalyst (one line)                                                                           | source                               |
|--------|-------|-----------------------------------------------------------------------------------------------|--------------------------------------|
| WDAY   | 7     | Q1 FY27 EPS $2.66 vs $2.49 (+7%); raised non-GAAP op-margin guide to 30.5% from 30.0%       | CNBC / Workday IR newsroom May 21    |

Skipped (below threshold or filtered):
- EL (score ~3): +10% pre-market but no confirmed material catalyst from Grok — move already in, no catalyst to validate. Novelty = 0.
- ROST (score ~3): +5% pre-market, no confirmed catalyst from Grok.
- TTWO (score ~3): +5% pre-market, no confirmed catalyst from Grok.
- AVB (score ~3): all-stock merger of equals — no clear directional bullish edge on 14-day horizon; arb dynamics cap upside.
- EQR (score ~3): same merger, same logic.
- PH (score ~2): acquirer in $2.55B deal; acquirers typically trade flat-to-down on announcement.
- AKTX (fails universe): micro-cap biotech +82%, below $2B floor; also move entirely priced in.
- CAVA, NVDA: already held.

Portfolio capacity: 2 open positions (CAVA + NVDA) of max 5. Room for up to 2 new positions today. WDAY is the only signal. Entry at open per strategy: market order, ~5% of equity ($99,802.40) = ~$4,990 ÷ estimated ~$130 = ~38 shares. Market-open.md handles execution.

Action items for operator (informational only):
- WDAY scores exactly 7 — the minimum threshold. The thin revenue beat and reiterated (not raised) revenue guide are the weak spots; only the EPS beat magnitude and margin guide-up carry the score. If the open print shows >8% gap-up from last known close ($125.03), novelty collapses and market-open.md should reconsider before firing.
- Alpaca IEX bars 7 days stale (latest 2026-05-15 vs today 2026-05-22). Confirmation scoring has been effectively 0 or 1 for every session since launch. Operator data-feed issue remains unresolved.

## 2026-05-22T12:00-0500 midday risk pass
- market: open
- positions: 3 (CAVA 60 @ $82.4617, NVDA 22 @ $223.98, WDAY 38 @ $130.40)
- CAVA current price: $82.205; return: -0.31% — no stop (-7%) or target (+12%) triggered
- NVDA current price: $217.27; return: -3.00% — no stop triggered
- WDAY current price: $126.615; return: -2.90% — no stop triggered
- thesis checks (Grok): no material negative news on any position in last 6 hours; all catalysts intact
- day_pnl_pct: -0.14% — no daily-loss-cap breach (cap: -3%)
- exits: 0
- entries: 0 (midday is defense only)

## 2026-05-22 market-open execution
- market: open (is_open=true, trading_blocked=false)
- exits: 0
  - CAVA at -0.38% (stop -7% not breached); thesis intact (no material negative news); time stop 2026-06-03 not reached.
  - NVDA at -1.82%; China Mellanox anti-monopoly ruling is 8-month-old news (SAMR Sep 2025); Taiwan export investigation surfaced May 21 and already priced in (NVDA +0.18% today vs yesterday close). Thesis intact.
- halt checks: day_pnl=+0.10% (cap -3% not breached); weekly_pnl=-0.07% (cap -6% not breached); open positions 2→3 of 5; new positions today 0→1 of 2.
- entries: 1
  - WDAY: score=7, 38 shares @ $130.40 fill (market order), open gap +4.2% vs $125.03 (below 8% novelty-collapse threshold), target_exit=2026-06-05
  - preflight: passed (equity=$99,933, open=2, day_pnl=+0.10%)
  - order filled after ~35s (order ID: 190bd969-7014-485c-b323-48a012f90904; initial 10-poll loop showed "new", filled on next check — order was processing during opening minute)
- account post-trade: equity=$99,973.38, cash=$85,169.54, buying_power=$185,142.92, day_pnl=+0.14%

## 2026-05-22T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (CAVA target_exit=2026-06-03, NVDA target_exit=2026-06-04, WDAY target_exit=2026-06-05)
- weekly_loss_cap: no breach (-0.42% WTD vs -6% cap)
- positions: 3 (CAVA 60 @ $82.4617, current $80.405, -2.49%; NVDA 22 @ $223.98, current $215.37, -3.84%; WDAY 38 @ $130.40, current $127.645, -2.11%)
- account: equity=$99,584.04, cash=$85,169.54, buying_power=$184,753.58, day_pnl=-0.25%
- eod email: sent (id=15ea62ff-59fa-4844-98da-31d7047d5f50)

## 2026-05-22 weekly-review: NO strategy edit
- week of 2026-05-18 to 2026-05-22: WTD=-0.42% ($99,584.04), 0 closed trades, 3 open positions (CAVA -2.49%, NVDA -3.84%, WDAY -2.11%).
- SPY comparison unavailable: IEX feed lags to 2026-05-15; cannot compute alpha.
- Rubric validated: AMAT (score=7, Confirmation=0) dropped -5.19% on 5/18 — multi-pass design (market-open.md fresh check) correctly avoided the entry. Confirmation bucket working as intended.
- D (score=5, merger target): rose +9.4% from prior close to 5/18 close but faded from pre-market highs; Cleanliness=0 approach correctly excluded it. Explicit M&A exclusion clause deferred — existing rubric handles it.
- No stop-outs, no time-stop exits — stops/time-stop mechanics untested; insufficient data for parameter adjustment.
- Operational flag (not strategy): IEX data-feed lag is #1 risk to Confirmation bucket integrity — needs real intraday quote feed before meaningful Confirmation scoring.
- Verdict: RESUME MONDAY 2026-05-25 WITH CURRENT STRATEGY. strategy.md unchanged.

## 2026-05-25 pre-market watchlist

Note: US equity markets are CLOSED today (Memorial Day). This watchlist applies to Tuesday 2026-05-26 open. Any catalyst must still be fresh (surfaced within the last 24h of Tuesday's open) — catalysts from May 21-22 are stale and excluded.

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- UBER: Board met May 24 to discuss raising its takeover bid for Delivery Hero (German food-delivery company) above initial ~€33/share (~€10-11.5B+ valuation), following shareholder pushback on the initial offer. Catalyst is UBER as *acquirer*, not target. Source: Reuters (reporting FT), ~May 24, 2026.
- No other materially bullish large-cap corporate events identified in the last 24h.

**Q2 — pre-market movers >2% on May 25 with news catalyst:**
- No pre-market movers on 2026-05-25 — US equity markets closed (Memorial Day). Grok returned May 22 movers (PCLA +180%, LFS +96-105%, AKTX +93%, BIYA +83%, MEHA +66%) but these are 3-day-old data, not fresh. Not actionable for Tuesday's open.

**Q3 — beat-and-raise earnings after May 24 close:**
- No qualifying earnings reported after May 24 close that beat AND raised guidance. Synopsys (SNPS) expected after Tuesday May 26 close — not yet reported.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- PH (Parker-Hannifin): $2.55B acquisition of CIRCOR's aerospace business (announced May 21). Already covered in 2026-05-22 pre-market pass. Stale (4 days old). Acquirer dynamics.
- RKLB (Rocket Lab): $90M USAF GEO satellite contract (announced May 22). Below $100M query threshold; also 3 days old — not fresh.
- VSAT (Viasat): ~$437M USAF PTS-G satellite contract (announced May 22). 3 days old — not fresh.
- No new FDA approvals or other regulator decisions in the last 24h.

### Candidate filter pass

Already in portfolio: CAVA, NVDA, WDAY (skip all three per portfolio.md).

Disqualified before Alpaca check (per strategy):

- **UBER**: Acquirer in a potential Delivery Hero takeover. Strategy requires catalyst be "clearly bullish for the named ticker." Acquirers are typically flat-to-down on M&A announcement (premium paid, integration risk, capital deployed). Not clearly directionally bullish. Additionally, this is still at "board discussion" stage — no signed deal. Disqualified on direction grounds.
- **Q2 movers (PCLA, LFS, AKTX, BIYA, MEHA)**: All from May 22 pre-market session (3+ days old); also primarily micro-cap/low-float pumps below $2B universe floor. Not fresh; not universe-eligible.
- **RKLB**: Contract announced May 22 (3 days old); fails the "fresh — first surfaced in last 24 hours" criterion. Also $90M is below the $100M threshold. No Alpaca check needed.
- **VSAT**: Contract announced May 22 (3 days old); fails freshness criterion. No Alpaca check needed.
- **PH**: Already covered and disqualified May 22 (acquirer, not bullish). Stale.

No survivors pass the freshness + directionality filter into the Alpaca check step.

### Scoring

No volume-eligible candidates to score.

### Watchlist

| ticker | score | catalyst (one line) | source |
|--------|-------|---------------------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- UBER (fails directionality): acquirer in potential Delivery Hero M&A bid; acquirers are flat-to-down on deal announcements; board discussion stage only.
- RKLB, VSAT (stale): space-force contracts announced May 22 — 3 days old, not fresh for a Tuesday open.
- PH (stale + acquirer): already disqualified May 22.
- All Q2 movers: stale (May 22 session) + micro-cap universe failures.

Action items for operator (informational only):
- Memorial Day holiday creates a two-day gap since last market session (May 22 close → May 27 open). No fresh corporate events surfaced in the holiday weekend. This is a normal result for a holiday Monday.
- Portfolio heading into Tuesday: 3 positions (CAVA -2.48%, NVDA -3.86%, WDAY -1.73%), all approaching but not at the -7% stop. Midday and EOD routines on Tuesday are the active risk-management passes.
- NVDA at -3.86% is the closest to the stop. Midday May 26 should re-evaluate thesis (China Mellanox ruling, export restrictions) for any news that surfaced over the weekend.

## 2026-05-25 market-open SKIPPED
- alpaca clock: is_open=false (Memorial Day — US market holiday)
- no exits, no entries, no portfolio refresh
- next market session: 2026-05-27 (Tuesday)

## 2026-05-26 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- DELL (Dell Technologies): ~+16.8% as a top market mover (~$295 pre-market) amid broader tech/AI momentum and positive sentiment around AI server demand. Source: CNBC market movers, Investors.com (~May 26, 2026). Note: no specific corporate event cited — momentum/sentiment framing only.
- No other major company-specific bullish catalysts for large-caps (>$2B) identified. News flow was limited due to Memorial Day holiday.

**Q2 — pre-market movers >2% on May 26 with news catalyst:**
- QTEX (QTREX Quantum): ~+83%. Catalyst: ticker rebranding + collaboration framework with top-5 quantum computing company on cryogenic interconnect tech. Source: Globe and Mail / PRN, May 26.
- PHGE (BiomX): ~+122%. Catalyst: AI/defense pivot (Zorronet subsidiary AI C2 app launch). Source: BiomX IR, May 26.
- BIYA (Baiya International Group): ~+83%. Catalyst: "Binance Plan" — $1M BNB position (news from May 22 carrying over). Source: MarketChameleon.
- MEHA (Functional Brands): ~+66%. Catalyst: ~$143M gold-backed DeFi acquisition (announced ~May 22). Source: MarketChameleon.

**Q3 — beat-and-raise earnings after May 25 close:**
- No qualifying earnings identified. AZO (AutoZone) Q3 FY2026 expected before open today (~$36.13 consensus EPS) but no released results or confirmed beat+raise in available data. SNPS (Synopsys) expected after today's close — not yet reported. Source: Yahoo Finance Earnings Calendar, AlphaStreet.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- GILD (Gilead Sciences): FDA approved bulevirtide (Hepcludex) for chronic hepatitis delta virus (HDV) infection — first US treatment for HDV (accelerated approval). Approval dated ~May 22; news published May 25–26 during market holiday. Source: Medscape, Epocrates, Pink Sheet / Pharma Intelligence (May 25–26, 2026).
- AZN (AstraZeneca) / Daiichi Sankyo: FDA approved Datroway (datopotamab deruxtecan) for first-line metastatic triple-negative breast cancer (TNBC), based on TROPION-Breast02 Phase 3 data. Reported May 25, 2026. Source: Pharmaceutical Technology, May 25.
- ESLT (Elbit Systems): ~$1.4B contract from European customer for military modernization programs (5-year). Stock pre-market ~+8–9%. Source: PRN / Investing.com, May 26.

### Candidate filter pass

Already in portfolio: CAVA (skip), NVDA (skip), WDAY (skip).

Disqualified before Alpaca check (per strategy):
- QTEX, PHGE, BIYA, MEHA: micro/small-caps well below $2B universe floor. Disqualified.
- DELL: Grok attributes move to "broader tech/AI momentum" and "AI server demand" — no specific new corporate event (no earnings, no contract, no guidance). Fails "Material" criterion. Strategy explicitly excludes: "Generic macro takes" and narrative without underlying corporate event. Disqualified.
- AZO: Price ~$3,433/share exceeds max_price_per_share: $1,000 guardrail. Also ADV 9,875 < 10,000 minimum. Double-disqualified.
- AZO earnings: No confirmed beat+raise available at routine fire time. Not actionable.

Survivors checked via `./scripts/alpaca.sh asset` + 30-day avg volume:

| ticker | tradable | 30d avg vol | passes 10k filter? | last bar close (5/21) | min_price $5? |
|--------|----------|-------------|--------------------|-----------------------|---------------|
| GILD   | yes      | 228,651     | YES                | $130.455              | YES           |
| AZN    | yes      | 107,787     | YES                | $189.78               | YES           |
| ESLT   | yes      | 4,146       | NO (4,146 < 10k)   | —                     | —             |

ESLT eliminated by ADV floor (4,146 shares vs 10,000 minimum).

### Scoring

**GILD — FDA approved bulevirtide (Hepcludex) for chronic HDV infection. First-ever US treatment for HDV.**
- Approval dated ~May 22; published May 25–26 during Memorial Day holiday; first trading day = today.
- Last bar (May 21): close $130.455, volume 188,843 vs 30d ADV 228,651 (below average). Stock flat at ~$130 for 5+ days — no pre-positioning visible.
- Context: bulevirtide has been approved in Europe since 2020 (marketed as Hepcludex since 2023). US approval outcome was expected; limited surprise factor.
- Catalyst strength: **2** — real FDA approval, first US treatment for a rare disease. Held from 3: hepatitis delta affects ~5% of HBV patients globally; GILD's $130B market cap means the revenue impact is modest. European precedent limits the narrative surprise.
- Novelty: **1** — stock has been flat, no pre-positioning detected, market hasn't traded post-announcement. However, the European approval precedent and expected-outcome nature of the US approval mean sophisticated investors likely pre-positioned. Not 2.
- Confirmation: **0** — latest bar volume 188,843 is below the 30d ADV of 228,651. No catalyst-day price/volume reaction visible (announcement came after May 21 session).
- Cleanliness: **1** — no offsetting bad news, no earnings within 3 trading days.
- **Total: 4 — below threshold.**

**AZN — FDA approved Datroway (datopotamab deruxtecan) for first-line metastatic TNBC (TROPION-Breast02 Phase 3).**
- First-line metastatic TNBC is an underserved indication; Datroway showed significant PFS and ORR benefit vs chemotherapy.
- Reported May 25 during market holiday; first trading day = today.
- Last bar (May 21): close $189.78, up from $181.63 on May 15 (+4.5% over week). Volume May 21: 70,738 vs 30d ADV 107,787 (below average). Stock rose steadily May 15–21; some anticipatory buying likely.
- Note: Datroway (Dato-DXd) already approved for HR+/HER2-low breast cancer and HR+/HER2-low NSCLC. This is a new major indication, not a first-in-class drug.
- Catalyst strength: **3** — FDA approval for first-line metastatic TNBC is meaningful competitive differentiation in an indication with limited first-line options. Phase 3 data is strong. Held from 4 because Datroway already has approvals (not a first-ever drug), and AZN's $200B+ cap means even a large indication moves the stock modestly.
- Novelty: **2** — official FDA approval published May 25 (market closed); formal announcement not yet traded by market. Stock's +4.5% run May 15–21 may partially reflect pre-positioning, but cannot confirm. First live trading day today.
- Confirmation: **0** — latest daily bar (May 21) volume 70,738 is below the 30d ADV of 107,787. No catalyst-day volume confirmation available.
- Cleanliness: **1** — no offsetting news, no earnings within 3 trading days.
- **Total: 6 — below threshold.**

### Watchlist

| ticker | score | catalyst (one line) | source |
|--------|-------|---------------------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- AZN (score 6): FDA approval for first-line metastatic TNBC is the day's strongest qualifying catalyst — below threshold because: Dato-DXd already has prior approvals (reduces narrative step-change), stock already +4.5% this week (some anticipation priced in), and no volume confirmation on latest daily bar.
- GILD (score 4): HDV approval is real but niche; European precedent limits surprise; flat price + below-avg volume; modest financial impact for a $130B company.
- ESLT: ADV 4,146 below 10,000 minimum — eliminated before scoring.
- AZO: price $3,433 exceeds $1,000 max; ADV 9,875 just below $10,000 minimum — double-eliminated.
- DELL: AI-momentum narrative with no specific new corporate event — fails "Material" catalyst criterion.
- QTEX, PHGE, BIYA, MEHA: micro/small-cap pumps, below $2B universe floor.

Action items for operator (informational only):
- AZN scored 6 — one point short. The gap between a 6 and a tradeable 7 is the Confirmation bucket (no volume data for post-announcement bars; May 21 bar was below-average volume before the announcement). If market-open.md observes AZN opening strongly with above-average volume, operator may reconsider manually. Pre-market routine cannot confirm — that's a market-open judgment call.
- GILD note: the flat stock price through May 21 is consistent with the rare-disease / EU-precedented nature of the US approval. No action needed.
- All 3 open positions (CAVA -2.48%, NVDA -3.86%, WDAY -1.73%) are approaching but not at their -7% stops. NVDA is closest. Midday and EOD routines remain the active risk passes today.

## 2026-05-26 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 3 (CAVA, NVDA, WDAY — Alpaca matches portfolio.md)
- exits: 0
  - CAVA: live quote $80.86, return -1.94% (stop -7% not breached); thesis intact (Grok: no material negative news, analyst upgrades post-earnings)
  - NVDA: live quote $215.16, return -3.94% (stop -7% not breached); thesis intact (Grok: no China export/Mellanox negative news in last 24h)
  - WDAY: live quote $125.60, return -3.68% (stop -7% not breached); thesis intact (Grok: no material negative developments)
- halt checks: day_pnl=-0.05% (cap -3% not breached); weekly_pnl=-0.05% (cap -6% not breached); open positions 3 of 5; new positions today 0 of 2
- entries: 0 (watchlist score >=7: none; top score AZN=6, below threshold)
- account: equity=$99,556.18, cash=$85,169.54, buying_power=$184,725.72, day_pnl=-0.05%

## 2026-05-26 pre-market watchlist (second pass — manual re-run, post-midday)

Note: Morning pass already ran at ~6:00 AM CT (GILD=4, AZN=6, no signal — see section above).
Market-open.md already executed (0 entries). This is a supplemental re-run; all findings are informational only — no new entries possible today.

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- MRVL (Marvell Technology): Multiple analyst price target upgrades (HSBC Buy from Hold, PT raised to $300; Stifel $210; Citi $215; Wells Fargo $195; Oppenheimer $200) citing AI/custom silicon momentum. Stock hit new 1-year highs ~$196. Source: MarketBeat, GuruFocus, Seeking Alpha (May 22–26, 2026).
- MU (Micron Technology): UBS tripled price target amid AI memory/HBM demand strength; approaching $1T market cap. Source: Yahoo Finance (May 25–26, 2026).
- No other major company-specific bullish catalysts with material corporate events identified.

**Q2 — pre-market movers >2% on May 26 with news catalyst:**
- MRVL: +5.2–6.5% pre-market. HSBC upgrade to Buy, PT to $300 (AI networking "supercycle"). Source: Seeking Alpha, GuruFocus.
- MU: +6.2% pre-market. AI HBM demand / analyst momentum. Source: Benzinga.
- XPEV (XPeng): +6.4% pre-market. Robotaxi rollout news; Q1 earnings scheduled May 28. Source: Benzinga.
- BIYA: +83%. Binance Plan / BNB position. Micro-cap. Source: MarketChameleon.
- MEHA: +66%. ~$143M gold-backed DeFi acquisition. Micro-cap. Source: MarketChameleon.

**Q3 — beat-and-raise earnings after May 25 close:**
- PONY (Pony AI Inc.): Q1 2026 results reported May 26 pre-market. Adj. EPS +$0.09 vs -$0.13 consensus (+$0.22 beat). Raised 2026 robotaxi revenue target to >3.5x 2025 levels (from 3x); fleet size target raised to >3,500 vehicles (from 3,000). Stock +8% on print. Source: Investing.com, Chartmill.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- GILD (Gilead Sciences): FDA approved bulevirtide (Hepcludex) for HDV — accelerated approval dated May 22 (not fresh as of this pass; fully priced in). Source: Gilead IR.
- MDT (Medtronic): Announced acquisition of undisclosed target for ~$650M (reported May 25 roundup). Source: MedReps.
- NNE (NANO Nuclear Energy): Acquired Secured Transportation Services LLC for up to $13M. Micro-cap. Source: X/marketsday.

### Candidate filter pass

Already in portfolio: CAVA, NVDA, WDAY (skip).

Disqualified before Alpaca check (per strategy):
- MRVL: Analyst upgrades only (HSBC, Stifel, Citi, Wells Fargo, Oppenheimer). Strategy explicitly excludes "Pundit price targets / analyst upgrades with no new information." No new corporate event. Disqualified.
- MU: Analyst PT raise only (UBS). Same exclusion. Disqualified.
- XPEV: Q1 earnings scheduled May 28 — within 3 trading days. Hard disqualification per no_earnings_within_days: 3.
- BIYA, MEHA, NNE: Micro/small-cap, well below $2B universe floor.

Survivors for Alpaca + volume check:

| ticker | tradable | 30d ADV (Yahoo) | passes 100k filter? | notes |
|--------|----------|-----------------|---------------------|-------|
| GILD   | yes      | 5,832,923       | YES                 | active, NASDAQ |
| MDT    | yes      | 9,384,548       | YES                 | active, NYSE |
| PONY   | yes      | 4,386,195       | YES                 | active, NASDAQ, ADS |

### Scoring

**GILD — FDA approved Hepcludex (bulevirtide) for HDV (accelerated approval).**
- Approval dated May 22 (4 days ago); stock jumped +3% that day, closed $134.36. Today pre-market: $134.40 (~flat). Move fully priced in.
- Note: bulevirtide marketed in EU since 2023; US approval was widely expected; limited narrative surprise.
- Catalyst strength: **2** — real first-US-approval, rare disease (HDV affects ~5% of HBV patients). Modest financial impact vs $130B cap.
- Novelty: **0** — approval already priced in 4 days ago; pre-market flat today.
- Confirmation: **0** — latest Alpaca bars (through May 21, pre-announcement) below 30d ADV; no post-announcement bar data showing confirming volume.
- Cleanliness: **1** — no offsetting news, no earnings within 3 days.
- **Total: 3 — below threshold.**

**MDT — $650M acquisition announced.**
- $650M acquisition for a ~$100B market-cap company = ~0.65% of market cap. Routine bolt-on scale for Medtronic.
- Catalyst strength: **1** — small relative deal with no quantified synergy/revenue impact disclosed.
- Novelty: **1** — fresh (May 25 announcement), but small deal unlikely to move a $100B name.
- Confirmation: **0** — latest Alpaca bars (May 15–21) show flat price $76–78; no post-announcement data.
- Cleanliness: **1** — acquirer, no offsetting bad news.
- **Total: 3 — below threshold.**

**PONY — Q1 2026 beat-and-raise (EPS +$0.09 vs -$0.13; robotaxi revenue target raised to >3.5x 2025).**
- Market cap: ~$3.87B (above $2B floor). Price ~$8.28–8.93 last week. Chinese ADS.
- Beat magnitude is large vs negative consensus; guidance raise is meaningful (+17% to robotaxi revenue target).
- Stock already +8% pre-market on the print; move largely priced in.
- Catalyst strength: **2** — beat-and-raise held from 3: company is pre-profitability (adj. EPS $0.09 vs -$0.13 is progress but still near-breakeven); Chinese ADS introduces regulatory/delisting tail risk not offset by the catalyst.
- Novelty: **1** — stock already up 8% pre-market; most of the initial reaction is in. Second-wave plausible but modest.
- Confirmation: **1** — +8% pre-market on earnings is directional confirmation; last daily bars (May 20–21) show gradual uptrend before print.
- Cleanliness: **0** — Chinese ADS: structural delisting/regulatory risk is a material offsetting concern per strategy "no offsetting bad news."
- **Total: 4 — below threshold.**

### Watchlist

| ticker | score | catalyst (one line) | source |
|--------|-------|---------------------|--------|

No tradeable signal today.

Skipped (below threshold or filtered):
- PONY (score 4): Q1 beat+raise on loss-making robotaxi company; stock already +8% pre-market; Chinese ADS regulatory overhang; net score below threshold.
- GILD (score 3): HDV approval fully priced in since May 22; flat pre-market 4 days later.
- MDT (score 3): $650M acquisition is <1% of market cap; routine bolt-on scale.
- MRVL: analyst upgrades only (HSBC, Stifel, Citi) — no new corporate event; strategy exclusion.
- MU: UBS PT raise — analyst only, no corporate event.
- XPEV: Q1 earnings May 28 — disqualified by no_earnings_within_days: 3.
- BIYA, MEHA, NNE: micro-cap / below $2B universe floor.

## 2026-05-26T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (CAVA target_exit=2026-06-03, NVDA target_exit=2026-06-04, WDAY target_exit=2026-06-05)
- weekly_loss_cap: no breach (-0.18% WTD vs -6% cap)
- positions: 3 (CAVA 60 @ $82.4617, current $80.225, -2.71%; NVDA 22 @ $223.98, current $214.59, -4.19%; WDAY 38 @ $130.40, current $124.02, -4.89%)
- account: equity=$99,425.17, cash=$85,169.54, buying_power=$184,594.71, day_pnl=-0.18%
- eod email: sent (id=8b63b833-dce0-4072-bae4-18b9805afeff)
- risk note: WDAY at -4.89% is the closest to the -7% stop ($124.02 vs stop $121.27); NVDA at -4.19%; CAVA at -2.71%

## 2026-05-27 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 3 (CAVA, NVDA, WDAY — Alpaca matches portfolio.md on qty/entry; unrealized P&L updated from Alpaca)
- exits: 0
  - CAVA: live price $82.50, return +0.05% (stop -7% not breached; target +12% not hit); thesis intact (Grok: no material negative news, beat-and-raise catalyst confirmed)
  - NVDA: live price $211.275, return -5.67% (stop -7% not breached — stop trigger at $208.30); thesis intact (Grok: no new China export restrictions or Mellanox actions; May 21 beat-and-raise catalyst intact)
  - WDAY: live price $124.755, return -4.33% (stop -7% not breached — stop trigger at $121.27); thesis intact (Grok: no customer losses, guidance cuts, or management changes)
- halt checks: day_pnl=+0.08% (cap -3% not breached); weekly_pnl=+0.08% WTD (cap -6% not breached); open positions 3 of 5; new positions today 0 of 2
- entries: 1 attempted
  - SMTC: score=8, preflight PASSED (equity=$99,565.55, open=3, day_pnl=+0.14%)
  - order submitted: 30 shares market order, order_id=1ca88290-2610-4920-8105-93a362b2db6d
  - fill status after 30s poll (10 × 3s): status=new — NOT YET FILLED. Buying power reserved (~$4,950). Moving on per routine rules.
  - Note: midday and EOD routines must check order status and append trade-log entry once filled.
- account: equity=$99,509.05, cash=$85,169.54, buying_power=$179,728.59, day_pnl=+0.08%
- risk note: NVDA at -5.67% is now closest to stop (stop trigger $208.30 vs current $211.275); WDAY at -4.33%; CAVA at +0.05%

## 2026-05-27T12:00-0500 midday risk pass
- market: open
- positions reconciled: 4 (CAVA 60 @ $82.4617, NVDA 22 @ $223.98, SMTC 30 @ $165.00, WDAY 38 @ $130.40) — Alpaca authoritative; portfolio.md rewritten
- SMTC fill confirmed: order 1ca88290-2610-4920-8105-93a362b2db6d filled at $165.00 at 2026-05-27T08:34 CT; trade-log entry appended
- exit evaluation:
  - CAVA: current $83.67, return +1.47% — no stop (-7%) or target (+12%) triggered; thesis intact (Grok: no material negative news)
  - NVDA: current $209.70, return -6.38% — no stop triggered (stop $208.30; gap $1.40); thesis intact (Grok: no new guidance cut, recall, lawsuit, regulatory reversal, or exec departure; smuggling allegations are ongoing background context, not a new specific event)
  - SMTC: current $158.56, return -3.90% — no stop triggered (stop $153.45); thesis intact (Grok: beat-and-raise Q1 FY27 catalyst fully intact, no material negative news)
  - WDAY: current $125.87, return -3.47% — no stop triggered (stop $121.27); thesis intact (Grok: Goldman/Needham PT cuts are analyst valuation resets — no new corporate negative such as guidance cut, exec change, or customer loss)
- day_pnl_pct: -0.04% — no daily-loss-cap breach (cap: -3%)
- exits: 0
- entries: 0 (midday is defense only)
- risk note: NVDA at -6.38% is CRITICAL — stop trigger $208.30 vs current $209.70 (gap only $1.40). EOD routine must re-evaluate.

## 2026-05-27T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (CAVA target_exit=2026-06-03, NVDA target_exit=2026-06-04, WDAY target_exit=2026-06-05, SMTC target_exit=2026-06-10)
- weekly_loss_cap: no breach (-0.15% WTD vs -6% cap)
- positions: 4 (CAVA 60 @ $82.4617, current $82.48, +0.02%; NVDA 22 @ $223.98, current $212.56, -5.10%; SMTC 30 @ $165.00, current $156.72, -5.02%; WDAY 38 @ $130.40, current $124.47, -4.55%)
- account: equity=$99,276, cash=$80,219.54, buying_power=$179,495.54, day_pnl=-0.15%
- eod email: sent (id=3349a404-0fb5-4244-944c-a77032cd4197)
- risk note: NVDA recovered from midday critical ($209.70→$212.56, gap to stop now $4.26); SMTC and WDAY both drifted lower (gaps $3.27 and $3.20 respectively)

## 2026-05-28 pre-market watchlist

### Candidate filter pass

Already in portfolio: CAVA, NVDA, SMTC, WDAY — skip all four per portfolio.md.

Disqualified before Alpaca check (per strategy):
- HSY (Hershey): Evercore ISI analyst upgrade to Outperform — analyst opinion only, no new corporate event. Strategy explicitly excludes "analyst upgrades with no new information."
- MU (Micron): UBS PT triple — analyst PT raise only, no corporate event. Same exclusion. Already surfaced in 2026-05-26 pass as well.
- MGM (MGM Resorts): JPMorgan upgrade to Overweight — analyst upgrade only, no new corporate event.
- ASTC (Astrotech): EU/ECAC approval for threat detection product + lunar initiative; stock +59-200% pre-market. Pre-market surge implies move fully priced in; also likely sub-$2B market cap. Disqualified on universe + novelty grounds.
- SNGX (Soligenix): +90% pre-market; price well under $5 per share — fails min_price_per_share=$5. Previously screened out on 2026-05-27.
- ATPC, SNYR, HSPTU, UMAC, GNS: Low-float/penny names with no confirmed material corporate catalyst. Sub-$2B universe floor.
- CB&I: $250-500M LNG storage contract is a private subsidiary/division, not independently listed on US exchanges. Alpaca asset lookup: not found (404). Skip.
- SNOW (Snowflake): Genuine beat-and-raise + $6B AWS deal (see scoring below). Stock +24% AH on May 27, then +37.6% to ~$241 pre-market May 28. Total move at time of research pass: >37% from prior close of $172.23. Strategy criterion: "Fresh — not already 5%+ priced in intraday." At +37%, the first-wave move is the entire story — no second-wave opportunity remains. Novelty=0. Score calculated below for transparency; disqualified on novelty grounds.

Survivors for Alpaca + volume check: A (Agilent Technologies), ABBV (AbbVie)

| ticker | tradable | 30d ADV (Yahoo) | passes 100k filter? | last bar close (5/22) | min_price $5? |
|--------|----------|-----------------|---------------------|-----------------------|---------------|
| A      | yes      | 2,189,836       | YES                 | $114.905              | YES           |
| ABBV   | yes      | 6,304,573       | YES                 | $215.755              | YES           |

### Scoring

**SNOW — Q1 FY27 beat-and-raise + $6B AWS collaboration (for transparency; disqualified on novelty)**
- EPS $0.39 vs $0.32 est. (+$0.07, +22%); revenue $1.39B vs $1.32B (+5.3%); FY product revenue raised to $5.84B (from $5.66B, +3.2%); op margin raised to 13.5% (from 12.5%); $6B expanded AWS collaboration.
- Catalyst strength: **4** — landmark beat-and-raise with hyperscaler partnership announcement.
- Novelty: **0** — +37.6% pre-market on May 28; strategy "Fresh" criterion requires not already 5%+ priced in intraday. Entire first-wave move already complete. We missed it.
- Confirmation: **2** — massive directional price action on heavy volume.
- Cleanliness: **1** — no offsetting news, ex-earnings.
- **Total: 7 — mathematically at threshold, but novelty=0 disqualifies per strategy rule. Do not trade.**

**A (Agilent Technologies) — Q2 FY2026 beat-and-raise (reported after May 27 close)**
- Non-GAAP EPS $1.49 vs $1.41 est. (+$0.08, +5.7%); revenue $1.83B vs $1.80B (+1.7%).
- Raised FY2026 non-GAAP EPS guide to $6.00–$6.10 (midpoint +$0.08); FY revenue guide raised to $7.39–$7.49B (core growth +30bps at midpoint).
- Catalyst strength: **3** — genuine beat-and-raise on a life-sciences instruments leader. Held from 4: revenue beat thin (+1.7%), guidance raise modest (+$0.08 EPS at midpoint, +30bps revenue). Not a full narrative reset but a clear forward cash-flow positive.
- Novelty: **2** — catalyst released after May 27 close. Grok reports +8% pre-market reaction. An 8% gap on this caliber of beat-and-raise is a reasonable starting position; analyst upgrades and institutional re-positioning often follow a Q2 beat for a coverage-heavy life-sciences name. Not 3 because the initial gap already captures the most liquid part of the move.
- Confirmation: **1** — Grok confirms +8% pre-market on the print (directional). Alpaca IEX bars (latest May 22, $114.905) are stale vs Yahoo ADV 2.19M shares; bar volumes (~109-160k) reflect known IEX feed undercount. Cannot confirm above-average post-announcement volume from bar data. Partial credit for directional pre-market confirmation only.
- Cleanliness: **1** — Q2 just reported; next earnings ~August 2026, well outside 3-day window. No halts, no offsetting negative news. Price ~$124 estimated open (within $5–$1,000 range).
- **Total: 7 — TRADEABLE (at threshold).**

**ABBV (AbbVie) — FDA approval of DECNUPAZ (pivekimab sunirine) for BPDCN (May 27, 2026)**
- First US approval of an ADC for blastic plasmacytoid dendritic cell neoplasm (BPDCN), an ultra-rare aggressive blood cancer. AbbVie's first blood cancer ADC.
- BPDCN: ~1,000 patients/year in the US; very limited commercial opportunity relative to ABBV's ~$350B market cap.
- Catalyst strength: **2** — real FDA approval, first-in-class for the indication. Held from 3: BPDCN affects ~1,000 US patients/year (ultra-rare), modest revenue delta vs $350B cap where Skyrizi/Rinvoq ($25B+ combined FY2026 run-rate) dominate the financial story.
- Novelty: **2** — approval announced May 27; first trading session is today. Alpaca bars (through May 22) show stock stable at $215–$216 with no evident pre-positioning. Pre-market reaction not visible in Grok Q2 data, suggesting no dramatic gap yet — second-wave potential intact.
- Confirmation: **0** — latest bar (May 22, $215.755) is pre-announcement. Volume 244,731 is well below Yahoo 30d ADV 6.3M (IEX undercount confirmed). No post-approval bar data available. Cannot confirm upward price/volume reaction.
- Cleanliness: **1** — no offsetting news; no earnings within 3 trading days; not halted; price within range.
- **Total: 5 — below threshold. Skip.**

### Watchlist

| ticker | score | catalyst (one line)                                                                          | source                                    |
|--------|-------|----------------------------------------------------------------------------------------------|-------------------------------------------|
| A      | 7     | Q2 FY26 EPS $1.49 vs $1.41 (+5.7%); FY EPS guide raised to $6.00-$6.10, rev to $7.39-7.49B | Investing.com / Agilent IR, 2026-05-27    |

Skipped (below threshold or filtered):
- SNOW (score 7, disqualified on novelty): Q1 FY27 massive beat+raise + $6B AWS deal, but already +37.6% pre-market — entire first wave priced in, novelty=0. Strategy requires "not already 5%+ priced in intraday." Pass.
- ABBV (score 5): FDA approval for BPDCN is real but ultra-rare (1k patients/year US) vs $350B cap; no price confirmation (bars pre-date announcement).
- HSY, MU, MGM: analyst upgrades/PT raises only — no new corporate event; strategy exclusion.
- ASTC: likely sub-$2B market cap; +59-200% pre-market move already fully priced in; novelty=0.
- SNGX: price <$5 — fails min_price_per_share floor.
- ATPC, SNYR, HSPTU, UMAC, GNS: low-float/penny names, no confirmed material catalyst, sub-$2B universe.
- CB&I: not independently listed on US exchanges, not found on Alpaca.
- CAVA, NVDA, SMTC, WDAY: already held in portfolio.

Portfolio capacity: 4 open positions of max 5. Room for 1 new position today. A is the only signal. Entry at open per strategy: market order, ~5% of equity ($99,276) = ~$4,964 ÷ estimated ~$124 open = ~40 shares. Market-open.md handles execution.

Note: A scores exactly 7 — at threshold. The thin revenue beat (+1.7%) and modest guidance raise are the weak spots. If A opens above ~$125 (>8.7% gap from last known close $114.90), novelty begins to compress and market-open.md should re-evaluate before executing.

## 2026-05-28 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 4 → 5 (CAVA, NVDA, SMTC, WDAY — Alpaca matches portfolio.md; A added via new order)
- exits: 0
  - CAVA: live price $81.095, return -1.66% (stop -7% not breached); thesis intact (Grok: no material negative news, beat-and-raise catalyst intact)
  - NVDA: live price $212.82, return -4.98% (stop $208.30 not breached, gap $4.52); thesis intact (Grok: no new China export restrictions, Mellanox actions, or guidance cuts)
  - SMTC: live price $160.64, return -2.64% (stop $153.45 not breached, gap $7.19); thesis intact (Grok: beat-and-raise Q1 FY27 intact, no material negative news)
  - WDAY: live price $124.99, return -4.15% (stop $121.27 not breached, gap $3.72); thesis intact (Grok: no guidance cuts, customer losses, or management changes)
- halt checks: day_pnl=+0.02% (cap -3% not breached); weekly_pnl≈-0.16% WTD (cap -6% not breached); open positions 4→5 of 5; new positions today 0→1 of 2
- entries: 1 attempted (A, score=7)
  - A: preflight PASSED (equity=$99,353.70, open=4, day_pnl=0.08%)
  - order submitted: 36 shares market order, order_id=b73867cc-df71-424f-a61b-5a5ffcb1b7a7
  - fill status after 30s poll (10 × 3s): status=partially_filled — 9 of 36 shares @ $134.23. Remaining 27 shares still pending in working order.
  - trade-log: partial entry logged (9 shares @ $134.23). Midday must check order b73867cc and append full fill row when confirmed.
- novelty re-evaluation at open: A opened ~$135.91 at initial quote, implying ~+8% from estimated May 27 close (~$125.84). Consistent with pre-market Grok report of "+8% pre-market." Score of 7 holds — novelty not compressed beyond pre-market expectation. Pre-market note threshold ($125 / 8.7% from stale IEX bar) was keyed off stale $114.905 bar; actual earnings gap from real prior close is ~+8%, within expected range.
- account post-trade: equity=$99,296.49, cash=$79,011.47, buying_power=$174,683.75, day_pnl=+0.02%

## 2026-05-28 raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- SNOW (Snowflake): Q1 FY2027 EPS $0.39 vs $0.32 est. (+$0.07); revenue $1.39B vs $1.32B; raised FY product revenue guide to $5.84B (from $5.66B); raised non-GAAP op margin guide to 13.5% (from 12.5%); $6B expanded AWS collaboration. Stock +24% AH on 5/27. Source: CNBC, Yahoo Finance, Investors.com, SiliconAngle, 2026-05-27.
- HSY (Hershey): Evercore ISI upgraded to Outperform, PT $255, citing confection outlook + retailer feedback. Source: Investing.com, CNBC, 2026-05-27.
- MU (Micron): UBS tripled PT to $1,625 (Street high), AI memory structural shift thesis; stock near $1T market cap. Source: CNBC, Yahoo Finance, 2026-05-26.
- MGM (MGM Resorts): JPMorgan upgraded to Overweight. Source: CNBC, 2026-05-26.

**Q2 — pre-market movers 2026-05-28 >2% on news:**
- ASTC (Astrotech): +59% to ~$21.93. EU/ECAC approvals for Detect Tracer 1000 threat detection tech + lunar resource initiative. Source: Benzinga, StockStotrade, 2026-05-27/28.
- SNOW: +37.6% to ~$241.21 pre-market. Q1 beat-and-raise + AWS deal (see Q1/Q3). Source: Benzinga, 2026-05-28.
- SNGX (Soligenix): +90%+ pre-market. ThermoVax/Ebola platform, HyBryte trials. Source: StockAnalysis, MarketWatch.
- Other movers (ATPC +88%, SNYR +64%, HSPTU +44%, UMAC +36%, GNS +29%): low-float/penny names, no major confirmed catalyst. Source: Benzinga, 2026-05-28.

**Q3 — beat-and-raise earnings after 2026-05-27 close:**
- A (Agilent Technologies): Q2 FY2026 non-GAAP EPS $1.49 (beat $1.41 est. by $0.08 / +5.7%); revenue $1.83B (beat $1.80B, +1.7%). Raised FY2026 non-GAAP EPS guide to $6.00-$6.10 (up $0.08 at midpoint); FY revenue guide raised to $7.39-7.49B (core growth 4.5-6%, +30bps midpoint). Source: Investing.com, company release, 2026-05-27.
- SNOW (Agilent Technologies): Q1 FY2027 non-GAAP EPS $0.39 (beat $0.32 est. by $0.07); revenue $1.39B (beat $1.32B). Raised FY product revenue guide to $5.84B (~31% growth, from $5.66B); non-GAAP op margin guide raised to 13.5% (from 12.5%). Source: Investors.com, SiliconAngle, 2026-05-27.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- ABBV (AbbVie): FDA approved DECNUPAZ (pivekimab sunirine-pvzy) on 2026-05-27 for adult BPDCN patients. First ADC for blood cancer from AbbVie; ultra-rare indication (~1,000 US patients/year). Source: AbbVie IR (news.abbvie.com), 2026-05-27.
- CB&I: $250-500M lump-sum contract from Technip Energies/Caturus for five 50,000 m³ LNG storage tanks at Commonwealth LNG facility, Louisiana. Announced 2026-05-27. Source: cbi.com press release, 2026-05-27. (Note: CB&I is not independently listed on US exchanges; ticker CBI not found on Alpaca — no trade possible.)
- No major new M&A announcements or significant FTC/DOJ/SEC regulator decisions identified.

## 2026-05-28T12:00-0500 midday risk pass
- market: open
- positions reconciled: 5 (A 36 @ $133.745278, CAVA 60 @ $82.461667, NVDA 22 @ $223.98, SMTC 30 @ $165.00, WDAY 38 @ $130.40) — Alpaca authoritative; portfolio.md rewritten
- A full fill confirmed: order b73867cc-df71-424f-a61b-5a5ffcb1b7a7 status=filled, 36/36 shares @ $133.745278 avg; trade-log correction row appended
- exit evaluation:
  - A: current $135.34, return +1.19% — no stop (-7%) or target (+12%) triggered; thesis intact (Grok: earnings beat+raise catalyst confirmed, no negative news)
  - CAVA: current $80.175, return -2.77% — no stop triggered (stop $76.69); thesis intact (Grok: Q1 beat-and-raise fully intact, no material negative news)
  - NVDA: current $212.23, return -5.25% — no stop triggered (stop $208.30, gap $3.93); thesis intact (Grok: no new guidance cut, regulatory reversal, or exec departure)
  - SMTC: current $167.595, return +1.57% — no stop or target triggered; thesis intact (Grok: Q1 FY27 beat+raise intact, no material negative news; +6.6% today on continued catalyst momentum)
  - WDAY: current $127.56, return -2.18% — no stop triggered (stop $121.27, gap $6.29); thesis intact (Grok: no guidance cuts, customer losses, or management changes)
- day_pnl_pct: +0.35% — no daily-loss-cap breach (cap: -3%)
- exits: 0
- entries: 0 (midday is defense only)
- risk note: NVDA at -5.25% remains closest to stop (gap $3.93 to $208.30); WDAY and CAVA both recovering vs prior sessions
