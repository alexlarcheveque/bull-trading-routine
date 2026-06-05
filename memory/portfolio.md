# portfolio.md
# Updated 2026-06-05 08:31 by market-open routine.

## Account
- equity: 99946.48
- cash: 84443.90
- buying_power: 368780.77
- day_pnl_pct: -0.18

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| A      | equity     | 36  | 133.745278  | 2026-05-28 | 2026-06-11  | +3.25              |
| SMTC   | equity     | 30  | 165.00      | 2026-05-27 | 2026-06-10  | -1.13              |
| WDAY   | equity     | 38  | 130.40      | 2026-05-22 | 2026-06-05  | +13.97             |

## Notes
All positions are SHARES (no options in portfolio).
NVDA: fully closed 2026-06-04 via time-stop (2 fills: 15@$213.44 at open, 7@$214.57 at 13:36 UTC). Avg exit $213.80, ret=-4.55%.
WDAY: time-stop fired 2026-06-05 — sell order df179d63 submitted at market open, still "new" (unfilled) after 90s. Order is live (DAY); midday/EOD routine must confirm fill and log to trade-log.md. Alpaca still shows WDAY as open position.

Risk flags as of market-open 2026-06-05:
- Thesis check UNAVAILABLE: Grok API credits exhausted since 2026-06-02 pre-market (day 4); no thesis-broken sells possible
- WDAY: sell order df179d63 live but UNFILLED — positions still at 3/5
- SMTC: -1.13% (stop at -12%=$145.20 — not near stop)
- ACTION REQUIRED: Replenish xAI credits at console.x.ai to restore research capability
