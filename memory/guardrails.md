# guardrails.md
# Hard caps. preflight-check.sh refuses any order that violates these.
# Numbers, not prose. Edit a value, restart routines — that's the whole knob panel.

max_position_pct: 7              # any single position can never exceed 7% of equity
target_position_pct: 5           # opening size for a new position
max_concurrent_positions: 5      # total open names
max_new_positions_per_day: 2

per_trade_stop_pct: 7            # hard stop, mandatory
per_trade_target_pct: 12         # take profit
max_hold_days: 14                # time stop

daily_loss_cap_pct: 3            # if realized+unrealized P&L for the day <= -3%, no new orders today
weekly_loss_cap_pct: 6           # same, but for the week. flatten and pause if breached.

min_market_cap_usd: 2_000_000_000
min_avg_daily_volume_shares: 100_000     # REAL consolidated 30-day ADV via scripts/volume.sh (Yahoo), not IEX. Matches strategy.md 100k universe.
max_price_per_share: 1000        # avoid weird high-priced names that fragment 5% sizing
min_price_per_share: 5           # no sub-$5 names

allowed_instruments: [us_equity, us_etf]
disallowed_instruments: [option, future, crypto, otc, leveraged_etf, inverse_etf]
disallowed_name_substrings: [2X, 3X, UltraPro, Direxion, ProShares Ultra]

no_shorts: true
no_options: true
no_margin: true                  # cash account behavior; no leverage
no_earnings_within_days: 3       # do not open a new position if earnings within 3 trading days

# Live trading is gated separately by BULL_MODE=live in env. preflight still applies in live mode.
