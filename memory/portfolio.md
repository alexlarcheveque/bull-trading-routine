# portfolio.md
# Updated 2026-08-04 09:31 ET by market-open routine.

## Account
- equity: 6894.42
- cash: 186.42
- buying_power: 19528.08
- day_pnl_pct: -1.44  # vs last_equity 6995.30

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| BMY    | equity     | 104 | 64.678846   | 2026-07-31 | 2026-08-07  | -0.21              |

## Notes
2026-08-04 market-open: 0 sells, 0 buys. BMY $64.545 = -0.21% vs entry $64.678846. Exit checks
all clear: stop -100% / target +100% nowhere near; time stop NOT due (fires Friday 2026-08-07);
no options in the book so the expiry guard is n/a; thesis INTACT per Grok — no material negative
BMY news in 24h, and the AZN-BMY talks remain PRELIMINARY (FT 08-02, picked up 08-03; "mull" /
"considering", ~$400B hypothetical combined value, NO firm offer, NO price, NO structure, no
company comment). The WATCH condition has NOT tripped.
NO ENTRIES: book FULL 1/1 (`max_concurrent_positions: 1`) — no free slot regardless. Today's
watchlist also produced zero tradeable candidates: PLTR scored 7 but is DISQUALIFIED by the
mega-cap freshness gate (+16.09% pre-market on a $301B name vs the 4% bar), AMRC scored 6 but
DISQUALIFIED on freshness (+35.3%), BLZE fails min_market_cap_usd ($936M < $1B), AMZN 4, NVS 4,
KVUE 2, MSFT/GOOGL 0.
Halt checks: day P&L -1.44% vs -100% cap → CLEAR. WTD realized 0.00% (no closed trades this
week; last SELL was CCK 07-30) vs -100% cap → CLEAR. Entries blocked by position count, not by
a loss halt.
GIVE-BACK: equity fell $6,997.38 → $6,894.42 (-1.44%) overnight — that is BMY unwinding the
last of the 08-03 merger-chatter pop, now back through the entry price. Entry $64.678846, last
$64.545: the trade is flat-to-negative and the original Q2 beat-and-raise thesis (rev guide
$49-50B) is the only thing carrying it. Time stop governs the exit.
STANDING: BMY time stop lands Friday 2026-08-07 — EOD cron has 5 misses to date and the
caffeinate fix in `scripts/run-routine.sh` is still uncommitted. If the 08-07 EOD run misses,
Monday 2026-08-10 market-open must fire the overdue sell (KMX 06-26 / PENG 07-16 / CCK 07-30
precedent).
WATCH: AZN-BMY merger talks are *preliminary* — if a firm cash offer lands, the ATKR logic
applies (cash deal = hard ceiling) and the second-wave thesis is done; midday/EOD should
re-check whether the move is already consumed rather than assuming more upside.
