# research-log.md
# Append-only. One block per research pass or notable event.
# Pre-market.md writes a daily watchlist block. Preflight-check.sh appends a
# rejection block whenever an order is blocked. Halt events get a marker.

## 2026-06-26 pre-market research pass

### Grok raw output — Query 1: Materially bullish large-cap news (last 24h)
**MU (Micron Technology):** Massive Q3/FY earnings beat and sharply raised next-quarter revenue
guidance (~$50B vs. ~$43B consensus), signaling sustained strong AI-driven memory demand. Stock
rose double-digits intraday. Sources: Bloomberg TV "Daybreak Europe 6/26/2026"; X posts. Timestamp:
news broke/reported June 25–26, 2026 (post-earnings reaction). No other materially bullish large-cap
catalysts prominently reported in last 24h; broader market mixed-to-negative on Fed commentary +
Apple-related pressure. SK Hynix US listing noted but not a US-listed large-cap.

### Grok raw output — Query 2: Pre-market movers >2% on news (2026-06-26)
Pre-market gainers ~6:22 AM ET (Investing.com): CRL +7.83%, RL +6.80%, ATO +5.85%, ECL +4.44%,
CTAS +4.32%, KKR +4.20%, CINF +3.92%. Micro-caps (ILLR +~92%, IVF +~55%, SDOT/TII/BDRX/SHPH 30%+)
low-float/volatility, no fundamental news. "Clear same-day news catalysts tied specifically to the
June 26 pre-market moves appear limited or absent" — moves align with momentum / prior earnings (RL's
May 21 beat) / rotation / gap-fill, NOT fresh catalysts. No major new earnings/M&A/FDA/analyst actions
linked to these surges. Sources: Investing.com, Benzinga, stockanalysis.com.

### Grok raw output — Query 3: Earnings beat AND raised guidance (after yesterday's close)
**MU (Micron):** fiscal Q3 2026. Beat: adj EPS $25.11 vs ~$20.78–$20.98 consensus (+~$4.13); revenue
$41.46B vs ~$35.8–35.9B est. Raise: Q4 revenue guide ~$50B vs consensus ~$43.58B; strong AI/HBM
outlook. NOTE: report date was June 24, 2026 (after prior close) — NOT after the June 25 close.
Source: CNBC/MarketBeat/Bloomberg. No other tickers beat AND raised after the June 25 close (June 26
calendar = Apogee, Cineverse — no matching beat+raise detail).

### Grok raw output — Query 4: FDA / contracts >$100M / M&A / regulator (last 24h)
**TECH (Bio-Techne):** M&A announced June 25, 2026 — Merck KGaA to acquire Bio-Techne for ~$11.3B
(€9.9B EV), all-cash at $73.00/share, a 36% premium. Expected close late 2026 / early 2027, subject
to approvals; ~€140M annual cost synergies by year three. Sources: insidearbitrage.com,
listingtrack.io. No FDA approvals, large contract wins (>$100M), or major regulator decisions matching
criteria in last 24h.

### Universe filter + scoring
| ticker | asset | 30d ADV (Yahoo) | last bar (Jun 22, feed lag) | verdict |
|--------|-------|-----------------|------------------------------|---------|
| MU   | active/tradable us_equity | 55,650,830 | $1,211.38 | **FAILS guardrail max_price_per_share=1000** (>$1000/sh → preflight reject). Also move already happened. |
| TECH | active/tradable us_equity | 4,639,530  | $55.62 (pre-deal) | passes universe; gaps to ~$72 deal price at open. |

- Both NOT held (portfolio = KMX only). No disallowed substrings. Both pass volume floor (100k).
- Bars feed is stale at 2026-06-22 (same IEX lag noted in prior passes) — confirmation inferred.

### Scores
- **MU = 6** (untradeable): catalyst strength 4 (enormous beat+raise, AI/HBM), novelty 1 (reported
  June 24 after close — TWO days ago, double-digit move already realized; we'd be chasing the second
  wave with most of it gone), confirmation ~1 (pre-earnings run-up strong; post-print bars unavailable),
  cleanliness 0 (price $1,211 breaches the $1,000/sh hard cap → preflight rejects; 5% sizing fragments).
  Strong news, but BOTH the price cap and the spent novelty disqualify it. SKIP.
- **TECH = 4**: catalyst strength 3 (real all-cash deal, but a TARGET — upside capped at $73 deal price),
  novelty 0 (the 36% premium is captured at the announcement gap; at the open it trades ~$72, leaving
  only ~1.4% spread to a deal closing 6+ months out, with deal-break risk), confirmation 0, cleanliness 1.
  Classic merger-arb with no momentum left for a 14-day swing. SKIP.

## 2026-06-26 pre-market watchlist

No tradeable signal today.

Skipped (below threshold):
- MU (score 6): strongest catalyst of the day but untradeable — trades >$1,000/sh ($1,211), breaching
  the max_price_per_share=1000 guardrail (preflight would reject); and the earnings move already
  happened June 24 (novelty ~1, we'd be chasing).
- TECH (score 4): all-cash M&A target at $73 (36% premium). Premium is captured at the open gap (~$72);
  only ~1% spread left to a late-2026/2027 close. No momentum for our 14-day window.
- CRL/RL/ATO/ECL/CTAS/KKR/CINF (pre-market gainers): Grok found NO fresh same-day catalyst —
  momentum/rotation/gap-fill. Fail the freshness test in strategy.md.

## 2026-06-24 market-open execution pass
- market: open (is_open=true) | trading_blocked: false
- positions reconciled (Alpaca): 1 (KMX 890 sh @ $48.431618) — matches portfolio.md
- exits checked: 1 position (KMX)
  - KMX: cur=$52.64  ret=+8.69%  stop=-25%($36.32)→HOLD  target=+60%($77.49)→HOLD
  - time-stop: 2026-06-25 (today=2026-06-24) → HOLD (fires tomorrow; enforced by EOD)
  - thesis check: CLEAR — Grok found no material negative KMX news in last 24h; Q1 FY27 EPS +38% beat thesis intact; UBS PT→$57, Morgan Stanley PT→$44 post-earnings
- exits: 0
- halt checks: day_pnl=+1.40% vs cap=-40% → CLEAR | WTD≈flat / 0 closed trades this week vs cap=-80% → CLEAR | open positions 1/2 → CLEAR (1 slot free)
- entries: 0 — NO pre-market watchlist block dated 2026-06-24 exists. Last research pass was 2026-06-19 (0 candidates, top score 6 MRNA). No pre-market/market-open commits for 06-22, 06-23, or 06-24; only a 06-22 midday ran. Market-open executes the watchlist pre-market produces — with none, no entries.
- no orders placed
- account: equity=$89,894.55, cash=$42,457.55, buying_power=$302,653.80, day_pnl=+1.40%
- ANOMALY (flag for weekly-review): the pre-market research routine appears not to have run since 2026-06-19. With 1 open slot free and KMX timing out tomorrow, the book is under-deployed because no watchlist is being generated. Operator: confirm pre-market cron is firing.

## 2026-06-19 weekly-review: NO strategy edit
- week of 2026-06-16 to 2026-06-19 (short week — Juneteenth Friday; 3 trading days: Jun 16/17/18)
- WTD P&L: -$1,354 (-1.48%) [Monday open $91,462 → Thursday EOD $90,108]
- vs SPY: UNAVAILABLE (Alpaca IEX bars stalled at 2026-06-12; same data-feed lag as prior reviews)
- 1 trade closed: TSEM260626C00280000 call, stop -58.82% (Jun 15–17, 2 trading days)
- win rate: 0/1 = 0% | avg loser: -58.82% | 0 time-stops | 0 preflight rejections
- stop-out hindsight: TSEM option stopped at $9.80; current bid $18.52 (-22.3% implied vs entry $23.80).
  Underlying TSEM: $286.53 (thesis was right, option path was not). Stop fired correctly per rules.
  0 stop-outs "green" at day 14 — below the ≥2 threshold for a stop-rule adjustment.
- missed candidates: ROKU (score 7, M&A arb, -2.0% since eval — correct reject), INTC (score 6,
  +7.5% from Jun 12 but macro/sector driver — correct score), LZB (score 6, +2.9% — no miss).
- observation logged: supply-contract catalysts (TSEM) showed gradual/volatile price discovery
  less suited to short-dated calls than earnings beats. N=1 — revisit after 2+ similar cases before
  considering a strategy.md edit on catalyst-type → instrument choice.
- missing June 12 review: Grok API offline that week; SMTC time-stop Jun 10 (-3.23%),
  A time-stop Jun 11 (-2.65%) — no rubric signals, no strategy change warranted.
- strategy edit: NONE (1-trade sample, option loss within MAX DEGEN parameters, thesis was correct)
- VERDICT: RESUME MONDAY 2026-06-23 WITH CURRENT STRATEGY.
  Priority: KMX target exit 2026-06-25 (+10.55% unrealized); deploy remaining 1 slot on ≥7 signal.
- weekly review email: 46578e54-e8bc-4b9f-883f-b2d71271993b

## 2026-06-18 EOD risk pass
- market: open
- time-stops evaluated: KMX (target_exit=2026-06-25) — not reached today
- time-stops fired: 0
- expiry guard: no options in portfolio
- safety net checks (pre-close prices):
  - KMX: cur=$53.54  ret=+10.55%  stop=$36.32  target=$77.49  time-stop=2026-06-25 → HOLD
  - thesis check: CLEAR — Grok found no material negative news on KMX in last 6h; Q1 EPS +38% beat thesis unchanged
- weekly_loss_cap: WTD=-1.48% (Monday open $91,462 → $90,108) vs cap=-80% → CLEAR
- daily_loss_cap: day_pnl=+5.31% vs cap=-40% → CLEAR
- exits: 0
- trade-log correction: KMX BUY (order f78c9693, 890 shares @ $48.431618, 2026-06-18 09:31) appended to trade-log.md — was omitted by midday routine
- account: equity=$90,108.16, cash=$42,457.56, buying_power=$303,251.92, day_pnl=+5.31%
- EOD email sent (id=5f56880f-5d12-46fa-9331-0a708365885e)

---

## 2026-06-16 pre-market research pass

### Grok raw output — Query 1: Materially bullish large-cap news (last 24h)
> US-Iran peace framework/deal (announced ~June 15, 2026) drove broad market gains, with notable rallies in tech/chip stocks due to reduced geopolitical risk, lower oil prices, and improved sentiment. [investors.com, CNBC]
> - NVDA (Nvidia): Rallied on the de-escalation (part of chip/AI stock surge). [investors.com]
> - AMD (Advanced Micro Devices) and MU (Micron Technology): Led chip stock gains on U.S.-Iran deal. [investors.com]
> SpaceX (SPCX) post-IPO momentum: Continued strong gains (~10% pre-market after prior spikes; market cap >$2T). [CNBC, cnbc.com/2026/06/12/spacex-ipo-spcx-live-updates]
> No other major company-specific catalysts for >$10B market-cap US equities identified in the strict last 24 hours. Market reaction is macro/geopolitical-driven.

### Grok raw output — Query 2: Pre-market movers >2% on news catalyst (June 16)
> SpaceX-related leveraged ETFs: LOFF (Direxion Daily SpaceX Bull 2X ETF) ~+20%, SPAX (T-REX 2X Long SpaceX Daily Target ETF) ~+20%, SPCF (ProShares Ultra SpaceX) ~+20%. Moved on SpaceX IPO/debut developments and positive sentiment. [benzinga.com/premarket]
> Other large % gainers: SLBT (~+395%), GDHG (~+178%), TDIC (~+71%), IVDA (~+53%), IMCC (~+51%), BEEM (~+40%), CRVO (~+26%), CRE (~+21%), WNW. Mostly small/micro-caps; catalysts not detailed. [benzinga.com/premarket, stockanalysis.com]
> Broader positive sentiment from US-Iran-related deal and SpaceX news lifting indices.

### Grok raw output — Query 3: After-close earnings beats with raised guidance
> No prominent earnings reports released after the June 15, 2026 market close identified as both beating consensus AND raising guidance. Earnings calendars show Kroger (KR), Progressive (PGR), Accenture (ACN), Jabil (JBL) reporting around June 15–18, but no beat+raise confirmed for post-June-15 timing. [zacks.com/earnings, facebook.com/EarningsWhispers]

### Grok raw output — Query 4: FDA approvals, contracts >$100M, M&A, regulator decisions (last 24h)
> FDA: Accelerated approval granted to Tzield (teplizumab-mzwv) for new indication — delay insulin decline in children ages 8–17 with Stage 3 T1D. Affects Sanofi (SNY), which acquired original developer Provention Bio. [fda.gov press announcement, June 15 2026]
> M&A: Fox Corporation (FOXA/FOX) agreed to acquire Roku, Inc. (ROKU) in a cash-and-stock deal valued at ~$22B enterprise value ($160/share). [newsroom.roku.com, prnewswire.com, June 15 2026]
> M&A: Nuvei agreed to acquire Payoneer Global Inc. (PAYO) for $2.75B ($7.40/share in cash), expected close mid-2027. [nuvei.com, prnewswire.com, June 15 2026]
> No large contract wins (>$100M) or other significant regulator decisions identified.

---

### Candidate universe filter pass

| ticker | ADV (Yahoo 30d) | last price | active/tradable | filter result |
|--------|-----------------|------------|-----------------|---------------|
| NVDA   | —               | —          | yes             | SKIP — macro/geopolitical catalyst only (US-Iran deal); not company-specific |
| AMD    | —               | —          | yes             | SKIP — same macro driver |
| MU     | —               | —          | yes             | SKIP — macro + pre-earnings analyst hype; no fresh corporate event |
| SPCX   | 381,508,987     | $193.76    | yes             | PASS filters (us_equity, ADV >> 100k); no fresh 24h catalyst → score below |
| LOFF   | —               | —          | n/a             | SKIP — "Direxion" in name → disallowed_name_substrings |
| SPAX   | —               | —          | n/a             | SKIP — "2X" in name → disallowed_name_substrings |
| SPCF   | —               | —          | n/a             | SKIP — "ProShares Ultra" in name → disallowed_name_substrings |
| SLBT/GDHG/TDIC/IVDA/IMCC/BEEM/CRVO/CRE/WNW | — | — | — | SKIP — small/micro-caps; likely < $1B market cap, no clear institutional catalyst |
| ROKU   | 3,479,986       | $140.86    | yes             | PASS filters (us_equity, ADV >> 100k); M&A catalyst → score below |
| FOXA   | —               | —          | yes             | SKIP — acquirer in deal; typically depresses acquirer; not bullish for us |
| PAYO   | 9,378,533       | $7.04      | yes             | PASS filters; M&A target → score below |
| SNY    | 2,576,444       | $43.78     | yes             | PASS filters (us_equity, ADS); FDA catalyst → score below |

---

### Scoring — survivors

**ROKU — Roku Inc.**
- Pre-announcement close (June 11): $119.70 | Deal price: $160.00 (Fox cash-and-stock) | Last trade: $140.86 (+17.7% on announcement day)
- Catalyst strength (0–4): **3** — material M&A at a significant premium ($160 vs $119.70 = +33.7% to undisturbed). Clearly directional for ROKU.
- Novelty (0–3): **1** — stock already moved +17.7% on announcement day; remaining gap to deal price ($140.86 → $160) is only +13.6% of deal-risk-discount (merger arb spread), not open-ended price discovery.
- Confirmation (0–2): **2** — price up significantly on above-average volume on announcement day.
- Cleanliness (0–1): **1** — no offsetting news; deal terms appear final.
- **Total: 7** → NUMERICAL PASS, but STRUCTURALLY INELIGIBLE. This is a merger arb situation: price is capped at $160 deal value. Max gain from $140.86 is +13.6%, far below our +60% profit target for shares and +150% for options. Our thesis (catalyst mispricing → price discovery over 7–14 days) does not apply to M&A targets whose price is anchored to the deal value. Skip.

**PAYO — Payoneer Global Inc.**
- Pre-announcement close (June 11): $6.75 | Deal price: $7.40 (Nuvei cash, mid-2027 close) | Last trade: $7.04 (+4.3%)
- Catalyst strength (0–4): **2** — $2.75B acquisition, directional event; but delayed close (mid-2027 expected) significantly reduces immediacy.
- Novelty (0–3): **1** — stock already moved +4.3% on announcement; remaining gap to $7.40 is only +5.1%; deal close mid-2027 means the arb spread likely persists for 12+ months.
- Confirmation (0–2): **2** — price up on volume.
- Cleanliness (0–1): **1** — no offsetting news.
- **Total: 6** → Below threshold. Also structurally wrong (merger arb, tiny max gain, 12-month deal horizon).

**SNY — Sanofi ADS**
- Catalyst strength (0–4): **2** — FDA accelerated approval for Tzield (new pediatric T1D indication) is a real regulatory event. However, Sanofi's market cap is ~$100B+; a single new indication for a niche pediatric disease is not a material cash-flow driver at this scale.
- Novelty (0–3): **2** — event is fresh (June 15); stock hasn't reacted much yet.
- Confirmation (0–2): **0** — stock traded DOWN slightly ($44.10 pre-announcement → $43.78 last trade); no upward price or volume confirmation. Market signals the catalyst is immaterial.
- Cleanliness (0–1): **1** — no offsetting news.
- **Total: 5** → Below threshold. Negative confirmation (stock didn't respond) overrides the event freshness.

**SPCX — SpaceX**
- Catalyst strength (0–4): **1** — no specific new corporate catalyst in the last 24 hours. Post-IPO momentum (IPO was June 12) is continuation, not a discrete event. "Stock going up" is not a catalyst.
- Novelty (0–3): **1** — stock already up ~28% from IPO open ($151.15 → $193.76) in 3 days. Extent of fair-value discovery unknown given no public operating history, but no identifiable 24h catalyst means this is momentum-chasing rather than thesis-driven.
- Confirmation (0–2): **2** — price up on very high volume.
- Cleanliness (0–1): **0** — brand-new public company; no earnings history; extreme fair-value uncertainty; high beta/volatility likely. No earnings risk per se but high uncertainty fails our cleanliness check.
- **Total: 4** → Below threshold. No specific fresh catalyst; post-IPO momentum does not meet our "material, fresh news catalyst" standard.

---

## 2026-06-16 pre-market watchlist

No tradeable signal today.

Skipped (below threshold or structurally ineligible):
- ROKU (score 7, structurally ineligible): Merger arb capped at $160 deal price; +13.6% max gain from $140.86 cannot reach our +60% profit target. M&A arb is a different strategy.
- PAYO (score 6): Merger arb, 5.1% max gain to $7.40 deal price, deal closes mid-2027. Not our thesis.
- SNY (score 5): FDA pediatric T1D indication immaterial for a $100B+ pharma; stock traded DOWN on announcement — no confirmation.
- SPCX (score 4): No fresh 24h catalyst; post-IPO momentum only; new public company with extreme fair-value uncertainty (cleanliness=0).
- NVDA/AMD/MU: Macro/geopolitical (US-Iran deal) — generic market move, not company-specific catalysts.
- LOFF/SPAX/SPCF: Disallowed instruments (leveraged ETF name substrings: Direxion, 2X, ProShares Ultra).
- SLBT/GDHG/TDIC/IVDA/IMCC/BEEM/CRVO/CRE/WNW: Small/micro-cap movers; fail $1B market cap filter.

Existing position: TSEM260626C00280000 (Jun 26 $280 call, 10 contracts, entry $23.80, time-stop 2026-06-22) — unchanged; monitored by midday/EOD routines.

---

## 2026-06-16 market-open execution pass
- market: open | trading_blocked: false
- exits checked: 1 position (TSEM260626C00280000)
  - bid=$15.77 ret=-33.74% | stop=-60%($9.52) → HOLD | target=+150%($59.50) → HOLD
  - time-stop: 2026-06-22 (today=2026-06-16) → HOLD
  - expiry guard: expires 2026-06-26 (10+ trading days) → HOLD
  - thesis: CLEAR — Grok found no material negative news; InP/AI data center supply agreement with IQE intact
- halt checks: day_pnl=-6.81% vs cap=-40% → CLEAR | weekly closed trades=0 → CLEAR
- entries: 0 — no candidates from pre-market pass (all below score threshold or structurally ineligible)
- no orders placed

## 2026-06-15 midday risk pass
- market: open
- positions reconciled (Alpaca): 1 (TSEM260626C00280000 — matches portfolio.md)
- exits: 0
  - TSEM260626C00280000: entry=$23.80  bid=$20.14  ret=-15.38%  stop=-60%($9.52)  target=+150%($59.50)  time-stop=2026-06-22 → HOLD
  - thesis check: CLEAR — Grok found no material negative news on TSEM in last 6 hours; IQE InP deal confirmed positive
- daily_loss_cap: day_pnl=-3.92% vs cap=-40% → CLEAR
- no cancellations, no new orders

## 2026-06-15 pre-market research pass

### Grok API status
Credits restored (first successful queries since 2026-06-02; 13-day outage ended).

### Grok raw output — Query 1: Materially bullish large-cap news (last 24h)
> US-Iran ceasefire/de-escalation agreement (broad market bullish catalyst, easing oil supply/inflation concerns and geopolitical risks); ongoing positive sentiment into mid-June.
> - Broad large-cap equities (S&P 500 tech/chip stocks, cyclicals): Relief rally from interim US-Iran deal to halt fighting and reopen Strait of Hormuz, reducing energy supply risks. S&P 500 +1.75% or more on related news days; futures positive as of June 15 updates. [CNBC, Yahoo Finance]
> - SPCX (SpaceX): Record ~$75B IPO priced at $135/share; shares surged ~19-25% on debut (~June 12), pushing market cap above $2T. Continued positive sentiment. [CNBC, TechCrunch]
> No other major company-specific events for >$10B market-cap US equities in the exact last 24 hours.
> Sources: CNBC, Yahoo Finance, Reuters, Al Jazeera (crawled around June 12–15, 2026).

### Grok raw output — Query 2: Pre-market movers >2% on news catalyst (June 15)
> Semiconductor/memory stocks (main cluster — geopolitical de-escalation + AI/data center demand + upcoming earnings):
> - MU (Micron Technology): +~7.5% (to ~$1,055). AI-driven demand expectations ahead of June 24 earnings. Analyst targets raised to ~$1,250. [Yahoo Finance]
> - WDC (Western Digital): +~5.6%. Sector move.
> - STX (Seagate Technology): +~5.5%. Sector move.
> - SMCI (Super Micro Computer): +~5.5%. Sector move.
> - KLAC, DELL: +~4–5%. Sector.
> Other notable movers:
> - TSEM (Tower Semiconductor): +~4.7–5% (to ~$275). Specific company news. [Benzinga]
> - VTYX (Ventyx Biosciences): +~67% intraday. Reports/buzz around Eli Lilly acquisition interest. [YouTube]
> Notes: Many small-cap gainers (CAST +249%, VSME +70%+) lack clear public catalysts. Data reflects early pre-market ~6–7 AM ET.
> Sources: Investing.com, Benzinga premarket, Yahoo Finance.

### Grok raw output — Query 3: After-close earnings beats with raised guidance
> No prominent earnings reports released after the June 14, 2026 market close were identified as both beating estimates AND raising guidance. Earnings calendars show ~34 reports scheduled for June 15 overall with no timely post-release details on beat + raised outlook available.
> (Adobe/ADBE beat and raised guidance ~June 11–12, but does not match post-June-14 timing.)
> Sources: Yahoo Finance earnings calendar, Nasdaq, Earnings Whispers.

### Grok raw output — Query 4: FDA approvals, contracts >$100M, M&A, regulator decisions (last 24h)
> - GM: GM Defense awarded ~$143M firm-fixed-price US Army contract (W912CH-26-F-0339) for infantry squad vehicles and winch kits; cumulative program value ~$624M. Work completes June 2027. [Investing.com]
> - FDA: Final order adding bemotrizinol (BEMT) as OTC sunscreen ingredient (first new addition in 20+ years, 6% concentration). Primary beneficiary is dsm-firmenich's Parsol Shield (not US-listed). [FDA.gov]
> - SEC: Approved T. Rowe Price (TROW) actively managed crypto ETF to list on NYSE Arca; fund can hold 5–15 cryptos (BTC, ETH, SOL, XRP, DOGE, SHIB, others) plus USDC. [Bitget]
> No major M&A announcements identified in the strict last 24 hours.

### TSEM-specific Grok follow-up
> Catalyst: Multi-year InP epiwafer supply agreement between Tower Semiconductor (TSEM) and IQE plc, supporting AI-driven data center optical connectivity (200Gb/s/lane transceivers and 400Gb/lane modulators), with first-year minimum purchase commitments, ongoing volume commitments, and settlement of prior IP disputes/litigation. Announced June 15, 2026.
> Pre-market: TSEM shares +~4.7–5% (to ~$275).
> Earlier May 2026 $1.3B silicon photonics contract context; today's agreement is an additional fresh catalyst distinct from prior news.
> Sources: IQE press release (iqep.com), StockTitan, Benzinga (all dated June 15, 2026).

---

### Candidate universe filter pass

| ticker | ADV (Yahoo) | price est. | active/tradable | filter result |
|--------|-------------|------------|-----------------|---------------|
| MU     | passes      | ~$1,055    | yes             | SKIP — price > $1,000 cap |
| WDC    | 7,322,303   | ~$517      | yes             | catalog: sector/macro catalyst only |
| STX    | 3,813,620   | ~$860      | yes             | catalog: sector/macro catalyst only |
| SMCI   | 58,672,426  | ~$31       | yes             | SKIP — crashed -17% June 10 (negative event; cleanliness=0) |
| TSEM   | 2,237,516   | ~$275      | yes             | PASS all filters |
| GM     | 7,527,076   | ~$79       | yes             | catalog: catalyst too small vs company size |
| TROW   | 1,979,763   | ~$106      | yes             | catalog: mild/indirect catalyst |
| VTYX   | n/a         | n/a        | n/a             | SKIP — likely < $1B market cap |

---

### Scoring — survivors

**TSEM — Tower Semiconductor**
- Catalyst strength (0–4): **3** — material multi-year supply contract with minimum purchase commitments in the hot AI/data center optical connectivity segment; IP litigation settlement removes overhang. Not an earnings beat/raise (would be 4), but a real corporate event with forward cash-flow implications.
- Novelty (0–3): **2** — announced today June 15 (fresh). Stock up ~5% pre-market; real price discovery likely incomplete. Prior IP dispute was a headwind now removed. Bars show stock at $228–$261 range entering today vs $275 pre-market estimate, suggesting meaningful upside still to be discovered as analysts absorb the news.
- Confirmation (0–2): **1** — directionally confirmed pre-market (+5% on the announcement); full intraday volume confirmation pending open. ADV 2.2M is sufficient liquidity.
- Cleanliness (0–1): **1** — no offsetting bad news; IP settlement is additive positive; no earnings within 3 trading days (Q2 results expected late July); no halt, no disallowed instrument flags.
- **Total: 7** ✓ (meets ≥ 7 threshold)

**WDC / STX** — sector/macro catalyst (US-Iran relief, no company-specific news)
- Catalyst strength: 1 | Novelty: 0 | Confirmation: 1 | Cleanliness: 1 = **Score: 3**

**GM** — $143M contract vs ~$150B annual revenue
- Catalyst strength: 1 | Novelty: 1 | Confirmation: 0 | Cleanliness: 1 = **Score: 3**

**TROW** — SEC crypto ETF approval (indirect/mild)
- Catalyst strength: 1 | Novelty: 1 | Confirmation: 0 | Cleanliness: 1 = **Score: 3**

---

## 2026-06-15 pre-market watchlist

| ticker | score | catalyst (one line)                                                                   | source                                    |
|--------|---------|---------------------------------------------------------------------------------------|-------------------------------------------|
| TSEM   | 7     | Multi-year InP epiwafer supply agreement with IQE for AI data center optical (IP settled) | iqep.com/media/press-releases/2026/06/15 |

Skipped (below threshold):
- MU (price cap): ~$1,055 pre-market exceeds max_price_per_share=$1,000 hard cap; would have scored 6 (catalyst is geo/macro + analyst targets, not fresh company news)
- WDC (score 3): +5.6% pre-market but catalyst is macro (US-Iran de-escalation), not company-specific; no novelty
- STX (score 3): +5.5% pre-market, same macro driver as WDC
- SMCI (skip): crashed -17% June 10 on negative event; cleanliness=0 regardless of today's bounce
- GM (score 3): $143M Army contract too small relative to $150B+ revenue base; no price movement
- TROW (score 3): SEC crypto ETF approval is indirect/mild catalyst; not a mover
- VTYX: acquisition buzz only, likely sub-$1B market cap, already +67% (no novelty)

## 2026-06-15 market-open execution

- Exits: 0 (no open positions at open).
- Halt checks: day P&L 0.00% (cap -40%) clear; week P&L 0.00% (cap -80%) clear; 0/2 positions open.
- Entry: TSEM260626C00280000 (TSEM Jun 26 $280 call) — 10 contracts BUY @ $23.80 fill avg. Order bce2135c filled instantly. Premium at risk=$23,800 (23.9% of equity). Exit thresholds: +150% target ($59.50 bid) / -60% stop ($9.52 bid) / time-stop 2026-06-22.
- Post-trade equity: $92,962.49 (option marked at bid $17.20; unrealized -27.73% mark-to-market).

**1 tradeable candidate: TSEM at score 7.**

---

## 2026-06-11 pre-market research pass

Research pass FAILED: Grok API credits exhausted (day 11 consecutive since 2026-06-02). API returns `permission-denied`: "team 2f47388e has either used all available credits or reached its monthly spending limit." Market-open will see no watchlist and sit out on new positions.

Note for market-open: A's time-stop fires TODAY (target_exit=2026-06-11) — must close at open regardless of P&L.

ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability.

## 2026-06-10 EOD risk pass
- market: open
- time-stops fired: 0
  - A: target_exit=2026-06-11 → no stop today (2026-06-10 < 2026-06-11)
- expiry guard: n/a (no options in portfolio)
- safety net checks:
  - A: cur=$132.08  ret=-1.24%  stop=$117.70  target=$167.18 → HOLD (stop not triggered)
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 10 consecutive)
- weekly_loss_cap: ~flat WTD vs cap=-30% → CLEAR
- daily_loss_cap: day_pnl=-0.05% vs cap=-15% → CLEAR
- EOD email sent (id=2622e10b-8a1b-4494-bcda-8e648c72795d)
- ALERT: A time-stop fires TOMORROW (2026-06-11) — market-open routine must close at open
- ALERT: Grok API credits exhausted 10 consecutive days (since 2026-06-02)

## 2026-06-10 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 2 (A, SMTC — Alpaca matches portfolio.md on qty/entry)
- exits: 1
  - SMTC: cur=$157.62 → filled avg $159.672  ret=-3.23%  time-stop (target_exit=2026-06-10) → SOLD 30 shares (order c0074680; partially filled over ~3 min)
  - A:    cur=$134.19  ret=+0.33%  stop=$117.70  target=$167.18  time-stop=2026-06-11 → HOLD
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 10 consecutive)
- halt checks: day_pnl=+0.02% (cap -15% clear); WTD positive; open positions 1/5 → ALL CLEAR
- entries: 0 — watchlist empty (Grok API offline day 10, no candidates)
- account: equity=$99,706.44, cash=$94,875.60, buying_power=$393,028.75, day_pnl=+0.02%
- open_positions: 1/5 (A only)
- ALERT: Grok API credits exhausted 10 consecutive days (since 2026-06-02) — research & thesis-check both offline
- ALERT: A time-stop fires TOMORROW (2026-06-11) — market-open routine must close at open
- ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-10 pre-market research pass

Research pass FAILED: Grok API credits exhausted (day 10 consecutive since 2026-06-02). All 4 Grok queries returned `permission-denied`. Market-open will see no watchlist and sit out on new positions.

ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability.

## 2026-06-09 EOD risk pass
- market: open
- time-stops fired: 0
  - A:    target_exit=2026-06-11 → no stop today (2026-06-09 < 2026-06-11)
  - SMTC: target_exit=2026-06-10 → no stop today (2026-06-09 < 2026-06-10)
- expiry guard: n/a (no options in portfolio)
- safety net checks:
  - A:    cur=$135.19  ret=+1.08%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$157.51  ret=-4.54%  stop=$145.20  target=$206.25 → HOLD (stop not triggered)
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 9 consecutive)
- weekly_loss_cap: WTD=+0.05% vs cap=-30% → CLEAR
- daily_loss_cap: day_pnl=+0.05% vs cap=-15% → CLEAR
- EOD email sent (id=690e8987-aa48-4b12-b182-604f985f60df)
- ALERT: SMTC time-stop fires TOMORROW (2026-06-10) — market-open routine must close at open
- ALERT: Grok API credits exhausted 9 consecutive days (since 2026-06-02)

## 2026-06-09 midday risk pass
- market: open
- exits: 0
  - A:    cur=$135.27  ret=+1.14%  stop=$117.70  target=$167.18  time-stop=2026-06-11 → HOLD
  - SMTC: cur=$149.49  ret=-9.40%  stop=$145.20  target=$206.25  time-stop=2026-06-10 → HOLD (stop not triggered; EOD time-stop fires tomorrow)
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 9 consecutive)
- daily_loss_cap: day_pnl=-0.19% vs cap=-15% → CLEAR
- no new orders, no cancellations

## 2026-06-09 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 2 (A, SMTC — Alpaca matches portfolio.md on qty/entry)
- exits: 0
  - A:    cur=$132.62  ret=-0.84%  stop=$117.70  target=$167.18  time-stop=2026-06-11 → HOLD
  - SMTC: cur=$160.58  ret=-2.68%  stop=$145.20  target=$206.25  time-stop=2026-06-10 → HOLD
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 8 consecutive); no thesis-broken exits per hard rule
- halt checks: day_pnl=+0.13% (cap -15% clear); WTD positive; open positions 2/5 → ALL CLEAR
- entries: 0 — watchlist empty (Grok API offline day 8, no candidates)
- account: equity=$99,759.81, cash=$90,085.44, buying_power=$387,430.00, day_pnl=+0.13%
- open_positions: 2/5 (A, SMTC)
- ALERT: Grok API credits exhausted 8 consecutive days (since 2026-06-02) — research & thesis-check both offline
- ALERT: SMTC time-stop fires TOMORROW (2026-06-10) — EOD routine will close at open
- ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-09 pre-market watchlist

Research pass FAILED: xAI API credits exhausted — HTTP 200 with billing error body from api.x.ai: "Your team has either used all available credits or reached its monthly spending limit." All four Grok queries blocked. No candidates scored. No watchlist generated. Market-open will see no watchlist and sit out.

- Day 8 consecutive without Grok research capability
- Queries attempted: 1 of 4 (billing error confirmed on first attempt; further calls produce identical failure)
- Error: "Your team 2f47388e-3bd1-4c11-958e-cb40e1715c7b has either used all available credits or reached its monthly spending limit"
- ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability
- Portfolio status: 2/5 positions open (A time-stop 2026-06-11, SMTC time-stop 2026-06-10 — fires TOMORROW)
- No tradeable signal today (research infrastructure offline)

## 2026-06-08 end-of-day pass
- market: open
- time-stops evaluated: A (exit 2026-06-11), SMTC (exit 2026-06-10) — neither due today
- time-stops fired: 0
- expiry guard: no options in portfolio
- safety net exit check (pre-close prices):
  - A:    cur=$133.63  ret=-0.09%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$157.81  ret=-4.36%  stop=$145.20  target=$206.25 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (day 7 consecutive); no thesis-broken sells per hard rule
- exits: 0
- weekly-loss-cap: WTD=+0.14% (cap -30%) → CLEAR
- account: equity=$99,627.00, cash=$90,085.44, buying_power=$387,058.13, day_pnl=+0.14%
- open_positions: 2/5 (A, SMTC)
- EOD email sent (notify.sh id=920ee3ec-bbaa-4d8c-9de3-33764c05df92)
- ALERT: Grok API credits exhausted 7 consecutive days (since 2026-06-02) — research & thesis-check both offline
- ALERT: SMTC time-stop fires TOMORROW (2026-06-10) — market-open routine will close at open
- ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-08 midday risk pass
- market: open
- positions reconciled: 2 (A, SMTC — Alpaca authoritative)
- exits: 0
  - A:    cur=$133.59  ret=-0.12%  stop=$117.70  target=$167.18  time-stop=2026-06-11 → HOLD
  - SMTC: cur=$159.02  ret=-3.62%  stop=$145.20  target=$206.25  time-stop=2026-06-10 → HOLD
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 7 consecutive); no thesis-broken exits per hard rule
- halt checks: day_pnl=+0.17% (cap -15% clear); open positions 2/5
- account: equity=$99,661.68, cash=$90,085.44, buying_power=$387,155.23, day_pnl=+0.17%
- risk notes:
  - SMTC recovering +5.3% intraday from yesterday's close ($151.02→$159.02); still -3.62% vs entry; time-stop fires tomorrow (2026-06-10)
  - A drifted slightly negative -0.12% intraday; well within all thresholds; time-stop 2026-06-11
  - Grok API exhausted since 2026-06-02 (day 7) — thesis-check and research offline
  - ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-08 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 2 (A, SMTC — Alpaca matches portfolio.md on qty/entry)
- exits: 0
  - A:    cur=$135.455  ret=+1.28%  stop=$117.70  target=$167.18  time-stop=2026-06-11 → HOLD
  - SMTC: cur=$156.52   ret=-5.14%  stop=$145.20  target=$206.25  time-stop=2026-06-10 → HOLD
  - thesis check: UNAVAILABLE — Grok API credits exhausted (day 6 consecutive); no thesis-broken exits per hard rule
- halt checks: day_pnl=+0.22% (cap -15% clear); WTD=+0.23% (cap -30% clear); open positions 2/5
- entries: 0 (watchlist FAILED — Grok API credits exhausted day 6; no candidates)
- account: equity=$99,714.96, cash=$90,085.44, buying_power=$387,304.42, day_pnl=+0.22%
- risk notes:
  - SMTC at -5.14% vs stop at $145.20 (gap $11.32); time-stop 2026-06-10 (Tuesday — 2 days)
  - A at +1.28% well within range; time-stop 2026-06-11 (Wednesday)
  - Grok API exhausted since 2026-06-02 (day 6) — thesis-check offline; research offline
  - ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-08 pre-market watchlist

Research pass FAILED: xAI API credits exhausted — HTTP 200 with billing error body from api.x.ai: "Your team has either used all available credits or reached its monthly spending limit." All four Grok queries blocked. No candidates scored. No watchlist generated. Market-open will see no watchlist and sit out.

- Queries attempted: 1 of 4 (billing error confirmed on first attempt; further calls produce identical failure)
- Error: "Your team 2f47388e-3bd1-4c11-958e-cb40e1715c7b has either used all available credits or reached its monthly spending limit"
- Day 6 consecutive of Grok API failure (since 2026-06-02)
- New buys: NONE (no watchlist)
- Current positions: 2/5 (A target_exit=2026-06-11, SMTC target_exit=2026-06-10); 3 slots available
- SMTC time-stop fires 2026-06-10 (Tuesday); market-open must handle that exit
- ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability

## 2026-06-05 weekly-review: NO strategy edit
- week of 2026-06-02 to 2026-06-05: WTD=-0.60% ($99,489.92), 3 trades closed (CAVA -12.18% stop, NVDA -4.55% time-stop, WDAY +13.85% time-stop).
- SPY comparison unavailable: Alpaca IEX feed lags 3 days (most recent bar 2026-06-01).
- Score-to-return inversion noted (score=9/8 underperformed vs score=7/7) but N=5 is too small; noise more likely than rubric flaw.
- 0 stop-outs that would've been green at day 14; 1 time-stop at loss (NVDA, never in green during hold); 0 time-stops that were green 5+ days before exit and turned red.
- SNOW miss (2026-05-28, novelty=0 at +37.5% gap) was correct per rubric; its continued +18% run does not indicate rubric error.
- Dominant weekly event: Grok API exhaustion (4 consecutive days offline) — operational, not strategic. No strategy edit addresses this.
- No edit to strategy.md per stability rule (3-trade sample insufficient; current strategy untested under new 7-day max_hold_days).
- Verdict: RESUME MONDAY 2026-06-08 WITH CURRENT STRATEGY. Priority: replenish xAI credits, evaluate SMTC (-8.23%) and A (+1.20%), deploy 3 open slots.
- Weekly review email: a47cf787-bf0f-4766-a287-82e8bfd24077

## 2026-06-05 end-of-day pass
- market: open
- time-stops evaluated: A (exit 2026-06-11), SMTC (exit 2026-06-10) — neither due today
- time-stops fired: 0 (WDAY already closed at market-open 08:37 CT, logged there)
- expiry guard: no options in portfolio
- safety net exit check (5-min-to-close prices):
  - A:    cur=$135.35  ret=+1.20%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$151.42  ret=-8.23%  stop=$145.20  target=$206.25 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (day 4 consecutive); no thesis-broken sells per hard rule
- exits: 0 (WDAY closed at market-open; A and SMTC within thresholds)
- weekly-loss-cap: WTD≈-0.60% (cap -30%) → CLEAR (Monday open equity $100,092.57)
- account: equity=$99,489.92, cash=$90,085.46, buying_power=$379,150.76, day_pnl=-0.64%
- open_positions: 2/5 (A, SMTC)
- EOD email sent (notify.sh id=868ebefb-6941-4148-87ea-b40e941ef4ee)
- ALERT: Grok API credits exhausted 4 consecutive days — research & thesis-check both offline
- ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-05 midday pass
- market: open
- positions reconciled (Alpaca): 2 (A, SMTC) — WDAY fully closed (order df179d63: 38 shares @ $148.4621 filled 08:37 CT)
- exits evaluated:
  - A:    cur=$136.29  ret=+1.90%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$160.46  ret=-2.76%  stop=$145.20  target=$206.25 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (day 4); no thesis-broken sells per hard rule
- exits: 0 (WDAY already closed at market-open; A and SMTC within thresholds)
- WDAY close confirmed: order df179d63 filled (38 shares @ $148.4621, ret=+13.85%); logged to trade-log.md
- daily loss cap: day_pnl=-0.35% (cap -15%: clear; no halt)
- entries: 0 (midday is defense only)
- account: equity=$99,780.83, cash=$90,085.46, buying_power=$379,732.58, day_pnl=-0.35%
- open_positions: 2/5 (A, SMTC)
- ALERT: Grok API credits exhausted 4 consecutive days — research & thesis-check both offline
- ACTION REQUIRED: Replenish xAI credits at console.x.ai

## 2026-06-05 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 3 (A, SMTC, WDAY) — matches portfolio.md
- exits evaluated:
  - A:    cur=$138.09  ret=+3.25%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$163.14  ret=-1.13%  stop=$145.20  target=$206.25 → HOLD
  - WDAY: cur=$148.62  ret=+13.97% stop=$114.75  target=$163.00 → TIME-STOP 2026-06-05 → SELL
- thesis check: UNAVAILABLE — Grok API credits exhausted (day 4); no thesis-broken sells
- exits attempted: 1 (WDAY time-stop)
  - preflight: PASS
  - order submitted: df179d63-e118-4c50-a012-372e844d27e3 (side=sell qty=38 type=market)
  - fill status after 90s polling: "new" (UNFILLED) — order is live DAY order; midday routine must confirm fill
- halt checks: day_pnl=-0.18% (cap -15%: clear); WTD≈-0.18% (cap -30%: clear); open_positions=3/5
- entries: 0 (no watchlist — Grok exhausted since 2026-06-02; score threshold not met)
- account: equity=$99,946.48, cash=$84,443.90, buying_power=$368,780.77, day_pnl=-0.18%
- ALERT: Grok API credits exhausted 4 consecutive days — research & thesis-check both offline
- NOTE: WDAY sell order df179d63 live but unfilled at market-open; midday/EOD must confirm and log fill to trade-log.md

## 2026-06-05 pre-market pass
Research pass FAILED: Grok API credits exhausted (day 4, team 2f47388e). Attempted queries 1 and 2 — both returned HTTP 200 with billing error body. No candidates scored. No watchlist generated.

- Queries attempted: 2 of 4 (all confirmed failing at credits level; further attempts skipped)
- Error: "Your team has either used all available credits or reached its monthly spending limit"
- ALERT: Grok credits exhausted 4 consecutive days (since 2026-06-02) — research and thesis-check both offline
- WDAY time-stop fires TODAY (2026-06-05) — market-open will close at open regardless (no research needed for exits)
- New buys: NONE (no watchlist)
- Positions: 3/5 (A, SMTC, WDAY→closing today; 2 slots available after WDAY exit)
- ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability

## 2026-06-04 end-of-day pass
- market: open
- time-stops: 0 (A=2026-06-11, SMTC=2026-06-10, WDAY=2026-06-05 — none reached today)
- expiry guard: no options in portfolio
- safety net exit check at close:
  - A:    cur=$138.005  ret=+3.19%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$169.840  ret=+2.93%  stop=$145.20  target=$206.25 → HOLD
  - WDAY: cur=$148.695  ret=+14.03% stop=$114.75  target=$163.00 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (day 3)
- exits: 0 (NVDA already closed; no new exits at EOD)
- weekly-loss-cap: WTD≈+0.05% (cap -30%) → CLEAR
- account: equity=$100,141.17, cash=$84,443.92, buying_power=$369,170.18, day_pnl=+0.23%
- EOD email sent (notify.sh id=4f49d72c-9e9d-43c7-9a8a-343d631b4fa8)
- ALERT: Grok API credits exhausted 3 consecutive days — research & thesis-check both offline
- ALERT: WDAY time-stop fires TOMORROW (2026-06-05) — market-open will close at open

## 2026-06-04 midday pass
- market: open
- positions reconciled (Alpaca): 3 (A, SMTC, WDAY) — NVDA fully closed (order ada63afb: 22 shares total, avg $213.80)
- exits evaluated:
  - A:    cur=$139.13  ret=+4.02%  stop=$117.70  target=$167.18 → HOLD
  - SMTC: cur=$164.93  ret=-0.04%  stop=$145.20  target=$206.25 → HOLD
  - WDAY: cur=$149.52  ret=+14.66% stop=$114.75  target=$163.00 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (day 3); no thesis-broken sells per hard rule
- exits: 0 (NVDA already closed prior to this pass — final 7 shares filled @ $214.57 at 13:36 UTC; logged in trade-log.md)
- daily loss cap: day_pnl=+0.19% (cap -15%: clear; no halt)
- entries: 0 (midday is defense only)
- account: equity=$100,084.73, cash=$84,443.92, buying_power=$369,057.30, day_pnl=+0.19%

## 2026-06-04 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 4 (A, NVDA, SMTC, WDAY) — matches portfolio.md
- exits evaluated:
  - A:    cur=$139.23  ret=+4.10%  stop=$117.70  target=$167.18 → HOLD
  - NVDA: cur=$213.36  ret=-4.74%  stop=$197.10  target=$279.98 → TIME-STOP (2026-06-04) → SELL
  - SMTC: cur=$155.245 ret=-5.91%  stop=$145.20  target=$206.25 → HOLD
  - WDAY: cur=$151.87  ret=+16.47% stop=$114.75  target=$163.00 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (HTTP 403; no thesis-broken sells)
- exits: 1 (NVDA time-stop — sell order ada63afb submitted; PARTIAL FILL 15/22 shares @ $213.44; 7 shares remaining, order still live as of 08:32)
- halt checks: day_pnl=-0.10% (cap -15%: clear); weekly_pnl≈-0.6% (cap -30%: clear); open_positions=4/5
- entries: 0 (watchlist empty — Grok exhausted since 2026-06-02)
- account: equity=$99,797.69, cash=$82,941.90, buying_power=$365,479.18, day_pnl=-0.10%
- NOTE: NVDA sell order (ada63afb) partially filled; 7 shares still open; order will complete intraday
- NOTE: WDAY time-stop fires TOMORROW (2026-06-05) — market-open routine will close

## 2026-06-04 pre-market watchlist

Research pass FAILED: xAI API credits exhausted — HTTP 403 from api.x.ai with message "Your team has either used all available credits or reached its monthly spending limit." All four Grok queries blocked. No watchlist generated. Market-open will see no watchlist and sit out.

This is the third consecutive day of Grok API failure (2026-06-02, 2026-06-03, 2026-06-04). Operator must replenish xAI credits to restore research capability.

Note: NVDA time-stop fires TODAY (2026-06-04) — market-open routine will close NVDA at open regardless of watchlist. Current portfolio: A (time-stop 2026-06-11), NVDA (time-stop 2026-06-04 TODAY), SMTC (time-stop 2026-06-10), WDAY (time-stop 2026-06-05 Thu). After NVDA closes: 3/5 positions open (2 slots available).

## 2026-06-03 end-of-day pass
- market: open
- time-stops: 0 (A=2026-06-11, NVDA=2026-06-04, SMTC=2026-06-10, WDAY=2026-06-05 — none reached today)
- expiry guard: no options in portfolio
- safety net exits (stop/target re-check at close):
  - A:    cur=$137.77  ret=+3.01%  stop=$117.70  target=$167.18 → HOLD
  - NVDA: cur=$215.03  ret=-4.00%  stop=$197.10  target=$279.97 → HOLD
  - SMTC: cur=$163.69  ret=-0.79%  stop=$145.20  target=$206.25 → HOLD
  - WDAY: cur=$146.59  ret=+12.42% stop=$114.75  target=$163.00 → HOLD
- exits: 0
- thesis check: UNAVAILABLE — Grok API credits exhausted (xAI HTTP 403; no thesis-broken sells)
- weekly-loss-cap: -0.18% WTD vs -30% cap → clear
- account post-close: equity=$99,912, cash=$79,740, buying_power=$179,652, day_pnl=-0.12%
- NOTE: NVDA time-stop fires TOMORROW (2026-06-04) — market-open routine will close at open
- eod email: sent (id=9197fddf-5131-47ef-bd83-b2c259d78df3)
- daily loss cap: day_pnl=-0.12% (cap -15%: clear)

## 2026-06-03 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 4 (A, NVDA, SMTC, WDAY) — matches portfolio.md; CAVA closed EOD 2026-06-02
- exits evaluated (price-based stops/targets):
  - A:    cur=$133.645  ret=-0.07%  stop=$117.70  target=$167.18 → NO EXIT
  - NVDA: cur=$222.26   ret=-0.77%  stop=$197.10  target=$279.98 → NO EXIT
  - SMTC: cur=$166.235  ret=+0.75%  stop=$145.20  target=$206.25 → NO EXIT
  - WDAY: cur=$144.99   ret=+11.19% stop=$114.75  target=$163.00 → NO EXIT
- thesis check: UNAVAILABLE — Grok API credits exhausted (HTTP 403; no thesis-broken sells per hard rule)
- exits: 0
- halt checks: day_pnl=-0.08% (cap -15%: clear); weekly_pnl=-0.61% (cap -30%: clear); open_positions=4/5
- entries: 0 (watchlist empty — Grok exhausted since 2026-06-02)
- account: equity=$99,982.22, cash=$79,740.30, buying_power=$179,722.52, day_pnl=-0.08%
- NOTE: NVDA time-stop fires TOMORROW (2026-06-04) — EOD routine today will close

## 2026-06-03 pre-market watchlist

Research pass FAILED: xAI API credits exhausted — HTTP 403 from api.x.ai with message "Your team has either used all available credits or reached its monthly spending limit." All four Grok queries blocked. No watchlist generated. Market-open will see no watchlist and sit out.

Note: portfolio holds A (time-stop 2026-06-11), NVDA (time-stop 2026-06-04, tomorrow), SMTC (time-stop 2026-06-10), WDAY (time-stop 2026-06-05, Thu). 4 open positions (4/5 max). CAVA closed via stop-loss at EOD yesterday.

## 2026-06-02 pre-market watchlist

Research pass FAILED: xAI API credits exhausted — HTTP 403 from api.x.ai with message "Your team has either used all available credits or reached its monthly spending limit." All four Grok queries blocked. No watchlist generated. Market-open will see no watchlist and sit out.

Note: portfolio is also at max concurrent positions (5/5: A, CAVA, NVDA, SMTC, WDAY), so no new entries could have been placed today regardless. CAVA hits its time-stop tomorrow (2026-06-03).

## 2026-06-02 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 5 (A, CAVA, NVDA, SMTC, WDAY) — matches portfolio.md
- exits evaluated (price-based stops/targets):
  - A:    cur=$133.37  ret=-0.28%  stop=$117.70  target=$167.18 → NO EXIT
  - CAVA: cur=$73.60   ret=-10.75% stop=$72.57   target=$103.08 → NO EXIT (gap $1.03 above stop — WATCH)
  - NVDA: cur=$225.90  ret=+0.86%  stop=$197.10  target=$279.97 → NO EXIT
  - SMTC: cur=$159.00  ret=-3.64%  stop=$145.20  target=$206.25 → NO EXIT (SMTC recovered from prior -9.87% low)
  - WDAY: cur=$150.49  ret=+15.41% stop=$114.75  target=$163.00 → NO EXIT
- thesis check: UNAVAILABLE — Grok API credits exhausted (same failure as pre-market; grok.sh returned empty)
- exits: 0
- halt checks: day_pnl=-0.09% (cap -15%: clear); weekly_pnl: no closed trades (cap -30%: clear); open_positions=5/5
- entries: 0 (watchlist empty — Grok exhausted; also at max concurrent positions 5/5)
- account: equity=$100,092.57, cash=$75,404.71, buying_power=$175,497.28, day_pnl=-0.09%
- NOTE: CAVA time-stop fires TOMORROW (2026-06-03) — EOD routine will close at whatever price

## 2026-06-02 midday pass
0 exits. All 5 positions within stop/target thresholds.
- A:    cur=$135.13  ret=+1.03%   stop=$117.70  target=$167.18 → HOLD
- CAVA: cur=$73.50   ret=-11.09%  stop=$72.57   target=$103.08 → HOLD (gap $0.93 — TIME-STOP TOMORROW)
- NVDA: cur=$225.51  ret=+0.71%   stop=$197.10  target=$279.98 → HOLD
- SMTC: cur=$166.39  ret=+0.95%   stop=$145.20  target=$206.25 → HOLD
- WDAY: cur=$146.21  ret=+12.03%  stop=$114.75  target=$163.00 → HOLD
- thesis check: UNAVAILABLE — Grok API credits exhausted (same failure as pre-market; no thesis-broken sells per hard rule)

## 2026-06-02 end-of-day pass
- market: open
- time-stops: 0 (A=2026-06-11, NVDA=2026-06-04, SMTC=2026-06-10, WDAY=2026-06-05 — none reached today)
- expiry guard: no options in portfolio
- safety net exits (stop/target re-check at close):
  - A:    cur=$134.60  ret=+0.64%   stop=$117.70  target=$167.18 → HOLD
  - CAVA: cur=$72.42   ret=-12.18%  stop=$72.57   → STOP TRIGGERED — preflight OK → SELL 60 @ $72.26 fill
  - NVDA: cur=$222.42  ret=-0.70%   stop=$197.10  target=$279.97 → HOLD
  - SMTC: cur=$166.54  ret=+0.93%   stop=$145.20  target=$206.25 → HOLD
  - WDAY: cur=$148.79  ret=+14.10%  stop=$114.75  target=$163.00 → HOLD
- exits: 1 (CAVA stop -12.18%, realized -$612)
- thesis check: UNAVAILABLE — Grok API credits exhausted (xAI HTTP 403; no thesis-broken sells)
- weekly-loss-cap: -0.03% WTD vs -30% cap → clear
- account post-close: equity=$100,129, cash=$79,740, buying_power=$179,870, day_pnl=-0.05%
- eod email: sent (id=fedea271-63a3-4c79-97c9-6d36ce7a5694)
- daily loss cap: day_pnl=+0.00% (cap -15%: clear)

## 2026-05-29 midday pass
0 exits. All 5 positions within thresholds (stop -12%, target +25%).
- A: +2.49% — thesis intact (Q2 beat + raised guidance still in play)
- CAVA: -4.02% — thesis intact, no negative news
- NVDA: -3.96% — thesis intact, AI demand positive
- SMTC: -6.34% (down -7% today) — thesis intact; Grok found no concrete catalyst for the drop; old 2024-2025 class action, not fresh
- WDAY: +10.69% — thesis intact, Google Cloud partnership announced yesterday
Day P&L: +0.33% — well within 15% daily loss cap.

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

## 2026-05-28T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (A target_exit=2026-06-11, CAVA target_exit=2026-06-03, NVDA target_exit=2026-06-04, SMTC target_exit=2026-06-10, WDAY target_exit=2026-06-05)
- weekly_loss_cap: no breach (+0.11% WTD vs -6% cap; week start equity $99,556.18 on 2026-05-26)
- positions: 5 (A 36 @ $133.745278, current $136.08, +1.75%; CAVA 60 @ $82.461667, current $78.40, -4.93%; NVDA 22 @ $223.98, current $213.88, -4.51%; SMTC 30 @ $165.00, current $166.58, +0.96%; WDAY 38 @ $130.40, current $130.43, +0.02%)
- account: equity=$99,666.91, cash=$75,404.71, buying_power=$175,071.62, day_pnl=+0.39%
- eod email: sent (id=f39d0b76-be3b-4a8d-89d3-0c3e0371b112)
- risk note: CAVA at -4.93% is now CLOSEST to stop (trigger $76.69 vs current $78.40, gap $1.71) — deteriorated from -2.77% at midday; NVDA at -4.51% (gap $5.58); pre-market Friday must re-evaluate CAVA thesis

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

## 2026-05-29T05:54:16Z preflight reject
- ticker: SMTC260619C00160000  side: buy  qty: 3  price: 6.00
- reason: asset lookup failed (unknown ticker or API error)

## 2026-05-29T05:54:17Z preflight reject
- ticker: SMTC260619C00160000  side: buy  qty: 50  price: 6.00
- reason: asset lookup failed (unknown ticker or API error)

## 2026-05-29T05:54:17Z preflight reject
- ticker: AAPL  side: buy  qty: 10  price: 200
- reason: open positions=5 >= max_concurrent_positions=5

## 2026-05-29T05:56:49Z preflight reject
- ticker: SMTC260618C00160000  side: buy  qty: 3  price: 20.29
- reason: option premium 6.1340% ($6087.00) > max_option_premium_pct=5%

## 2026-05-29T05:56:50Z preflight reject
- ticker: SMTC260618C00160000  side: buy  qty: 100  price: 20.29
- reason: option premium 204.4659% ($202900.00) > max_option_premium_pct=5%

## 2026-05-29T05:56:50Z preflight reject
- ticker: SMTC260618C00160000  side: sell  qty: 1  price: 20.29
- reason: cannot sell-to-open: hold 0 contracts, tried to sell 1 (long-only)

## 2026-05-29T05:56:51Z preflight reject
- ticker: MSFT  side: buy  qty: 1  price: 400
- reason: open positions=5 >= max_concurrent_positions=5

## 2026-05-29T05:57:22Z preflight reject
- ticker: NVDA260612C00215000  side: buy  qty: 100  price: 6.31
- reason: option premium 63.5881% ($63100.00) > max_option_premium_pct=5%

## 2026-05-29T05:57:23Z preflight reject
- ticker: NVDA260612C00215000  side: sell  qty: 1  price: 6.31
- reason: cannot sell-to-open: hold 0 contracts, tried to sell 1 (long-only)

## 2026-05-29T05:57:23Z preflight reject
- ticker: NVDA260612C00215000  side: buy  qty: 3  price: 6.31
- reason: options_enabled is not true in guardrails

## 2026-05-29T05:57:39Z preflight reject
- ticker: NVDA260612C00215000  side: buy  qty: 100  price: 6.31
- reason: option premium 63.5887% ($63100.00) > max_option_premium_pct=5%

## 2026-05-29T05:57:44Z preflight reject
- ticker: NVDA260612C00215000  side: sell  qty: 1  price: 6.31
- reason: cannot sell-to-open: hold 0 contracts, tried to sell 1 (long-only)

## 2026-05-29T05:58:02Z preflight reject
- ticker: NVDA260612C00215000  side: sell  qty: 1  price: 6.31
- reason: cannot sell-to-open: hold 0 contracts, tried to sell 1 (long-only)

## 2026-05-29T05:58:03Z preflight reject
- ticker: NVDA260612C00215000  side: sell  qty: 1  price: 6.31
- reason: cannot sell-to-open: hold 0 contracts, tried to sell 1 (long-only)

## 2026-05-29T06:17:10Z preflight reject
- ticker: AVGO  side: buy  qty: 56  price: 349.65
- reason: open positions=5 >= max_concurrent_positions=5

## 2026-05-29 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- SNOW (Snowflake): Q1 FY26 EPS $0.39 vs $0.14 est.; revenue $1.04B +26% YoY; $6B AWS commitment; stock +36.5% on 2026-05-28. Sources: CNBC, Yahoo Finance.
- BBY (Best Buy): Q1 FY27 EPS $1.28 vs $1.23 est., revenue beat; stock +~15% on 2026-05-28. Sources: CNBC, public.com.

**Q2 — pre-market movers >2% on news (2026-05-29):**
- DELL: pre-market +37-40% on Q1 FY27 beat+raise (AI server demand, record results). Sources: Investing.com, StockAnalysis.
- MU: +3.2% (sector/AI momentum, no fresh corporate news). Source: Investing.com.
- IBM: +5% (AI strength, no fresh earnings catalyst identified). Source: Investing.com.
- ORCL: +3.4% (AI growth narrative). Source: Investing.com.

**Q3 — beat-and-raise earnings after 2026-05-28 close:**
- CRM (Salesforce): Q1 FY27 non-GAAP EPS $3.88 vs ~$3.12 cons (+$0.76 beat); revenue ~$11.13B vs $11.05B est.; raised FY27 revenue guide to $45.9-46.2B. Sources: TIKR, MarketBeat, Schwab.
- SNOW: Q1 FY26 beat+raise (captured above; stock reaction was on 2026-05-28 session).
- Build-A-Bear Workshop: EPS beat + raised profit forecast — micro-cap, below universe floor. Source: Benzinga.

**Q4 — FDA/M&A/contracts/regulator decisions, last 24h:**
- AZN (AstraZeneca): FDA approved durvalumab (Imfinzi) + BCG for BCG-naïve high-risk NMIBC (POTOMAC trial). Source: FDA.gov, 2026-05-28.
- MBC (MasterBrand): Completed all-stock merger with AMWD (~$3.6B). Source: VirginiaBusiness.com.
- CBOE: SEC approved extended pre/post-market trading hours for select single-stock options, effective 2026-07-13. Source: Cboe IR, 2026-05-28.
- UNP/NSC: STB accepted revised UP/NS merger application but held proceeding in abeyance pending more info — not a definitive approval. Source: STB.gov.

### Candidate filter pass

Portfolio already full: 5/5 max_concurrent_positions (A, CAVA, NVDA, SMTC, WDAY). No new entries possible today regardless of score.

Disqualified before scoring:
- SNOW: +36.5% on 2026-05-28 session — move fully priced in from yesterday; catalyst not fresh for today.
- BBY: +15% on 2026-05-28 session — same, already priced in.
- MU, IBM, ORCL: pre-market moves attributed to sector/AI momentum, no fresh corporate catalyst identified.
- Build-A-Bear Workshop: market cap below $2B universe floor.
- MBC: merger completion not fresh (FTC review closed earlier); no price catalyst.
- UNP/NSC: STB acceptance is procedural, not a decision.

Candidates that passed Alpaca + volume checks:

| ticker | alpaca status | 30d ADV (Yahoo) | pass? |
|--------|---------------|-----------------|-------|
| DELL | active/tradable | 7,201,913 | yes |
| CRM | active/tradable | 13,113,460 | yes |
| AZN | active/tradable | 1,954,933 | yes |
| CBOE | active/tradable | 941,573 | yes |

### Scoring

| ticker | catalyst str (0-4) | novelty (0-3) | confirmation (0-2) | cleanliness (0-1) | **score** | verdict |
|--------|--------------------|---------------|--------------------|-------------------|-----------|---------|
| DELL | 4 — Q1 FY27 beat+raise; AI server demand record | 0 — +37-40% priced in pre-market; "move already happened" | 2 — massive up on enormous volume | 1 — no offsets, no earnings in 3d | **7** | Fails freshness pre-req (>5% priced intraday); at position cap |
| CRM | 3 — Q1 FY27 EPS +$0.76 beat; rev raised | 1 — catalyst <24h old, but after-hours price DOWN ~2% ($176.30 vs ~$180 prior close) | 0 — stock declined on earnings | 1 — no offsets | **5** | Market skeptical; not directionally bullish |
| AZN | 2 — FDA label expansion (Imfinzi+BCG, NMIBC) | 1 — catalyst <24h old, but negligible revenue delta for $200B+ company | 0 — after-hours flat/down (-0.9%, $185.38 vs $187.08) | 1 — no offsets | **4** | Immaterial catalyst for company size; no price confirmation |
| CBOE | 1 — SEC approval for extended options hours (effective 2026-07-13) | 1 — catalyst <24h old, distant revenue impact | 0 — stock down -3.8% after-hours | 1 — no offsets | **3** | Minor operational news; negative reaction |

## 2026-05-29 pre-market watchlist result

No tradeable signal today.

Additional constraint: portfolio at max capacity (5/5 positions). Market-open.md should sit out and not execute any entries.

## 2026-05-29 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 5 (A, CAVA, NVDA, SMTC, WDAY — Alpaca matches portfolio.md on qty/entry)
- exits: 0
  - A: live price $133.57, return -0.13% (stop $117.70 [-12%] not breached, target $167.18 [+25%] not hit); thesis intact (Grok: Q2 beat+raise catalyst confirmed, no material negative news)
  - CAVA: live price $79.505, return -3.59% (stop $72.57 not breached); thesis intact (Grok: no material negative news; insider selling is routine, not a corporate negative)
  - NVDA: live price $213.87, return -4.51% (stop $197.10 not breached); thesis intact (Grok: no new China export restrictions, guidance cuts, or exec departures)
  - SMTC: live price $167.48, return +1.50% (stop $145.20 not breached, target $206.25 not hit); thesis intact (Grok: Q1 FY27 beat+raise intact, no material negative news)
  - WDAY: live price $134.40, return +3.07% (stop $114.75 not breached, target $163.00 not hit); thesis intact (Grok: Google Cloud AI partnership expansion noted; no guidance cuts or customer losses)
- halt checks: day_pnl=+0.22% (cap -15% not breached); weekly_pnl≈+0.27% WTD from week-start $99,556.18 (cap -30% not breached); open positions 5/5 (at max — no entries)
- entries: 0 (portfolio full 5/5; watchlist 0 signals — top score DELL=7 but novelty=0 per pre-market pass)
- account: equity=$99,829.01, cash=$75,404.71, buying_power=$175,233.72, day_pnl=+0.22%

## 2026-06-01 pre-market watchlist

### Raw Grok output

**Q1 — bullish news, US large-caps, last 24h:**
- DELL (~$198B): Q1 FY27 AI server revenue +757% YoY to $16.1B; raised FY27 AI server guide to ~$60B (from $50B), full-year rev $165-169B. Stock surged ~33%. Sources: Reuters, Barron's (May 28).
- OKTA: Q1 FY27 rev $765M vs ~$752M est (+11% YoY); EPS beat; strong Agentic AI identity momentum. Stock +30%. Source: Yahoo Finance (May 28).
- JNJ: (1) Phase 3 PROTEUS trial — ERLEADA (apalutamide) significant metastasis/death risk reduction in high-risk localized prostate cancer. (2) Phase 1b/2 OrigAMI-4 — RYBREVANT FASPRO in advanced head/neck cancer, 42% ORR. Presented/published May 31, 2026 (ASCO). Sources: StockTitan, GuruFocus.
- LLY: Retevmo (selpercatinib) Phase 3 adjuvant — 83% risk reduction in early-stage RET+ lung cancer. May 31 ASCO. Source: StockTitan.
- PFE: BRAFTOVI regimen nearly doubling PFS in metastatic colorectal cancer. Phase 3, May 31 ASCO. Source: StockTitan.
- MSFT: +5.5% on ongoing AI strength — no single fresh 24h catalyst identified.

**Q2 — pre-market movers 2026-06-01 >2% on news catalyst:**
(Note: all listed moves are from May 29 open, already fully reflected in last-known prices.)
- DELL: +~32% — Q1 beat, AI server surge. Source: Yahoo Finance, TradingKey.
- NTAP: +~18-23% — Q4/FY26 earnings beat. Source: MarketBeat, Benzinga.
- HPE: +~12% — AI infrastructure earnings. Source: MarketBeat.
- PD (PagerDuty): +~24% — earnings + buyback. Source: MarketBeat.
- REPL (Replimune): +~73% — biotech mover. Source: MarketBeat.

**Q3 — beat-and-raise earnings after yesterday's close (post-May 29/30):**
No qualifying post-May 29 beat-and-raise releases identified. Grok noted ADSK (Q1 rev $1.93B vs $1.89B, raised outlook, per May 30 scoreboard) and GILD (Q1 adj EPS $2.03 vs ~$1.91, raised FY guide +$400M) as earlier-May examples — explicitly NOT post-May 29. Sources: Seeking Alpha, TIKR.

**Q4 — FDA / >$100M contracts / M&A / regulator decisions, last 24h:**
- MNKD (MannKind): FDA expanded Afrezza inhaled insulin to children/adolescents 6+ (announced May 29). Source: AJMC.
- NVRI (Enviri): Clean Earth sale to Veolia + New Enviri spin-off expected to close June 1. Source: Enviri IR.
- OCFC (OceanFirst) + FFIC (Flushing Financial): merger expected to close ~June 1 (all regulatory/shareholder approvals received). Source: OceanFirst IR.

### Candidate filter pass

**Already in portfolio (skip):** A, CAVA, NVDA, SMTC, WDAY — none appear in Grok output.

**Disqualified before Alpaca check:**
- LLY: price $1,127 on May 29 close — exceeds `max_price_per_share: 1000`. Disqualified.
- DELL (+32%), OKTA (+30%), NTAP (+18-23%), HPE (+12%), PD (+24%): all >5% priced in from May 29 session; move already happened per strategy's freshness criterion. Novelty = 0. Disqualified.
- REPL: biotech small-cap, well below $2B universe floor. Disqualified.
- ADSK, GILD: Grok explicitly flags both as pre-May 29 events (not post-close on/after May 29). Already priced in. Disqualified.
- MSFT: "ongoing AI strength" — generic narrative, no specific corporate event. Strategy excludes.
- MNKD: small-cap, likely well below $1B universe floor. Disqualified.
- NVRI: small-cap, ambiguous direction (asset sale + spin-off closing is a structural event, not a growth catalyst). Disqualified.
- OCFC, FFIC: small regional banks (~$1-2B combined), below $1B universe floor individually; M&A target dynamics cap upside. Disqualified.

**Survivors for asset + volume check:** JNJ, PFE

| ticker | tradable | 30d ADV (Yahoo consolidated) | passes 100k? | last known price (May 29 close) | price in $5-$1000? |
|--------|----------|------------------------------|--------------|---------------------------------|---------------------|
| JNJ    | YES      | 7,841,096                    | YES          | $225.23                         | YES                 |
| PFE    | YES      | 35,957,420                   | YES          | $26.17                          | YES                 |

Data note: Alpaca IEX feed has no bars or intraday data beyond May 29 close (missing May 30 and June 1 pre-market). Scores reflect this limitation.

### Scoring

**JNJ — ASCO May 31: Phase 3 PROTEUS (ERLEADA adjuvant prostate) + Phase 1b/2 OrigAMI-4 (RYBREVANT FASPRO head/neck)**
- Catalyst strength: **2** — Phase 3 ERLEADA data is clinically meaningful, but adjuvant data for an already-approved and generating drug is incremental for a $400B company; RYBREVANT OrigAMI-4 is Phase 1b/2 only (early stage, not registrational). Score: 2.
- Novelty: **2** — ASCO Sunday May 31 data is genuinely unpriced; last known trade May 29 ($225.23) predates ASCO. No data available for May 30 or June 1 pre-market. Held from 3 because JNJ was declining into May 29 close ($230.80 → $225.23, -2.4%), suggesting some market weakness or sector rotation that may mute the ASCO pop.
- Confirmation: **0** — Latest bar (May 29): JNJ closed DOWN from prior session ($230.80 → $225.23, -2.4%). No post-ASCO price data available to confirm. Score: 0.
- Cleanliness: **1** — No earnings in next 3 trading days, no offsetting negative news, no halts. Score: 1.
- **Total: 5 — below threshold.**

**PFE — ASCO May 31: Phase 3 BRAFTOVI combination "nearly doubling PFS" in metastatic colorectal cancer**
- Catalyst strength: **2** — "Nearly doubling PFS" in a Phase 3 oncology trial is a strong clinical result. However, Phase 3 data alone (not an FDA approval) is a step removed from cash-flow certainty; BRAFTOVI is one drug in a large portfolio for a $150B company already trading at multi-year lows. Score: 2.
- Novelty: **2** — ASCO Sunday May 31 data is genuinely unpriced; last known trade May 29 ($26.17) predates ASCO. PFE was essentially flat from May 26–29 (no pre-leak). No data for May 30 or June 1 pre-market. Held from 3 due to data gap — can't confirm the move hasn't started.
- Confirmation: **0** — Latest available bar (May 27 close): PFE essentially flat ($26.21). No post-ASCO bars. Score: 0.
- Cleanliness: **1** — No earnings in next 3 trading days, no offsetting news. Score: 1.
- **Total: 5 — below threshold.**

### Watchlist

| ticker | score | catalyst (one line) | source |
|--------|-------|---------------------|--------|

No tradeable signal today.

Skipped (below threshold):
- DELL (pre-market May 29 +32%): AI server beat, massive catalyst, but move fully priced in — novelty = 0. Would also face max-positions constraint.
- OKTA (pre-market May 29 +30%): Q1 beat+raise, novelty = 0.
- NTAP (+18-23%), HPE (+12%), PD (+24%): all May 29 moves, novelty = 0.
- JNJ (score 5): ASCO data is fresh but catalyst is incremental for scale; no price confirmation, declining trend into May 29.
- PFE (score 5): ASCO "nearly doubling PFS" is the strongest surviving catalyst, but Phase 3 alone without FDA action plus no confirmation keeps score at 5. Watch for a confirmed price reaction — if PFE opens up >3% on above-average volume, re-evaluate as a potential score-7 name for tomorrow's pass.
- LLY: ASCO data fresh but price $1,127 exceeds max_price_per_share=$1,000 — hard disqualification.
- ADSK, GILD: pre-May 29 catalysts, already priced.
- MNKD: small-cap, below $1B universe floor.
- OCFC, FFIC, NVRI: small-cap or ambiguous direction.

**Portfolio constraint note:** All 5 positions are currently open (A, CAVA, NVDA, SMTC, WDAY) — at `max_concurrent_positions: 5`. Market-open must sit out entries regardless of watchlist. Three exits approaching on time stop:
- CAVA: target_exit = 2026-06-03 (T-2)
- NVDA: target_exit = 2026-06-04 (T-3)
- WDAY: target_exit = 2026-06-05 (T-4)

## 2026-06-01 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 5 (A, CAVA, NVDA, SMTC, WDAY — Alpaca matches portfolio.md on qty/entry)
- exits: 0
  - A: live price $133.68, return -0.05% (stop $117.70 [-12%] not breached, target $167.18 [+25%] not hit); thesis intact (Grok: Q2 beat+raise catalyst confirmed, no material negative news)
  - CAVA: live price $76.975, return -6.65% (stop $72.57 not breached); thesis intact (Grok: no material negative news; Q1 beat+raise and raised guidance remain in force)
  - NVDA: live price $217.39, return -2.94% (stop $197.10 not breached); thesis intact — new May 31 DoC guidance closes China export loophole, but NVDA already excluded from China data center revenue and company confirmed no change to current situation; thesis (Q1 FY27 beat+raise, $91B Q2 guide) unaffected
  - SMTC: live price $152.565, return -7.54% (stop $145.20 not breached); thesis intact (Grok: Northland downgrade May 26 is valuation-driven, not a new company-specific negative; Q1 FY27 beat+raise intact)
  - WDAY: live price $152.89, return +17.25% (stop $114.75 not breached, target $163.00 [+25%] not yet hit); thesis intact (Grok: no material negative news; Google Cloud AI partnership positive context)
- halt checks: day_pnl=+0.23% (cap -15% not breached); weekly_pnl=0% realized (cap -30% not breached); open positions 5/5 (at max — no entries)
- entries: 0 (portfolio full 5/5; watchlist 0 signals — top scores JNJ=5, PFE=5, both below threshold)
- account: equity=$100,004.60, cash=$75,404.71, buying_power=$175,409.31, day_pnl=+0.23%
- risk notes:
  - SMTC at -7.54% is closest to stop (trigger $145.20 vs current $152.565, gap $7.365); monitor at midday
  - CAVA at -6.65% approaching stop (trigger $72.57 vs current $76.975, gap $4.405); time-stop 2026-06-03 in 2 days
  - WDAY at +17.25% approaching target (trigger $163.00 vs current $152.89, gap $10.11); time-stop 2026-06-05

## 2026-06-01T15:55-0500 end-of-day pass
- market: open (approaching close)
- time-stops: 0 (A target_exit=2026-06-11, CAVA target_exit=2026-06-03, NVDA target_exit=2026-06-04, SMTC target_exit=2026-06-10, WDAY target_exit=2026-06-05)
- weekly_loss_cap: no breach (+0.44% WTD vs -30% cap; last_equity=$99,719.89 Friday close)
- positions: 5 (A 36 @ $133.745278, current $136.15, +1.80%; CAVA 60 @ $82.461667, current $74.98, -9.07%; NVDA 22 @ $223.98, current $223.26, -0.32%; SMTC 30 @ $165.00, current $148.71, -9.87%; WDAY 38 @ $130.40, current $157.01, +20.41%)
- account: equity=$100,159.04, cash=$75,404.71, buying_power=$175,548.42, day_pnl=+0.44%
- eod email: sent (id=4031cb48-a137-4db5-bf91-65a356a6fa72)
- risk notes:
  - SMTC at -9.87% deepest drawdown (stop $145.20, gap $3.51); time-stop 2026-06-10
  - CAVA at -9.07% approaching stop (trigger $72.57, gap $2.41); time-stop 2026-06-03 (T-2) — must sell at open 2026-06-03 regardless of P&L
  - WDAY at +20.41% approaching +25% target ($163.00, gap $5.99); time-stop 2026-06-05 (T-4)

## 2026-06-11 market-open execution
- market: open (is_open=true, trading_blocked=false)
- positions reconciled: 1 (A — Alpaca matches portfolio.md on qty/entry)
- watchlist: none (pre-market failed — Grok API credits exhausted, day 11) → 0 entries
- exits: 1 queued — A TIME-STOP (target_exit=2026-06-11 reached today)
  - A: cur=$131.61, ret=-1.60% (stop $117.70 not breached, target $167.18 not hit) → sell on time stop per strategy.md exit rule 4
  - thesis check SKIPPED: Grok API credits exhausted (no thesis-broken evaluation possible)
  - preflight: OK (A sell 36 @ 131.61)
  - order submitted: market sell 36 A, order_id=1702b975-5505-4489-a9e5-2affceafd3d2, submitted 13:31:32Z
  - **UNFILLED after ~90s of polling** — status still `new` (paper fill lag). Logged per routine; midday MUST check this order, append the trade-log SELL row with the actual fill price, and reconcile portfolio.md.
- halt checks: day_pnl=-0.01% (cap -15% clear); WTD ~flat (cap -30% clear); positions 1/5
- entries: 0 (no watchlist — research offline)
- account: equity=$99,600.58, cash=$94,875.58, buying_power=$392,732.32
- ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability.

## 2026-06-12 pre-market research pass

Research pass FAILED: Grok API credits exhausted (day 12 consecutive since 2026-06-02).
xAI API returns `permission-denied`: "team has either used all available credits or
reached its monthly spending limit." Confirmed via 3 attempts (2x grok.sh — empty
output, exit 0 — and 1 raw curl showing the error body; grok.sh's jq filter swallows
the error JSON silently).

No watchlist today. Market-open will sit out.

ACTION REQUIRED: Replenish xAI credits at console.x.ai.

## 2026-06-12 market-open

No open positions (Alpaca confirms empty), no watchlist (research pass failed — Grok
credits exhausted, day 12). 0 sells, 0 buys. Equity $99,562.69, 100% cash, day P&L 0.00%.
Sitting out until xAI credits are replenished.

## 2026-06-12 EOD
- positions: 0 (Alpaca confirms empty — 100% cash)
- time-stops: 0; expiry guard: n/a; safety net: nothing to check; trades today: none
- account: equity=$99,562.69, cash=$99,562.69, day_pnl=0.00%
- weekly cap: WTD -0.15% ($99,714.96 Mon open → $99,562.69) vs -30% cap — clear
- eod email: sent (id=2cc07af5-e9b9-42b2-bb41-04d81c938641)
- research still offline: Grok API credits exhausted (day 12). ACTION REQUIRED: replenish at console.x.ai

## 2026-06-12 weekly-review: NO strategy edit
- week of 2026-06-08 to 2026-06-12: WTD=-0.15% (-$152.27, $99,714.96→$99,562.69) vs SPY -0.23% → alpha +0.08%.
- 2 trades closed, both time-stops at a loss (SMTC -3.23%, A -2.65%); 0 stop-outs; 0 preflight rejections; win rate 0%.
- Research offline ALL 5 days (Grok credits exhausted, day 8-12 of outage) — zero candidates scored or rejected; rubric ungradeable this week.
- Q3 time-stop rule technically triggered (both exits red after being green 5+ days earlier) but both fixes are no-ops on this sample: neither name reached +8% (trailing stop never arms), and the green→red flip was the 06-05 SPY -2.6% macro day, not signal decay. No edit per "would it have helped this week" test.
- Current 7-day/-12%/+25% strategy has still produced 0 closed trades under its own rules — no sample to learn from.

---

## 2026-06-17 pre-market research pass

### Grok raw output — Query 1: Materially bullish large-cap news (last 24h)
> **LZB (La-Z-Boy, ~$1.4B market cap):** Strong Q4 FY2026 earnings beat (EPS $1.26 vs. consensus ~$0.82, +$0.44 beat; revenue also topped estimates at ~$570M). Results released after market close on June 16, 2026, with positive commentary on retail sales growth and margin improvement. [streetinsider.com, quiverquant.com]
> **ABBV (AbbVie, large-cap):** FDA approval of SKINVIVE by JUVÉDERM for reducing horizontal neck lines/improving neck appearance (first/only HA injectable for this indication). Announced June 16, 2026. [news.abbvie.com, prnewswire.com]

### Grok raw output — Query 2: Pre-market movers >2% on news catalyst (June 17)
> **ASTS (AST SpaceMobile)**: Up notably in pre-market (~6%+ moves around the news). Catalyst: Company announced BlueBird 8, 9, and 10 satellites cleared/scheduled for SpaceX Falcon 9 launch on June 17 from Cape Canaveral, advancing its space-based cellular broadband constellation. [sherwood.news, finance.yahoo.com]
> **INTC (Intel)**: Up ~4%+ in pre-market. Catalyst: Reports that Intel has commenced production of its 18A-P chips, a key step in its turnaround amid AI-driven CPU demand. [finance.yahoo.com]
> **WDC (Western Digital)**: Gains 2-6%+ range in pre-market data amid ongoing AI storage demand, recent analyst upgrades/price target raises, and sector momentum — thematic, no single-day headline. [finance.yahoo.com, investing.com]

### Grok raw output — Query 3: After-close earnings beats + guidance raises (June 16)
> No specific companies matching the exact criteria (earnings released after the June 16, 2026 market close that both beat EPS/revenue expectations AND raised guidance) were identified in available web search results. Earnings calendars indicate ~84 companies reported on/around June 16 and ~52 on June 17. La-Z-Boy (LZB) reported after close with EPS beat but fiscal-year just ended so no full-year guidance raise possible. [zacks.com, schwab.com]

### Grok raw output — Query 4: FDA approvals, contracts >$100M, M&A, regulator decisions (last 24h)
> **AbbVie (ABBV)**: FDA approved SKINVIVE by JUVÉDERM for reducing neck lines/improving neck appearance in adults. Label extension from prior cheek indication. [news.abbvie.com, prnewswire.com — June 16, 2026]
> **Merck (MRK)**: FDA approved Welireg (belzutifan) + Keytruda (pembrolizumab) combination for adjuvant treatment of certain kidney cancer patients (clear cell renal cell carcinoma). [raps.org — June 16, 2026]
> **Roche**: FDA approved VENTANA PTEN (SP218) RxDx Assay as companion diagnostic for prostate cancer therapy guidance. [clpmag.com]
> **Naloxone/Amphastar**: FDA approved Rextovy, new 4-mg OTC naloxone nasal spray. [ajmc.com, thehill.com]
> **Fox/ROKU M&A**: Fox Corporation (FOXA/FOX) acquiring Roku (ROKU) in cash-and-stock deal ~$22B enterprise value (~$160/share). Announced June 15, 2026. [foxcorporation.com, nbcnews.com]

---

### Candidate universe filter pass

| ticker | ADV (Yahoo 30d) | last price (June 16 close) | active/tradable | filter result |
|--------|-----------------|----------------------------|-----------------|---------------|
| LZB    | 412,336         | $35.19 (pre-earnings close) | yes            | PASS — us_equity NYSE, ADV > 100k, market cap ~$1.3B > $1B, price in range |
| ABBV   | 5,428,126       | —                           | yes            | PASS — us_equity NYSE, ADV >> 100k |
| ASTS   | 26,290,896      | —                           | yes            | PASS — us_equity NASDAQ, ADV >> 100k |
| INTC   | 138,736,126     | $116.88 (after-hours)       | yes            | PASS — us_equity NASDAQ, ADV >> 100k |
| MRK    | 9,957,253       | $115.26                     | yes            | PASS — us_equity NYSE, ADV >> 100k |
| ROKU   | 3,863,176       | $137.94                     | yes            | PASS filters — but M&A arb structure; score below |
| WDC    | —               | —                           | yes            | SKIP — analyst upgrades/sector momentum only; no fresh corporate event (strategy.md: "pundit price targets / analyst upgrades with no new information" excluded) |
| FOXA   | —               | —                           | yes            | SKIP — acquirer in ROKU deal; M&A acquisitions typically depress acquirer price; not bullish for us |

---

### Scoring — survivors

**LZB — La-Z-Boy Incorporated**
- Q4 FY2026 (period ended April 25, 2026) after close June 16: adjusted EPS $1.26 vs $0.82 consensus (+53.7% beat; beat prior year $0.92 too). Revenue $570.3M (flat YoY, roughly in-line). Written same-store sales +11%, delivered +9%. Op margin 9.9% (+50 bps YoY).
- Q1 FY2027 guide: sales $490–510M with adj. op margin 4.0–5.5% (seasonal step-down from Q4's $570M / 9.9% peak quarter; fiscal Q1 = May–July, summer furniture trough).
- Pre-market reaction: Grok notes ~1.8% decline on the print (earnings call scheduled 8:30 AM ET June 17).
- June 16 close: $35.19 (stock declined from $38.50 on June 12 → $35.19 going into earnings; analyst expectations low = consensus $0.82 vs $0.92 prior year, i.e., analysts expected YoY decline).
- Last bar (June 12): close=38.495, vol=18,787 (IEX-understated; Yahoo ADV=412K). 5-bar trend: declining from $39.05 → $38.50.
- Catalyst strength (0–4): **2** — Real EPS beat (+53.7% vs consensus) with strong demand metrics (written +11%). BUT revenue was flat YoY and only in-line vs consensus; no standalone guidance raise (fiscal year ended); Q1 guide disappointed vs Q4 run-rate (though seasonal). The forward signal from written +11% is encouraging but partially offset by the Q1 margin guide (4.0–5.5% vs Q4's 9.9%).
- Novelty (0–3): **3** — Announced after June 16 close; no bar reflects it yet; not priced in.
- Confirmation (0–2): **0** — Pre-market reaction is slightly negative (~-1.8% per Grok); last available bar (June 12) showed declining trend into earnings. Market is not confirming the beat as bullish.
- Cleanliness (0–1): **1** — Just reported; no earnings within 3 days; no halts; no offsetting bad corporate news (Q1 guide weakness is seasonal, not a red flag).
- **Total: 6** → Below threshold. Mixed print: strong EPS beat absorbed by weak Q1 guide and negative initial reaction.

**ABBV — AbbVie Inc.**
- FDA approval of SKINVIVE by JUVÉDERM for neck lines/neck appearance in adults (label extension from cheek indication). Announced June 16, 2026.
- ABBV market cap: ~$390B. Allergan Aesthetics is one division. SKINVIVE neck-line extension is incremental to an existing cosmetic injectable product.
- Catalyst strength (0–4): **1** — Real regulatory event but a cosmetic label extension with no material cash-flow delta at ABBV's scale. Not a first-in-class for a serious indication.
- Novelty (0–3): **2** — Fresh June 16 news, not yet in bars.
- Confirmation (0–2): **0** — No post-announcement bar; last bar (June 12): close=$227.67, flat. No upward catalyst response visible.
- Cleanliness (0–1): **1** — No offsetting news; no halts.
- **Total: 4** → Below threshold. Needle-small for a $390B company.

**ASTS — AST SpaceMobile Inc.**
- BlueBird 8, 9, 10 satellite launch scheduled today (June 17) on SpaceX Falcon 9. Grok reports up notably pre-market.
- Last bar (June 12): open=$97.00, close=$82.43, vol=1,442,562 (very high vol, stock down -15% in one day). 5-bar trend: $92 → $89 → $87 → $97 → $82 — declining with extreme vol spike on last bar.
- The June 12 high-volume down day is a major red flag: distribution. Stock was rejected at $97 and closed at $82 on massive selling.
- Catalyst assessment: Satellite launches are SCHEDULED events, not surprises. BlueBird launch timeline has been publicly disclosed months in advance. Not a "fresh 24-hour" surprise catalyst per strategy.md.
- Catalyst strength (0–4): **2** — Launch is a real milestone for constellation build-out, but it is a known/scheduled event.
- Novelty (0–3): **1** — Known schedule, not a surprise; stock already in declining trend suggesting this launch is not catalyzing fresh demand.
- Confirmation (0–2): **0** — Last bar: down -15% on 3× normal volume. Price action strongly non-confirming even with pre-market bump (could be noise on thin pre-market).
- Cleanliness (0–1): **0** — The June 12 distribution day (large vol + big decline) represents potential negative corporate development (possible lock-up expiry, funding news, etc.). No offsetting positive catalyst that explains the bar. Fails cleanliness.
- **Total: 3** → Below threshold. Declining chart with distribution, known launch event, no fresh surprise.

**INTC — Intel Corporation**
- Reports Intel commenced production of 18A-P chips (2nm-class process; key milestone in Intel's AI/foundry turnaround). Up ~4% pre-market June 17.
- Last bar (June 12): close=$124.55, vol=5,901,388 (roughly normal for INTC). 5-bar trend: strong rally $110 → $124 over June 8–12. Quote June 16 (after-hours): $116.88 — fell back ~$7.67 (-6%) from June 12 high.
- Context: INTC has been the center of an ongoing turnaround narrative (18A, Intel Foundry Services, Lip-Bu Tan CEO). Multiple "18A milestone" headlines over the past 12-18 months. This is a continuation of a running story.
- Catalyst strength (0–4): **3** — "Commenced production" is concrete and material (vs. "making progress"). If 18A-P scales, it re-establishes Intel's competitive position in leading-edge chips. Direct impact on foundry revenue trajectory.
- Novelty (0–3): **1** — 18A story has been in the press for 12+ months; stock ran $110→$124 last week (likely in anticipation), then gave back to $116. Another 4% pre-market pop continues the pattern of repeated buy-the-news/fade cycles. Very little first-wave surprise left.
- Confirmation (0–2): **1** — Up ~4% pre-market = directional confirmation, but the June 12→16 pullback (-6%) weakens conviction (prior wave faded immediately).
- Cleanliness (0–1): **1** — No earnings within 3 days (INTC typically reports late July); no halts.
- **Total: 6** → Below threshold. Compelling tech story but novelty is low for a well-covered, multi-month narrative. Repeated buy/fade pattern suggests smart money already positioned.

**MRK — Merck & Co., Inc.**
- FDA approved Welireg (belzutifan) + Keytruda combination for adjuvant treatment of clear cell renal cell carcinoma (kidney cancer). June 16, 2026.
- MRK market cap: ~$290B. Keytruda is the world's largest oncology drug (~$30B+ revenue). Adjuvant kidney cancer indication expands the label into earlier-stage patients.
- Last bar (June 12): close=$119.04, vol=405,931 (below 9.96M ADV — thin bar; IEX issue). Quote June 16: $115.26 — stock actually declined from $120 range to $115.
- Catalyst strength (0–4): **2** — Real label expansion for Keytruda (adjuvant = earlier-stage, larger patient population). However, adjuvant kidney cancer is not a top-5 indication; at MRK's scale, incremental.
- Novelty (0–3): **2** — Fresh June 16 news; FDA approval for combo rather than monotherapy is a novel regulatory outcome.
- Confirmation (0–2): **0** — MRK declined from $120→$115 on June 16 (stock went DOWN on or around the approval day). Zero confirmation.
- Cleanliness (0–1): **1** — No offsetting news; no halts; no earnings within 3 days.
- **Total: 5** → Below threshold. Real catalyst but non-confirming price action (MRK fell on the day).

**ROKU — Roku Inc.**
- Fox acquiring ROKU at ~$160/share (cash-and-stock, $22B enterprise value). Announced June 15.
- ROKU June 12 bar: open=$124.41, high=$148.74, close=$143.22, vol=723K (4× normal) — this was the announcement day or the day before. June 16 quote: $137.94. Stock has ALREADY moved +$18–19 from pre-announcement and is now fading below June 12 close.
- Same structural problem as prior ROKU analysis (June 16 pass): M&A arb. Upside capped at $160; current $137.94 = +15.9% max gain, far below +60% profit target for shares.
- **Structurally ineligible** — M&A arb is not our thesis. Skip.

---

## 2026-06-17 pre-market watchlist

No tradeable signal today.

Skipped (below threshold):
- LZB (score 6): Q4 EPS $1.26 vs $0.82 (+53.7%) is a real beat, but revenue flat, Q1 FY2027 guide disappoints seasonally, initial pre-market reaction is mild ~-1.8%, no confirmation. Score just misses.
- INTC (score 6): 18A-P production start is a concrete milestone, but 18A story is well-covered (12+ months), stock did buy-the-news/fade last week already, novelty too low.
- MRK (score 5): Real FDA combo approval, but stock DECLINED on the day — zero confirmation; needle small for $290B company.
- ABBV (score 4): Cosmetic label extension (neck lines), immaterial for a $390B pharma. Catalyst strength too low.
- ASTS (score 3): Scheduled known launch event (not a surprise catalyst), June 12 distribution day (big vol + -15%) is bearish signal, cleanliness fails.
- ROKU: Structurally ineligible — M&A arb capped at $160 deal price; +15.9% max gain from $137.94 cannot reach +60% profit target.
- WDC: Analyst upgrades / sector momentum only — excluded per strategy.md.

Existing position: TSEM260626C00280000 (Jun 26 $280 call, 10 contracts, entry $23.80, -52.02% as of EOD June 16, bid=$11.42, stop=$9.52, time-stop 2026-06-22) — monitored by midday/EOD routines.
- Verdict: RESUME MONDAY 2026-06-15 WITH CURRENT STRATEGY, contingent on xAI credit replenishment (console.x.ai). Book is 100% cash, 0/5 slots deployed.

---

## 2026-06-17 market-open execution pass
- market: open | trading_blocked: false
- exits checked: 1 position (TSEM260626C00280000)
  - bid=$10.10 ret=-57.56% | stop=-60%($9.52) → HOLD ($10.10 > $9.52) | target=+150%($59.50) → HOLD
  - time-stop: 2026-06-22 (enforced EOD) | expiry guard: 2026-06-26 (enforced EOD)
  - thesis: CLEAR — Grok found no material negative news; InP/AI data center supply agreement with IQE intact
- halt checks: day_pnl=-3.80% vs cap=-40% → CLEAR | weekly realized P&L=$0 (no closed trades this week, WTD unrealized ~-13.8% vs cap=-80%) → CLEAR
- entries: 0 — no candidates from pre-market pass (best: LZB=6, INTC=6; all below threshold of 7)
- no orders placed

---

## 2026-06-18 pre-market research pass

### Grok raw output — Query 1: Materially bullish large-cap news (last 24h)
> Limited materially bullish company-specific news for US large-cap equities in ~24h through June 18, 2026 (June 17 trading/after-hours). Notable items:
> - KMX (CarMax): Q1 earnings and revenue beat (EPS $1.31 vs. $0.95 expected); shares rose >3.5% in response. [cnbc.com/2026/06/16/stock-market-today-live-updates.html]
> - HUN (Huntsman): Upgraded to Neutral from Underperform by Mizuho; PT raised to $14 from $10. [benzinga.com/analyst-stock-ratings/upgrades]
> - MOS (Mosaic): Upgraded to Buy from Sell by Freedom Broker; PT raised to $32 from $24. [benzinga.com]
> - CRI (Carter's): Upgraded to Equal-Weight from Underweight by Wells Fargo; PT raised to $42 from $30. [benzinga.com]
> No high-impact FDA approvals, major M&A, or other catalysts for >$1B names otherwise identified. Source: CNBC, MarketWatch/Benzinga.

### Grok raw output — Query 2: Pre-market movers >2% on news catalyst (June 18)
> QURE (uniQure): ~+78% pre-market on positive regulatory update for AMT-130 gene therapy (Huntington's disease) — BLA submission plans after FDA feedback. [finance.yahoo.com/markets/stocks/gainers/]
> Other large gainers (CAST ~+150%, LNKS ~+90%, APWC ~+70%, ADTX ~+60%) — low-float/penny stock volatility or prior announcements, not fresh same-day catalysts. [benzinga.com/premarket, stockanalysis.com]
> Source: Benzinga, StockAnalysis, Yahoo Finance pre-market snapshots.

### Grok raw output — Query 3: After-close earnings beats + raised guidance (June 17 close)
> No confirmed beat+raise reports available. ACN (Accenture) and KR (Kroger) both have earnings calls scheduled for 8:00 AM EDT June 18 — results not yet published as of Grok's search window. Consensus: ACN EPS ~$3.71, rev ~$18.78B; KR EPS ~$1.59, rev ~$45.4B. Source: newsroom.accenture.com, ir.kroger.com.

### Grok raw output — Query 4: FDA approvals, contracts >$100M, M&A, regulator decisions (last 24h)
> - SPR/SPRO (Spero Therapeutics): FDA approved Utebzi (tebipenem pivoxil), first oral carbapenem for complicated UTIs, June 17 2026. Partner: GSK. SPRO closed ~$2.46 (+16%) on approval day; market cap ~$122M. [us.gsk.com, stocktitan.net/news/SPRO]
> - No other qualifying events (large contract wins, M&A, other regulator decisions) identified.
> Source: FDA announcement via Clinical Trial Vanguard / GSK press release / Drugs.com.

---

### Candidate universe filter pass

**Eliminated before scoring:**
- HUN: Analyst upgrade only — "pundit price target / upgrade with no new information" per strategy.md. Skip.
- MOS: Analyst upgrade only. Skip.
- CRI: Analyst upgrade only. Skip.
- GSK: FDA partner approval (Utebzi) for Spero drug. Immaterial to ~$100B company. Catalyst strength = 0–1. Skip.
- SPRO: FDA approval is real catalyst BUT market cap ~$122M < $1B minimum (guardrails). Skip.
- SPRO (Alpaca symbol): maps to Spirit Aerosystems — inactive/not tradable. N/A.
- QURE: BLA announcement is real catalyst, BUT +78% pre-market = move entirely priced in, novelty = 0. Market cap also sub-$1B. Skip.
- ACN: Earnings results not yet published at research-pass time (call at 8 AM ET, ~1h after this pass runs). Cannot score without actuals. Monitor at market-open.
- KR: Same — results not yet published. Monitor at market-open.

**Survivors: KMX only**

**KMX — volume/asset checks:**
- `alpaca.sh asset KMX`: active, tradable, NYSE, us_equity ✓
- `volume.sh KMX`: 3,464,453 30-day consolidated ADV (Yahoo) >> 100k minimum ✓
- Price (June 17 quote): $47.32 — within $5–$1000 bounds ✓
- Market cap: ~$7–8B >> $1B minimum ✓
- Earnings within 3 days: just reported today, next earnings ~September ✓
- In portfolio: no (all cash after TSEM stop-out June 17) ✓

**KMX — bar confirmation check:**
- Last bar available: June 15, close $52.22, volume 337,080 (IEX; real ADV is 3.46M per Yahoo — IEX under-reports as documented)
- June 17 EOD quote: $47.32 → stock declined ~9.6% in the 2 days preceding earnings (bearish positioning going in)
- Pre-market June 18: up ~3.5% to ~$48.97 in response to Q1 beat
- No regular-session June 18 bar available yet (pre-market routine runs before open)
- Confirmation note: Pre-market uptick on material earnings beat; volume will be elevated given news catalyst — confirmed directional move in progress

**KMX — scoring:**
- Catalyst strength (0–4): Q1 EPS $1.31 vs $0.95 consensus (+38% beat), revenue beat. No guidance raise reported. Beat magnitude is exceptional for large-cap consumer discretionary; cash-flow delta is material for the quarter. **Score: 3**
- Novelty (0–3): Stock down ~9.6% in 2 days going into earnings (market was positioned bearishly). Pre-market reaction (+3.5%) is muted relative to the size of the beat, suggesting most of the re-rating is still ahead as analysts revise estimates upward. **Score: 2**
- Confirmation (0–2): Pre-market up ~3.5% on earnings catalyst. Regular-session bar not yet available. Partial credit. **Score: 1**
- Cleanliness (0–1): No offsetting bad news. No earnings within 3 trading days (just reported). No halt or OTC concern. **Score: 1**
- **Total: 7** — at threshold, tradeable.

---

## 2026-06-18 pre-market watchlist

| ticker | score | catalyst (one line)                                                       | source                                    |
|--------|-------|---------------------------------------------------------------------------|-------------------------------------------|
| KMX    | 7     | Q1 FY2026 EPS $1.31 vs $0.95 consensus (+38% beat), revenue beat; stock -9.6% into earnings | cnbc.com/2026/06/16/stock-market-today-live-updates.html |

Skipped (below threshold):
- QURE (score ~4): +78% pre-market on AMT-130 BLA news — move entirely priced in, novelty = 0; also sub-$1B market cap
- SPRO (N/A): FDA approval of Utebzi (first oral carbapenem) — real catalyst but market cap ~$122M < $1B minimum; eliminated at universe filter
- HUN (score 2): Mizuho upgrade to Neutral — analyst upgrade only, no new corporate information; excluded per strategy.md
- MOS (score 2): Freedom Broker upgrade to Buy — analyst upgrade only; excluded per strategy.md
- CRI (score 2): Wells Fargo upgrade to Equal-Weight — analyst upgrade only; excluded per strategy.md
- GSK (score 1): Utebzi FDA approval is Spero's drug; immaterial to ~$100B company
- ACN (score N/A): Earnings call at 8:00 AM ET — results not published at research-pass time; market-open routine should check actuals before any decision
- KR (score N/A): Same — earnings call at 8:00 AM ET; check at market-open

---

## 2026-06-18 market-open execution pass
- market: open | trading_blocked: false
- exits checked: 0 positions (TSEM260626C00280000 closed at EOD 2026-06-17 via stop-loss)
- ACN market-open check: Down ~18% to ~$128.90 (vs June 17 close $156.01) on revenue miss, full-year guidance cut, weak bookings — despite EPS beat ($3.80 vs $3.71). Negative confirmation; not a bullish catalyst → SKIP.
- KR market-open check: Adjusted EPS $1.58 in-line with consensus (~$1.58–1.59); revenue modest beat; guidance reaffirmed (no raise). Not a tradeable catalyst → SKIP.
- halt checks: day_pnl=0.00% vs cap=-40% → CLEAR | WTD realized=-6.45% (TSEM stop June 17) vs cap=-80% → CLEAR | open positions 0/2 → CLEAR
- entries: 1 candidate (KMX, score=7)
  - OPTIONABLE check: 15 KMX call contracts returned → CALL path attempted
  - Option DTE filter (June 25–July 2, 7–14 DTE): 0 eligible contracts — all available KMX calls expire today (June 18) → fall back to SHARES path
  - Shares sizing: EQUITY=$85,561.70 / PRICE=$48.06 / target_position_pct=50% → QTY=890 shares
  - Preflight: PASS (preflight-check.sh exit=0)
  - Buy order submitted: KMX 890 shares market order (order id=f78c9693-9608-485f-a407-787ebe3c41c7)
  - Fill poll (10 × 3s = 30s): status="new" — UNFILLED after bounded poll
  - ORDER LIVE BUT UNFILLED: f78c9693 — midday routine must confirm fill and log to trade-log.md (YYYY-MM-DD HH:MM | KMX | BUY | 890 | <FILL> | equity score=7 catalyst=Q1 FY2026 EPS $1.31 vs $0.95 (+38% beat); stock -9.6% into earnings | 7 | 2026-06-25)

---

## 2026-06-19 pre-market research pass

### Grok raw output — query 1: large-cap bullish news (last 24h)
- **INTC**: Trump announced via Truth Social that Apple has agreed to partner with Intel on chip design/manufacturing in the US. INTC rallied +10.64% on June 18 ($121.10 → $133.99), intraday high $135.48. Neither company confirmed details; analysts note deal may start small. Sources: Reuters (reuters.com/business/trump-says-apple-work-with-intel-manufacture-chips-us-2026-06-18/), CNBC (cnbc.com/2026/06/18/trump-intel-apple-chip-design-deal.html).
- **MRVL**: Keybanc maintained Overweight + raised PT; stock up ~8% June 18 amid semi rally.
- **MU**: Broad semi sector rally +9% June 18 on memory pricing tailwinds and positive spillover from INTC news.

### Grok raw output — query 2: pre-market movers June 19 (>2%, real news)
- All named movers are micro/penny caps below universe filters: ADTX (+234%), CAST (+133%), CDT (+92%), LNKS (+86%), WKSP (+57%, financing at $1.20/share). No large-cap (>$1B) pre-market movers with genuine news catalysts identified for June 19. Sources: Benzinga premarket, StockAnalysis gainers.

### Grok raw output — query 3: earnings beat + raised guidance (after June 18 close)
- **JBL (Jabil)**: Fiscal Q3 2026 — EPS $3.16 vs ~$3.09 consensus; revenue ~$8.8B vs ~$8.6B est (+12% YoY). Raised FY2026 guidance: revenue to ~$35B (from $34B), core EPS to ~$12.70 (from $12.25), FCF >$1.4B. AI infrastructure strength cited. Initial surge +7–14% on June 17-18, then full reversion; AH June 18 ~$372.65 (+0.21% from $371.88 close). Sources: Proactive Investors, Investing.com, IBD.

### Grok raw output — query 4: FDA / contracts / M&A (last 24h)
- **BIIB**: Announced acquisition of private biotech RayThera for up to $1B; preclinical small-molecule immunology assets; expected close Q3 2026. Sources: Biogen IR, GlobeNewswire.
- **MRNA**: VRBPAC voted 9-0 (unanimous) in favor of Moderna's MFLUSIVA (mRNA-1010) mRNA flu vaccine for adults 50-64 and 65+; AdCom met June 18 (8:30 AM–4:00 PM ET); FDA decision expected August 5, 2026. MRNA closed +3.50% ($61.80 → $63.96), intraday high $67.74 (+9.6%), volume ~24M vs 8M ADV. Sources: BioWorld, BioPharma Dive, Reuters.
- **MRK**: FDA approved additional pediatric indication for CAPVAXIVE pneumococcal vaccine. Minor label expansion for mega-cap. Sources: StockTitan.
- **NVCR**: Phase 3 TRIDENT trial (EF-32) failed primary endpoint — median OS 17.7 vs 17.5 months, HR 0.953, p=0.519; stock -18% on June 18 ($17.85 → ~$14.50–15.73). Sources: BusinessWire, RTTNews.

---

### Candidate evaluation

| ticker | universe pass | catalyst strength (0–4) | novelty (0–3) | confirmation (0–2) | cleanliness (0–1) | score | verdict |
|--------|--------------|------------------------|---------------|-------------------|-------------------|-------|---------|
| INTC | PASS (active, tradable; ADV 137.8M >> 100k) | 2 — Apple-Intel deal unconfirmed by either company; speculative | 0 — +10.64% fully priced in on June 18; AH flat | 1 — big volume June 18, but yesterday's session | 0 — no earnings within 3d? unclear; prior close June 17 $121.10 | **3** | SKIP |
| JBL | PASS (active, tradable; ADV 1.3M >> 100k) | 3 — beat+raise with AI infrastructure tailwind | 1 — surged +7-14% June 17-18, then fully reversed; AH barely moved | 0 — price flat/negative vs pre-earnings close; no confirmation | 1 — clean | **5** | SKIP |
| MRNA | PASS (active, tradable; ADV 8M >> 100k) | 3 — unanimous 9-0 AdCom for mRNA flu vaccine is significant signal | 1 — stock already moved +3.5% (close) / +9.6% (intraday high) on June 18; market has processed the news | 1 — above-average volume June 18, but gave back intraday gains | 1 — clean | **6** | SKIP |
| MRVL | PASS | 0 — analyst PT raise only, no new corporate information | 0 | 1 | 1 | **2** | SKIP (analyst upgrade only; excluded per strategy.md) |
| MU | PASS | 1 — sector sentiment spillover, no specific catalyst | 0 — move already happened June 18 | 1 | 1 | **3** | SKIP (macro/sentiment, not a corporate catalyst) |
| BIIB | PASS | 1 — acquirer of preclinical assets; no near-term cash-flow impact | 0 | 0 | 0 — deal uncertainty | **1** | SKIP (acquirer of early-stage pipeline; not a bullish corporate catalyst) |
| MRK | PASS | 1 — pediatric label expansion immaterial for ~$240B company | 0 | 0 | 1 | **2** | SKIP (not material for mega-cap) |
| NVCR | FAIL (no-short rule; trial failed, stock −18%) | — | — | — | — | — | SKIP (negative catalyst; no-shorts rule) |
| Pre-market movers (WKSP, ADTX, CAST, etc.) | FAIL (all sub-$5/share; sub-$1B market cap) | — | — | — | — | — | SKIP (universe filter: price < $5, market cap < $1B) |

## 2026-06-19 pre-market watchlist

No tradeable signal today.

Best score: MRNA = 6 (AdCom vote already priced into June 18 close; not enough novelty remaining).

Skipped (below threshold):
- INTC (score 3): Trump/Apple-Intel chip deal — +10.64% already priced in on June 18 ($121.10 → $133.99); catalyst is unconfirmed speculation; novelty = 0
- JBL (score 5): Q3 FY2026 beat+raise ($3.16 vs $3.09 EPS; FY guide raised) — stock surged then fully reversed on June 17-18; AH +0.21% only; market has processed and rejected the move
- MRNA (score 6): Unanimous 9-0 VRBPAC vote for MFLUSIVA — meaningful but stock moved +3.5% (intraday +9.6%) on June 18; move already happened; FDA decision August 5 is known timing
- MRVL (score 2): Analyst PT raise only — no new corporate information; excluded per strategy.md
- MU (score 3): Sector sentiment/memory pricing spillover — no specific corporate catalyst
- BIIB (score 1): Acquirer of preclinical immunology assets for up to $1B — not bullish for acquirer
- MRK (score 2): Minor pediatric CAPVAXIVE label expansion — immaterial for ~$240B company
- NVCR (N/A): TRIDENT Phase 3 failed primary endpoint; stock −18%; no-shorts rule applies
- Pre-market movers (WKSP, ADTX, CAST, CDT, LNKS): All micro/penny caps; price < $5 and/or market cap < $1B; eliminated at universe filter

---

## 2026-06-19 market-open execution pass
- market: CLOSED (Juneteenth federal holiday) — is_open=false
- trading_blocked: false
- action: market closed, skipping all exits and entries
- pre-market watchlist: 0 candidates (best score: MRNA=6, below threshold)
- no orders placed

## 2026-06-26 market-open execution pass
- market: OPEN (is_open=true); trading_blocked=false
- positions at open: KMX 890 shares (entry $48.43 2026-06-18, target_exit 2026-06-25)
- Step 1 exits:
  - KMX: cur≈$52.10  ret=+7.6% (stop $36.32 clear, target $77.49 not hit, thesis intact per Grok)
    → TIME STOP fired: target_exit 2026-06-25 < today 2026-06-26 (OVERDUE 1 day; 06-25 EOD did not run).
    Preflight OK. SOLD 890 @ $52.53 (order 56b07918, ret=+8.46%). Sell polled `new` 30s (paper-sim lag) then filled.
- Step 2 halt checks: day_pnl=-0.37% (cap -40%), 0 open positions (cap 2), WTD clear (cap -80%) → ALL CLEAR
- Step 3 entries: 0 — 2026-06-26 pre-market watchlist = no tradeable signal (best MU=6, untradeable >$1000/sh; nothing >=7)
- result: 0 buys, 1 sell, equity≈$89,209, now FLAT (all cash)
- ANOMALY: EOD routine not running (no EOD commits in recent git log; only midday + pre-market fire). KMX slipped a day past its
  time stop because of this — market-open enforced the overdue time stop to honor strategy.md. EOD cron needs investigating.

---

## 2026-06-29 pre-market research pass

### Grok raw output — Query 1: Materially bullish large-cap news (last 24h)
Limited specific company-level bullish news for large-caps (>$2B) in the last ~24h (Jun 28 eve → Jun 29).
No major earnings, beats, guidance raises, FDA approvals, or major contracts widely reported for large-caps;
Jun 29 had no major earnings/data expected. Broader sentiment positive on US-Iran talks (macro, not company-specific).
Prior-period spillover (outside strict 24h window): FCEL +~22% on Jefferies upgrade (analyst action, Jun 26);
AMZN analyst Buy ratings (Jun 26); SMCI/RKLB predate window. Sources: schwab.com, cnbc.com, marketchameleon, morningstar.

### Grok raw output — Query 2: Pre-market movers >2% on catalyst (2026-06-29)
- UPC (Universe Pharmaceuticals): +167–210% pre-mkt on Jun 26 all-stock acquisition of Best Praise Intl (~$10.75M, China patents). Micro/penny-cap.
- DCOY (Decoy Therapeutics): +110–156% on Jun 26 up-to-$21M PIPE financing (dilutive). Micro-cap.
- CHTR (Charter Communications): +11–12% on Bloomberg report (Jun 26) of executive talks with SpaceX re: US consumer mobile partnership. NEITHER COMPANY CONFIRMED.
- CMCSA ~+19–23%, CAH ~+13%, INLF: appeared in aggregates but "lack clearly documented same-day news catalyst" per Grok (unverifiable; possible data error).
Sources: stockanalysis.com, benzinga, cnn, tradingview, stocktitan, reuters, bloomberg.

### Grok raw output — Query 3: After-close beat-AND-raise
None identified. AVAV (AeroVironment) and CNXC (Concentrix) scheduled to report AMC Jun 29 — not yet reported.
Sources: finance.yahoo.com/calendar/earnings, marketbeat.com.

### Grok raw output — Query 4: FDA / >$100M contracts / M&A / regulator (last 24h)
WKEY (WISeKey): Jun 29 merger agreement to redomicile Switzerland → BVI (corporate restructuring, not a bullish demand/cash-flow catalyst). Micro-cap.
No FDA approvals, >$100M contract wins, or major M&A affecting US-listed names in last 24h. AbbVie SKYRIZI pediatric approval (Jun 26) outside window. Sources: stocktitan, investingnews, abbvie.com.

## 2026-06-29 pre-market watchlist

No tradeable signal today.

Best score: CHTR = 3.

Skipped (below threshold):
- CHTR (score 3): SpaceX mobile-partnership "talks" — UNCONFIRMED rumor reported by Bloomberg Jun 26 (3 days stale, fails freshness), neither company confirmed (fails materiality — talks ≠ deal), and +11–12% move already happened Fri (novelty ~0). Liquid large-cap (active/tradable, 30d ADV 3.5M) but the catalyst itself does not qualify. Catalyst 1 + novelty 0 + confirmation 1 + cleanliness 1 = 3.
- UPC (N/A): micro/penny-cap pharma (~$10.75M acquisition); fails universe filter (price <$5, mcap <$1B).
- DCOY (N/A): micro-cap; PIPE financing is dilutive, not a bullish catalyst; fails universe filter.
- WKEY (N/A): redomicile/corporate restructuring, not a demand/cash-flow catalyst; micro-cap.
- CMCSA, CAH (N/A): large moves with NO documented catalyst per Grok — cannot verify a real news event; not tradeable on an unexplained move (likely stale data or sector flow).
- FCEL, AMZN (N/A): analyst upgrade / Buy ratings only — excluded per strategy.md (no new corporate information); also outside 24h window.

## 2026-06-30 market-open

NO pre-market watchlist for 2026-06-30 (pre-market routine did not run / produced no research block).
Market-open had nothing to execute: 0 exits (book flat, Alpaca positions=[]), 0 entries (no watchlist).
Halt checks clear: day_pnl=0.00% vs -40% cap, 0/2 positions. Equity=$89,209.09. Still flat.
FLAGGED for weekly-review: pre-market cron may not be firing (also EOD not committing — see portfolio.md).
