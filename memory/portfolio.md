# portfolio.md
# Updated 2026-06-03 15:55 by eod routine.

## Account
- equity: 99912.02
- cash: 79740.30
- buying_power: 179652.32
- day_pnl_pct: -0.12

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| A      | equity     | 36  | 133.745278  | 2026-05-28 | 2026-06-11  | +3.01              |
| NVDA   | equity     | 22  | 223.98      | 2026-05-21 | 2026-06-04  | -4.00              |
| SMTC   | equity     | 30  | 165.00      | 2026-05-27 | 2026-06-10  | -0.79              |
| WDAY   | equity     | 38  | 130.40      | 2026-05-22 | 2026-06-05  | +12.42             |

## Notes
All positions are SHARES. Positions opened before the 7-day aggressive rule are grandfathered
under their original target_exit dates (14-day holds set at time of entry). New positions
(opened after aggressive-mode activation) use max_hold_days=7.

Risk flags as of EOD 2026-06-03:
- NVDA: -4.00%, time-stop 2026-06-04 (TOMORROW) — market-open routine will close at open
- WDAY: +12.42% (cur $146.59), profit target $163.00 (gap $16.41) — time-stop 2026-06-05 (Thu)
- Grok thesis check UNAVAILABLE (xAI API credits exhausted since 2026-06-02 pre-market)
- No exit triggers fired at EOD (no position hit -12% stop or +25% target)
- 4/5 positions open; 1 slot available
