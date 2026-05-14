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
