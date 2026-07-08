# portfolio.md
# Updated 2026-07-08 06:35 by market-open routine.

## Account
- equity: 88476.15
- cash: -2326.91
- buying_power: 244940.93
- day_pnl_pct: -0.82

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| PENG   | equity     | 1363 | 67.15774   | 2026-07-08 | 2026-07-15  | -0.79              |

## Notes
2026-07-08 market-open: 0 exits (was flat), 1 buy — PENG 1363 sh @ $67.16 (score 8: Q3 +50% EPS beat, FY guide +14%). Halt checks all CLEAR pre-entry (day_pnl 0.00% vs -100% cap; 0/1 positions). Call path was ineligible: PENG has options but nearest expiry is Jul 17 (9 DTE), outside the 3–7 DTE guardrail window — fell back to shares per strategy. ⚠️ Fill slippage: sized 1363 sh at $65.43 quote but market order filled avg $67.16 (+2.6%), so cash is -$2,326.91 — small margin usage vs the no_margin guardrail. No corrective trim sent (procedure doesn't authorize one); flagged for weekly review — consider a sizing buffer (e.g. 98% of equity) for 100%-sized market orders. Order fill was also slow: pending ~90s, partial 807 sh, full fill ~3 min after submit.
2026-07-07 midday: 0 exits (flat — Alpaca confirms no positions, nothing to check). Daily loss cap CLEAR (day_pnl=0.00% vs -100% cap). Equity $89,209.09 unchanged. No new positions (not midday's job).
2026-07-07 market-open: 0 exits (flat — Alpaca confirms no positions), 0 buys. Market OPEN, trading_blocked=false, halt checks all CLEAR (day_pnl=0.00% vs -100% cap; 0/1 positions). 2026-07-07 pre-market watchlist exists (cron fired on time — caffeinate fix holding) but has NO tradeable signal: top scores SPCX=5 and FISV=5, both below the ≥6 FULL YOLO threshold. Still FLAT; cash is a position. Equity $89,209.09 unchanged.
2026-07-06 EOD: 0 time-stops, 0 expiry guards (flat — Alpaca confirms no positions). Weekly loss cap CLEAR (WTD 0.00% vs -100% cap). Equity $89,209.09 unchanged, day_pnl=0.00%. EOD email sent. No trades today — pre-market cron missed, so the armed FULL YOLO session had no watchlist; flag stands for operator/weekly-review.
2026-07-06 midday: 0 exits (flat — Alpaca confirms no positions, nothing to check). Daily loss cap CLEAR (day_pnl=0.00% vs -100% cap). Equity $89,209.09 unchanged. No new positions (not midday's job).
2026-07-06 market-open: 0 exits (flat — Alpaca confirms no positions), 0 buys. Market OPEN, halt checks all CLEAR (day_pnl=0.00% vs -100% cap; 0/1 positions). NO 2026-07-06 pre-market watchlist exists — the pre-market routine did not run this morning, so there was nothing to execute. ⚠️ This was the armed FULL YOLO session (commit adebd2c); flagged in research-log for operator/weekly-review to investigate the missed pre-market cron. Still FLAT; cash is a position.
2026-07-03 operator YOLO request: Alpaca confirms paper mode, account ACTIVE, trading_blocked=false, equity/cash $89,209.09, positions flat. Alpaca clock is_open=false for Independence Day observed; next open 2026-07-06 09:30 ET. No order submitted because market-open gate is closed and preflight cannot be bypassed.
2026-07-02 midday: 0 exits (flat — Alpaca confirms no positions, nothing to check). Daily loss cap CLEAR (day_pnl=0.00% vs -40% cap). Equity $89,209.09 unchanged. No new positions (not midday's job).
2026-07-02 market-open: 0 exits (flat — Alpaca confirms no positions), 0 buys. Halt checks all CLEAR (day_pnl=0.00% vs -40% cap; 0/2 positions). Today's 2026-07-02 pre-market watchlist exists but has NO tradeable signal (top score 6 — BE/GIS/META — below the 7 entry threshold), so no entries. Still FLAT; cash is a position. Note: market next opens 2026-07-06 (Jul 3–5 closed for July 4th holiday).
2026-07-01 midday: 0 exits (flat — Alpaca confirms no positions, nothing to check). Daily loss cap CLEAR (day_pnl=0.00% vs -40% cap). Equity $89,209.09 unchanged. No new positions (not midday's job).
2026-06-30 midday: 0 exits (flat — Alpaca confirms no positions, nothing to check). Daily loss cap CLEAR (day_pnl=0.00% vs -40% cap). No new positions (not midday's job).
2026-06-30 market-open: 0 exits (flat — Alpaca confirms no positions), 0 buys. Halt checks all CLEAR (day_pnl=0.00% vs -40% cap; 0/2 positions). NO 2026-06-30 pre-market watchlist exists in research-log.md (latest block is 2026-06-29) — pre-market routine did not run today, so there was no watchlist to execute. No entries possible. Still FLAT; cash is a position.
