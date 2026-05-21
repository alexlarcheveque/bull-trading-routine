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
