# guardrails.md
# Hard caps. preflight-check.sh refuses any order that violates these.
# Numbers, not prose. Edit a value, restart routines — that's the whole knob panel.

max_position_pct: 60             # MAX DEGEN — was 25; one name can be most of the book
target_position_pct: 50          # MAX DEGEN — was 20; all-in on top conviction
max_concurrent_positions: 2      # MAX DEGEN — was 5; two fat bets, not a basket
max_new_positions_per_day: 2     # MAX DEGEN — fill both slots in a day

per_trade_stop_pct: 25           # MAX DEGEN — was 12; let it really breathe (or blow up)
per_trade_target_pct: 60         # MAX DEGEN — was 25; swing for the fences
max_hold_days: 7                 # faster turnover

daily_loss_cap_pct: 40           # MAX DEGEN — was 15; basically never auto-halt
weekly_loss_cap_pct: 80          # MAX DEGEN — was 30

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
max_option_premium_pct: 25       # MAX DEGEN — was 5; one call play up to 25% of equity
max_total_option_premium_pct: 60 # MAX DEGEN — was 20; up to 60% of the book in premium-at-risk
option_min_days_to_expiry: 7     # MAX DEGEN — was 14; short-dated, high gamma
option_max_days_to_expiry: 14    # MAX DEGEN — was 45; near-dated weeklies only
option_target_pct: 150           # MAX DEGEN — was 80; let winners run to a multiple
option_stop_pct: 60              # MAX DEGEN — was 50; give it room before cutting

# Live trading is gated separately by BULL_MODE=live in env. preflight still applies in live mode.
