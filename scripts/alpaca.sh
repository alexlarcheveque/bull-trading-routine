#!/usr/bin/env bash
# alpaca.sh — signed REST helper for the bull trading skill.
#
# All commands print JSON on stdout. Non-2xx HTTP responses exit non-zero so
# `set -e` callers and preflight wrappers fail loud.
#
# Usage:
#   alpaca.sh account
#   alpaca.sh positions
#   alpaca.sh position    <ticker>
#   alpaca.sh asset       <ticker>
#   alpaca.sh clock
#   alpaca.sh quote       <ticker>                       # latest trade
#   alpaca.sh bars        <ticker> [timeframe=1Day] [limit=20]
#   alpaca.sh orders      [status=all] [limit=50]
#   alpaca.sh order       <order-id>                    # single order by id
#   alpaca.sh buy         <ticker> <qty>                 # day market buy
#   alpaca.sh sell        <ticker>                       # closes full position (market)
#   alpaca.sh cancel-all
#
# Mode safety: BULL_MODE and ALPACA_BASE_URL must agree (paper<>paper-api, live<>api).
set -euo pipefail

: "${ALPACA_API_KEY:?ALPACA_API_KEY not set}"
: "${ALPACA_SECRET_KEY:?ALPACA_SECRET_KEY not set}"
: "${ALPACA_BASE_URL:?ALPACA_BASE_URL not set}"

MODE="${BULL_MODE:-paper}"
DATA_URL="https://data.alpaca.markets"

if [[ "$MODE" == "live" && "$ALPACA_BASE_URL" == *"paper"* ]]; then
  echo "alpaca.sh: BULL_MODE=live but ALPACA_BASE_URL points at paper. Refusing." >&2
  exit 2
fi
if [[ "$MODE" != "live" && "$ALPACA_BASE_URL" != *"paper"* ]]; then
  echo "alpaca.sh: BULL_MODE=$MODE but ALPACA_BASE_URL points at LIVE. Refusing." >&2
  exit 2
fi

_req() {
  local method="$1" url="$2" body="${3:-}"
  local tmp code
  tmp=$(mktemp)
  if [[ -n "$body" ]]; then
    code=$(curl -sS -o "$tmp" -w "%{http_code}" -X "$method" "$url" \
      -H "APCA-API-KEY-ID: $ALPACA_API_KEY" \
      -H "APCA-API-SECRET-KEY: $ALPACA_SECRET_KEY" \
      -H "Content-Type: application/json" \
      -d "$body")
  else
    code=$(curl -sS -o "$tmp" -w "%{http_code}" -X "$method" "$url" \
      -H "APCA-API-KEY-ID: $ALPACA_API_KEY" \
      -H "APCA-API-SECRET-KEY: $ALPACA_SECRET_KEY")
  fi
  cat "$tmp"
  rm -f "$tmp"
  if [[ "$code" -lt 200 || "$code" -ge 300 ]]; then
    echo >&2
    echo "alpaca.sh: HTTP $code on $method $url" >&2
    return 1
  fi
}

cmd="${1:?usage: see header of alpaca.sh}"; shift || true

case "$cmd" in
  account)
    _req GET "$ALPACA_BASE_URL/v2/account"
    ;;
  positions)
    _req GET "$ALPACA_BASE_URL/v2/positions"
    ;;
  position)
    ticker="${1:?usage: alpaca.sh position <ticker>}"
    _req GET "$ALPACA_BASE_URL/v2/positions/$ticker"
    ;;
  asset)
    ticker="${1:?usage: alpaca.sh asset <ticker>}"
    _req GET "$ALPACA_BASE_URL/v2/assets/$ticker"
    ;;
  clock)
    _req GET "$ALPACA_BASE_URL/v2/clock"
    ;;
  quote)
    ticker="${1:?usage: alpaca.sh quote <ticker>}"
    _req GET "$DATA_URL/v2/stocks/$ticker/trades/latest?feed=iex"
    ;;
  bars)
    ticker="${1:?usage: alpaca.sh bars <ticker> [timeframe] [limit]}"
    tf="${2:-1Day}"
    lim="${3:-20}"
    # Alpaca's bars endpoint needs an explicit start when used with limit; default
    # to (limit * 1.6) calendar days back to comfortably cover weekends/holidays.
    back_days=$(( lim * 8 / 5 + 3 ))
    if date -v-1d +%Y-%m-%d >/dev/null 2>&1; then
      start_date=$(date -v-${back_days}d +%Y-%m-%d)             # macOS / BSD
    else
      start_date=$(date -d "${back_days} days ago" +%Y-%m-%d)   # GNU / Linux
    fi
    _req GET "$DATA_URL/v2/stocks/$ticker/bars?timeframe=$tf&limit=$lim&start=$start_date&feed=iex&adjustment=raw"
    ;;
  orders)
    status="${1:-all}"
    lim="${2:-50}"
    _req GET "$ALPACA_BASE_URL/v2/orders?status=$status&limit=$lim&direction=desc"
    ;;
  order)
    order_id="${1:?usage: alpaca.sh order <order-id>}"
    _req GET "$ALPACA_BASE_URL/v2/orders/$order_id"
    ;;
  buy)
    ticker="${1:?usage: alpaca.sh buy <ticker> <qty>}"
    qty="${2:?usage: alpaca.sh buy <ticker> <qty>}"
    body=$(jq -n --arg s "$ticker" --arg q "$qty" '{
      symbol: $s, qty: $q, side: "buy", type: "market", time_in_force: "day"
    }')
    _req POST "$ALPACA_BASE_URL/v2/orders" "$body"
    ;;
  sell)
    ticker="${1:?usage: alpaca.sh sell <ticker>}"
    # Closes the full position with a market order on Alpaca's side.
    _req DELETE "$ALPACA_BASE_URL/v2/positions/$ticker"
    ;;
  cancel-all)
    _req DELETE "$ALPACA_BASE_URL/v2/orders"
    ;;
  *)
    echo "alpaca.sh: unknown command '$cmd'" >&2
    exit 64
    ;;
esac
