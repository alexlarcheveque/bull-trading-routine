# guardrails.md
# Hard caps. preflight-check.sh refuses any order that violates these.
# Numbers, not prose. Edit a value, restart routines — that's the whole knob panel.

max_position_pct: 100            # FULL YOLO — one name can consume the whole book
target_position_pct: 100         # FULL YOLO — shares fallback is all-in
max_concurrent_positions: 1      # FULL YOLO — one make-or-break bet, not a basket
max_new_positions_per_day: 1     # FULL YOLO — one shot per session

per_trade_stop_pct: 100          # FULL YOLO — shares can go to zero before stop
per_trade_target_pct: 100        # FULL YOLO — target is account-doubling style upside
max_hold_days: 7                 # faster turnover

daily_loss_cap_pct: 100          # FULL YOLO — only a wipeout halts new entries
weekly_loss_cap_pct: 100         # FULL YOLO — only a wipeout halts the week

min_market_cap_usd: 1_000_000_000   # AGGRESSIVE — was 2B; punchier mid-caps
min_avg_daily_volume_shares: 100_000     # REAL consolidated 30-day ADV via scripts/volume.sh (Yahoo), not IEX. Matches strategy.md 100k universe.
max_price_per_share: 1000        # avoid weird high-priced names that fragment 5% sizing
min_price_per_share: 5           # no sub-$5 names

allowed_instruments: [us_equity, us_etf]
disallowed_instruments: [future, crypto, otc, leveraged_etf, inverse_etf]
disallowed_name_substrings: [2X, 3X, UltraPro, Direxion, ProShares Ultra]

no_shorts: true
no_options: false                # FULL YOLO paper-video mode — long calls allowed
no_margin: true                  # cash account behavior; no leverage
no_earnings_within_days: 0       # FULL YOLO — earnings proximity is allowed in paper/video mode

# ---- options caps (only apply when the order is an option) -------------------
# Premium can go to ZERO, so these are sized on premium-at-risk, NOT notional.
options_enabled: true
options_type_allowed: call       # long calls only (no puts, no spreads, no sell-to-open)
max_option_premium_pct: 100      # FULL YOLO — one call play may risk the whole account
max_total_option_premium_pct: 100 # FULL YOLO — total premium-at-risk can be the whole book
option_min_days_to_expiry: 3     # FULL YOLO — short-dated, high gamma
option_max_days_to_expiry: 7     # FULL YOLO — nearest weekly-style expiry window
option_target_pct: 100           # FULL YOLO — double premium, double account if all-in
option_stop_pct: 100             # FULL YOLO — premium can go to zero before stop

# Live trading is gated separately by BULL_MODE=live in env. preflight still applies in live mode.
