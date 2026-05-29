# guardrails.md
# Hard caps. preflight-check.sh refuses any order that violates these.
# Numbers, not prose. Edit a value, restart routines — that's the whole knob panel.

max_position_pct: 25             # AGGRESSIVE (video mode) — was 7
target_position_pct: 20          # AGGRESSIVE — was 5; concentrated bets = big swings
max_concurrent_positions: 5      # ~full deployment at 20% each
max_new_positions_per_day: 3     # AGGRESSIVE — was 2; deploy fast

per_trade_stop_pct: 12           # AGGRESSIVE — was 7; let losers run scarier
per_trade_target_pct: 25         # AGGRESSIVE — was 12; juicy wins
max_hold_days: 7                 # AGGRESSIVE — was 14; faster turnover

daily_loss_cap_pct: 15           # AGGRESSIVE — was 3; don't halt on first red day
weekly_loss_cap_pct: 30          # AGGRESSIVE — was 6

min_market_cap_usd: 1_000_000_000   # AGGRESSIVE — was 2B; punchier mid-caps
min_avg_daily_volume_shares: 100_000     # REAL consolidated 30-day ADV via scripts/volume.sh (Yahoo), not IEX. Matches strategy.md 100k universe.
max_price_per_share: 1000        # avoid weird high-priced names that fragment 5% sizing
min_price_per_share: 5           # no sub-$5 names

allowed_instruments: [us_equity, us_etf]
disallowed_instruments: [option, future, crypto, otc, leveraged_etf, inverse_etf]
disallowed_name_substrings: [2X, 3X, UltraPro, Direxion, ProShares Ultra]

no_shorts: true
no_options: false                # AGGRESSIVE (video mode) — long calls allowed; was true
no_margin: true                  # cash account behavior; no leverage
no_earnings_within_days: 3       # do not open a new position if earnings within 3 trading days

# ---- options caps (only apply when the order is an option) -------------------
# Premium can go to ZERO, so these are sized on premium-at-risk, NOT notional.
options_enabled: true
options_type_allowed: call       # long calls only (no puts, no spreads, no sell-to-open)
max_option_premium_pct: 5        # max premium for ONE option play as % of equity (~$5k)
max_total_option_premium_pct: 20 # max total premium at risk across ALL open option plays
option_min_days_to_expiry: 14    # avoid 0DTE theta-crush; room past the 7d hold
option_max_days_to_expiry: 45    # don't overpay for far-dated time value
option_target_pct: 80            # take profit on a contract at +80%
option_stop_pct: 50              # cut a contract at -50% premium

# Live trading is gated separately by BULL_MODE=live in env. preflight still applies in live mode.
