# trade-log.md
# Append-only. One row per order. Never edit history; correct via a new row.
# Columns:
#   timestamp           ISO local time
#   ticker
#   side                BUY | SELL
#   qty                 integer
#   fill_price          actual filled_avg_price from Alpaca (NOT submission price)
#   reason              short — for BUY: "score=N catalyst=<one line>"
#                                  for SELL: "stop -7%" | "target +12%" | "time-stop 14d"
#                                          | "thesis-broken: <one line>" | "weekly-cap flatten"
#   score               composite 0-10 from research-log (BUYs only; "-" for SELLs)
#   target_exit_date    entry_date + 14 calendar days (BUYs); for SELLs, the original target

| timestamp | ticker | side | qty | fill_price | reason | score | target_exit_date |
|-----------|--------|------|-----|------------|--------|-------|------------------|
| 2026-05-20 09:31 | CAVA | BUY | 60 | 82.4617 | score=9 catalyst=Q1 beat-and-raise (manual override of 150k volume floor) | 9 | 2026-06-03 |
| 2026-05-21 08:31 | NVDA | BUY | 22 | 223.98 | score=8 catalyst=Q1 FY27 EPS $1.87 vs $1.78; Q2 rev guide $91B vs $87B consensus (+4.6% raise) | 8 | 2026-06-04 |
| 2026-05-22 09:32 | WDAY | BUY | 38 | 130.40 | score=7 catalyst=Q1 FY27 EPS $2.66 vs $2.49 (+7%); raised non-GAAP op-margin guide to 30.5% from 30.0% | 7 | 2026-06-05 |
| 2026-05-27 08:34 | SMTC | BUY | 30 | 165.00 | score=8 catalyst=Q1 FY27 EPS $0.51 vs $0.45 (+13.3%); Q2 guide raised to $328M vs $300.4M (+9.2%) | 8 | 2026-06-10 |
| 2026-05-28 08:34 | A | BUY | 9 | 134.23 | score=7 catalyst=Q2 FY26 EPS $1.49 vs $1.41 (+5.7%); FY EPS guide raised to $6.00-$6.10, rev to $7.39-7.49B (partial fill 9/36; 27 shares pending order b73867cc) | 7 | 2026-06-11 |
| 2026-05-28 12:00 | A | BUY | 27 | 133.584 | full-fill correction — order b73867cc complete; 27 remaining shares filled; total position 36 shares @ $133.745278 avg (supersedes partial-fill row above) | - | 2026-06-11 |
| 2026-06-02 14:56 | CAVA | SELL | 60 | 72.26 | stop -12.18% | - | 2026-06-03 |
| 2026-06-04 08:31 | NVDA | SELL | 15 | 213.44 | time-stop 7d (partial fill; 7 shares remaining under order ada63afb-10e4-4e90-bdfb-db278f3237ee) | - | 2026-06-04 |
| 2026-06-04 13:36 | NVDA | SELL | 7 | 214.5743 | time-stop 7d (final fill; order ada63afb complete; total exit avg $213.80 for all 22 shares, ret=-4.55%) | - | 2026-06-04 |
| 2026-06-05 08:37 | WDAY | SELL | 38 | 148.4621 | time-stop 7d (order df179d63; filled 08:37 CT; ret=+13.85%) | - | 2026-06-05 |
| 2026-06-10 08:33 | SMTC | SELL | 30 | 159.672 | time-stop 7d (order c0074680; avg fill $159.672; ret=-3.23%) | - | 2026-06-10 |
| 2026-06-11 08:37 | A | SELL | 36 | 130.198056 | time-stop 7d (order 1702b975 submitted at market-open, filled 08:37 CT; ret=-2.65%) | - | 2026-06-11 |
| 2026-06-15 08:31 | TSEM260626C00280000 | BUY | 10 | 23.8 | option call score=7 catalyst=Multi-year InP epiwafer supply agreement with IQE for AI data center optical; IP litigation settled underlying=TSEM | 7 | 2026-06-22 |
| 2026-06-17 14:56 | TSEM260626C00280000 | SELL | 10 | 9.8 | stop -58.82% (bid $8.86 crossed -60% threshold $9.52; order abf8f693) | - | 2026-06-22 |
| 2026-06-18 09:31 | KMX | BUY | 890 | 48.431618 | score=7 catalyst=Q1 EPS $1.31 vs $0.95 +38% beat; call path ineligible (no 7-14 DTE KMX calls — all expired today Jun 18); fell back to shares (order f78c9693; fill confirmed midday) | 7 | 2026-06-25 |
| 2026-06-26 06:33 | KMX | SELL | 890 | 52.53 | time-stop OVERDUE (target_exit 2026-06-25, sold 06-26; 06-25 EOD routine did not run to enforce it); ret=+8.46% vs entry $48.43; thesis intact (Grok: no negative news); order 56b07918 | - | 2026-06-18 |
| 2026-07-08 06:35 | PENG | BUY | 1363 | 67.15774 | score=8 catalyst=Q3 adj EPS $0.84 vs $0.56 +50% beat, FY guide raised +14%; call path ineligible (nearest expiry Jul 17 = 9 DTE, outside 3-7 DTE window); fell back to shares (order 12242a0d; slow fill ~3min, partial 807 then full) | 8 | 2026-07-15 |
| 2026-07-16 06:35 | PENG | SELL | 1363 | 69.00 | time-stop OVERDUE (target_exit 2026-07-15; 07-15 EOD never ran, sold at 07-16 open); ret=+2.74% vs entry $67.15774; realized +$2511; order 6ffa504b | - | 2026-07-08 |
| 2026-07-17 06:39 | MRK260724C00130000 | BUY | 449 | 2.01 | option call score=8 catalyst=FDA approved Lipfendra (enlicitide), first oral PCSK9 inhibitor (07-16) underlying=MRK; expiry 07-24 (7 DTE), strike 130 vs spot 129.26; premium $90,249 (order e3e48485) | 8 | 2026-07-24 |
| 2026-07-21 08:41 | MRK260724C00130000 | SELL | 449 | 0.12 | stop -100% premium (triggered at market-open 07-21, bid $0.00; market close rejected no-bid, limit laddered $0.15→$0.05, filled avg $0.12 08:41 CT; ret=-94.03% vs entry $2.01, realized -$84,861; order 61cab386) | - | 2026-07-24 |
| 2026-07-22 06:39 | CCK | BUY | 57 | 116.99 | equity score=6 catalyst=Q2 beat-and-raise (EPS $2.49 vs $2.16, FY raised to $8.30-8.50), day-2 second-wave entry; call path ineligible (Alpaca option-chain returned 0 contracts despite 07-21 has_options note); shares sized 98% haircut, filled +0.62% over $116.27 quote (order 942f8346) | 6 | 2026-07-29 |
| 2026-07-30 08:31 | CCK | SELL | 57 | 118.52 | time-stop OVERDUE (target_exit 2026-07-29; 07-29 EOD never ran, sold at 07-30 open per KMX 06-26/PENG 07-16 precedent); ret=+1.31% vs entry $116.99; realized +$87.21; slow drip fill ~3.5min 43→55→57 (order cef5b8f3) | - | 2026-07-22 |
| 2026-07-31 06:36 | BMY | BUY | 104 | 64.68 | equity score=7 catalyst=Q2 beat ($2.04 vs $1.59) + FY26 guide raise (rev $49-50B, EPS $6.75-7.00), day-2 second-wave; mega-cap shares-only per 07-17 rule; gap sanity OK ($64.72 quote < $65.62 ceiling, +2.6% vs pre-catalyst $63.10); 98% haircut sizing, filled $64.678846 avg -0.06% under quote (order bfff9d35) | 7 | 2026-08-07 |
| 2026-08-10 08:35 | BMY | SELL | 104 | 64.695577 | time-stop OVERDUE (target_exit 2026-08-07; 08-07 EOD fired 5min after close and could not act, carried a 3-day weekend at 97.3% of equity); fired at market-open per strategy.md overdue carve-out, 4th instance after KMX 06-26/PENG 07-16/CCK 07-30; ret=+0.03% vs entry $64.678846, realized +$1.74; feed stale at 09:30 open, order sat `new` ~3.3min then drip-filled 58→104 (order aca2f84a) | - | 2026-07-31 |
| 2026-08-10 08:36 | RDNT | BUY | 96 | 72.30 | equity score=6 catalyst=Q2 rev $622.7M +25% YoY record + adj EPS $0.29 vs ~$0.18-0.20 cons, FY26 Imaging Ctr rev/EBITDA/FCF guides raised (IR 08-09); at-threshold entry; gap check PASSED ($71.78 quote = -0.66% vs $72.26 ref, ceiling was $75.87); call path ineligible (option-chain returned 0 contracts, no 3-7 DTE); 98% haircut sized 96 @ $70.48 quote but filled $72.30 = +2.58% slippage → cash -$26.04, no_margin breach (order 16389080) | 6 | 2026-08-17 |
| 2026-08-17 14:55 | RDNT | SELL | 96 | 75.67 | time-stop 7d ON TIME (target_exit 2026-08-17 = today; **first EOD-enforced time stop since the plist repair** — escalation #3 applied at this morning's market-open, EOD fired 15:55:35 ET and filled 15:55:56 ET, 4min before the close, breaking the 4-run streak of overdue carve-out exits KMX 06-26/PENG 07-16/CCK 07-30/BMY 08-10); ret=+4.66% vs entry $72.30, realized +$323.52; thesis intact at exit (sold on the clock, not on news); submit→fill 4.6s, no slippage vs $75.75 mark; closes the position at 100.4% of equity and **cures the 21-routine `no_margin` breach** — cash -$26.22 → +$7,238.10 (order a70fcfe9) | - | 2026-08-17 |
