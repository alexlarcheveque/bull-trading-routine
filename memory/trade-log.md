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
