#!/usr/bin/env bash
# preflight-check.sh — hard guardrail. Refuses any order that would violate
# memory/guardrails.md. Called by the decision prompt BEFORE alpaca.sh buy/sell.
#
# Args:   <ticker> <buy|sell> <qty> <price> [instrument=equity|option]
#         For options: <ticker> is the OCC symbol, <price> is per-share premium
#         (per-contract cost = qty * price * 100), <instrument> must be "option".
# Exit 0: trade is allowed.
# Exit 1: trade is rejected. Reason printed on stderr.
# Exit 2: configuration error (missing files, bad env, etc.).
#
# Every reason printed is also appended to memory/research-log.md so the weekly
# review can see what got blocked.
set -euo pipefail

# ---- locate repo + dependencies ----------------------------------------------
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$HERE/../../.." && pwd)"
GUARDRAILS="$REPO/memory/guardrails.md"
ALPACA="$REPO/scripts/alpaca.sh"
LOG="$REPO/memory/research-log.md"

[[ -f "$GUARDRAILS" ]] || { echo "preflight: $GUARDRAILS missing" >&2; exit 2; }
[[ -x "$ALPACA"     ]] || { echo "preflight: $ALPACA not executable" >&2; exit 2; }
command -v jq >/dev/null || { echo "preflight: jq required" >&2; exit 2; }

# ---- args --------------------------------------------------------------------
TICKER="${1:?usage: preflight-check.sh <ticker> <buy|sell> <qty> <price>}"
SIDE="${2:?usage: preflight-check.sh <ticker> <buy|sell> <qty> <price>}"
QTY="${3:?usage: preflight-check.sh <ticker> <buy|sell> <qty> <price>}"
PRICE="${4:?usage: preflight-check.sh <ticker> <buy|sell> <qty> <price> [equity|option]}"
INSTRUMENT="${5:-equity}"

[[ "$SIDE" == "buy" || "$SIDE" == "sell" ]] || { echo "preflight: side must be buy|sell" >&2; exit 1; }
[[ "$INSTRUMENT" == "equity" || "$INSTRUMENT" == "option" ]] || { echo "preflight: instrument must be equity|option" >&2; exit 1; }
TICKER_UC=$(echo "$TICKER" | tr '[:lower:]' '[:upper:]')

# ---- guardrails reader -------------------------------------------------------
# Lines look like:  key: value   or   key: [a, b, c]
g_num() {
  # numeric — strip inline comments, underscores (2_000_000), whitespace
  grep -E "^$1:" "$GUARDRAILS" | head -1 | sed -E 's/#.*$//' | awk -F': *' '{print $2}' | tr -d '_ '
}
g_str() {
  grep -E "^$1:" "$GUARDRAILS" | head -1 | sed -E 's/#.*$//' | awk -F': *' '{print $2}' | awk '{print $1}'
}
g_list() {
  grep -E "^$1:" "$GUARDRAILS" | head -1 | sed -E 's/#.*$//' | sed -E 's/^[^:]+:[[:space:]]*//' | tr -d '[]' | tr ',' '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
}

MAX_POSITION_PCT=$(g_num max_position_pct)
MAX_CONCURRENT=$(g_num max_concurrent_positions)
MAX_NEW_PER_DAY=$(g_num max_new_positions_per_day)
DAILY_LOSS_CAP=$(g_num daily_loss_cap_pct)
WEEKLY_LOSS_CAP=$(g_num weekly_loss_cap_pct)
MIN_PRICE=$(g_num min_price_per_share)
MAX_PRICE=$(g_num max_price_per_share)
NO_SHORTS=$(g_str no_shorts)

# bash arrays of strings (mapfile not available on macOS bash 3.2)
DISALLOWED_SUBSTR=()
while IFS= read -r line; do DISALLOWED_SUBSTR+=("$line"); done < <(g_list disallowed_name_substrings)
ALLOWED_INSTR=()
while IFS= read -r line; do ALLOWED_INSTR+=("$line"); done < <(g_list allowed_instruments)

reject() {
  local reason="$1"
  echo "preflight REJECT $TICKER_UC $SIDE $QTY @ $PRICE — $reason" >&2
  {
    echo
    echo "## $(date -u +%Y-%m-%dT%H:%M:%SZ) preflight reject"
    echo "- ticker: $TICKER_UC  side: $SIDE  qty: $QTY  price: $PRICE"
    echo "- reason: $reason"
  } >> "$LOG"
  exit 1
}

# ---- OPTIONS PATH ------------------------------------------------------------
# Options are sized on premium-at-risk (can go to zero), not share notional.
# This branch handles all option checks and exits; the share-based checks below
# only run for equity orders.
if [[ "$INSTRUMENT" == "option" ]]; then
  OPTIONS_ENABLED=$(g_str options_enabled)
  [[ "$OPTIONS_ENABLED" == "true" ]] || reject "options_enabled is not true in guardrails"

  MAX_OPT_PREMIUM_PCT=$(g_num max_option_premium_pct)
  MAX_TOTAL_OPT_PCT=$(g_num max_total_option_premium_pct)

  ACCT_JSON=$("$ALPACA" account)
  EQUITY=$(echo "$ACCT_JSON" | jq -r '.equity')
  LAST_EQUITY=$(echo "$ACCT_JSON" | jq -r '.last_equity')
  [[ "$(echo "$ACCT_JSON" | jq -r '.account_blocked')" == "false" ]] || reject "account is blocked"
  [[ "$(echo "$ACCT_JSON" | jq -r '.trading_blocked')" == "false" ]] || reject "trading is blocked"

  # premium cost of THIS play = qty contracts * per-share premium * 100
  PLAY_PREMIUM=$(awk -v q="$QTY" -v p="$PRICE" 'BEGIN { printf "%.2f", q * p * 100 }')

  if [[ "$SIDE" == "buy" ]]; then
    DAY_PNL_PCT=$(awk -v e="$EQUITY" -v l="$LAST_EQUITY" \
      'BEGIN { if (l+0 == 0) print 0; else printf "%.4f", (e - l) / l * 100 }')
    awk -v p="$DAY_PNL_PCT" -v cap="$DAILY_LOSS_CAP" \
      'BEGIN { exit (p+0 > -cap+0) ? 0 : 1 }' \
      || reject "daily P&L $DAY_PNL_PCT% breached daily_loss_cap_pct=-$DAILY_LOSS_CAP%"

    PLAY_PCT=$(awk -v c="$PLAY_PREMIUM" -v e="$EQUITY" 'BEGIN { printf "%.4f", c / e * 100 }')
    awk -v pct="$PLAY_PCT" -v cap="$MAX_OPT_PREMIUM_PCT" \
      'BEGIN { exit (pct+0 <= cap+0) ? 0 : 1 }' \
      || reject "option premium $PLAY_PCT% (\$$PLAY_PREMIUM) > max_option_premium_pct=$MAX_OPT_PREMIUM_PCT%"

    POSITIONS_JSON=$("$ALPACA" positions)
    EXISTING_OPT_PREMIUM=$(echo "$POSITIONS_JSON" | jq -r '
      [ .[] | select(.asset_class == "us_option") | (.market_value|tonumber|fabs) ] | add // 0')
    TOTAL_PCT=$(awk -v ex="$EXISTING_OPT_PREMIUM" -v add="$PLAY_PREMIUM" -v e="$EQUITY" \
      'BEGIN { printf "%.4f", (ex + add) / e * 100 }')
    awk -v pct="$TOTAL_PCT" -v cap="$MAX_TOTAL_OPT_PCT" \
      'BEGIN { exit (pct+0 <= cap+0) ? 0 : 1 }' \
      || reject "total option premium $TOTAL_PCT% > max_total_option_premium_pct=$MAX_TOTAL_OPT_PCT%"

    HELD=$(echo "$POSITIONS_JSON" | jq -r --arg s "$TICKER_UC" \
      'map(select(.symbol == $s)) | (.[0].qty // "0")')
    awk -v q="$HELD" 'BEGIN { exit (q+0 == 0) ? 0 : 1 }' \
      || reject "already hold $HELD contracts of $TICKER_UC — no adding"
  fi

  if [[ "$SIDE" == "sell" ]]; then
    POSITIONS_JSON=$("$ALPACA" positions)
    HELD=$(echo "$POSITIONS_JSON" | jq -r --arg s "$TICKER_UC" \
      'map(select(.symbol == $s)) | (.[0].qty // "0")')
    awk -v have="$HELD" -v want="$QTY" \
      'BEGIN { exit (have+0 >= want+0) ? 0 : 1 }' \
      || reject "cannot sell-to-open: hold $HELD contracts, tried to sell $QTY (long-only)"
  fi

  echo "preflight OK $TICKER_UC $SIDE $QTY option @ \$$PRICE (premium=\$$PLAY_PREMIUM, equity=$EQUITY)"
  exit 0
fi

# ---- 1. price band -----------------------------------------------------------
awk -v p="$PRICE" -v lo="$MIN_PRICE" -v hi="$MAX_PRICE" \
  'BEGIN { exit (p+0 >= lo+0 && p+0 <= hi+0) ? 0 : 1 }' \
  || reject "price $PRICE outside [$MIN_PRICE, $MAX_PRICE]"

# ---- 2. asset metadata (class, tradable, status, name) -----------------------
ASSET_JSON=$("$ALPACA" asset "$TICKER_UC" 2>/dev/null) \
  || reject "asset lookup failed (unknown ticker or API error)"

read -r ASSET_CLASS ASSET_TRADABLE ASSET_STATUS ASSET_FRACT ASSET_NAME <<<"$(
  echo "$ASSET_JSON" | jq -r '[.class, .tradable, .status, .fractionable, .name] | @tsv'
)"

[[ "$ASSET_STATUS" == "active"  ]] || reject "asset status=$ASSET_STATUS"
[[ "$ASSET_TRADABLE" == "true"  ]] || reject "asset not tradable"

# class must be in allowed list (us_equity, us_etf — Alpaca returns "us_equity" for both)
allowed=0
for c in "${ALLOWED_INSTR[@]}"; do
  [[ "$ASSET_CLASS" == "$c" ]] && allowed=1
done
[[ "$allowed" == "1" ]] || reject "asset class '$ASSET_CLASS' not in allowed_instruments"

# leveraged/inverse ETF name filter
for sub in "${DISALLOWED_SUBSTR[@]}"; do
  [[ -z "$sub" ]] && continue
  case "$ASSET_NAME" in
    *"$sub"*) reject "asset name contains disallowed substring '$sub'";;
  esac
done

# ---- 3. account-level checks: equity, day P&L, position counts ---------------
ACCT_JSON=$("$ALPACA" account)
EQUITY=$(echo "$ACCT_JSON"      | jq -r '.equity')
LAST_EQUITY=$(echo "$ACCT_JSON" | jq -r '.last_equity')
ACCT_BLOCKED=$(echo "$ACCT_JSON"| jq -r '.account_blocked')
TRADING_BLOCKED=$(echo "$ACCT_JSON"| jq -r '.trading_blocked')

[[ "$ACCT_BLOCKED"    == "false" ]] || reject "account is blocked"
[[ "$TRADING_BLOCKED" == "false" ]] || reject "trading is blocked"

# day P&L %
DAY_PNL_PCT=$(awk -v e="$EQUITY" -v l="$LAST_EQUITY" \
  'BEGIN { if (l+0 == 0) print 0; else printf "%.4f", (e - l) / l * 100 }')

# only enforce loss cap on NEW buys (we still allow exits when underwater)
if [[ "$SIDE" == "buy" ]]; then
  awk -v p="$DAY_PNL_PCT" -v cap="$DAILY_LOSS_CAP" \
    'BEGIN { exit (p+0 > -cap+0) ? 0 : 1 }' \
    || reject "daily P&L $DAY_PNL_PCT% breached daily_loss_cap_pct=-$DAILY_LOSS_CAP%"
fi

# ---- 4. position-specific checks ---------------------------------------------
POSITIONS_JSON=$("$ALPACA" positions)
OPEN_COUNT=$(echo "$POSITIONS_JSON" | jq 'length')
EXISTING_QTY=$(echo "$POSITIONS_JSON" | jq -r --arg t "$TICKER_UC" \
  'map(select(.symbol == $t)) | (.[0].qty // "0")')

if [[ "$SIDE" == "buy" ]]; then
  # no adding to existing position (strategy.md rule)
  awk -v q="$EXISTING_QTY" 'BEGIN { exit (q+0 == 0) ? 0 : 1 }' \
    || reject "already hold $EXISTING_QTY $TICKER_UC — no adding to winners"

  # concurrent positions cap
  [[ "$OPEN_COUNT" -lt "$MAX_CONCURRENT" ]] \
    || reject "open positions=$OPEN_COUNT >= max_concurrent_positions=$MAX_CONCURRENT"

  # new positions today cap (count today's filled+open buy orders)
  TODAY_UTC=$(date -u +%Y-%m-%d)
  TODAY_BUYS=$("$ALPACA" orders all 100 | jq --arg d "$TODAY_UTC" \
    '[.[] | select(.side=="buy" and (.submitted_at|startswith($d)))] | length')
  [[ "$TODAY_BUYS" -lt "$MAX_NEW_PER_DAY" ]] \
    || reject "today's buys=$TODAY_BUYS >= max_new_positions_per_day=$MAX_NEW_PER_DAY"

  # post-trade position size as % of equity
  POST_PCT=$(awk -v q="$QTY" -v p="$PRICE" -v e="$EQUITY" \
    'BEGIN { printf "%.4f", (q * p) / e * 100 }')
  awk -v post="$POST_PCT" -v cap="$MAX_POSITION_PCT" \
    'BEGIN { exit (post+0 <= cap+0) ? 0 : 1 }' \
    || reject "post-trade size $POST_PCT% > max_position_pct=$MAX_POSITION_PCT%"
fi

if [[ "$SIDE" == "sell" ]]; then
  # no shorts: must already hold at least QTY shares
  if [[ "$NO_SHORTS" == "true" ]]; then
    awk -v have="$EXISTING_QTY" -v want="$QTY" \
      'BEGIN { exit (have+0 >= want+0) ? 0 : 1 }' \
      || reject "no_shorts: holding $EXISTING_QTY, cannot sell $QTY"
  fi
fi

# ---- pass --------------------------------------------------------------------
echo "preflight OK $TICKER_UC $SIDE $QTY @ $PRICE (equity=$EQUITY, open=$OPEN_COUNT, day_pnl=$DAY_PNL_PCT%)"
exit 0
