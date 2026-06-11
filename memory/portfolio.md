# portfolio.md
# Updated 2026-06-11 08:35 by market-open routine.

## Account
- equity: 99600.58
- cash: 94875.58
- buying_power: 392732.32
- day_pnl_pct: -0.01

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| A      | equity     | 36  | 133.745278  | 2026-05-28 | 2026-06-11  | -1.60              |

## Notes
A: TIME-STOP SELL PENDING — market sell 36 sh submitted 2026-06-11 13:31:32Z
(order_id=1702b975-5505-4489-a9e5-2affceafd3d2), still status=new after ~90s of
polling at market-open. Midday routine: check this order, append the SELL row to
trade-log.md with the actual fill price, and re-pull positions. Do NOT submit a
duplicate sell while this order is live.

SMTC: closed 2026-06-10 via time-stop. Order c0074680 filled avg $159.672 (30 shares). ret=-3.23%.
WDAY: fully closed 2026-06-05 via time-stop. ret=+13.85%.
NVDA: fully closed 2026-06-04 via time-stop. ret=-4.55%.
CAVA: closed 2026-06-03 via time-stop (stop hit at -12.18%).

Risk flags as of 2026-06-11 market-open:
- Thesis check UNAVAILABLE: Grok API credits exhausted since 2026-06-02 (day 11 consecutive)
- Research offline: pre-market produced no watchlist; no new entries possible until credits restored
- Daily loss cap: -0.01% (cap -15%) — clear
- WTD P&L: ~flat (cap -30%) — clear
- ACTION REQUIRED: Replenish xAI credits at console.x.ai
