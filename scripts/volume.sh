#!/usr/bin/env bash
# volume.sh — REAL consolidated 30-day average daily volume from Yahoo Finance.
#
# Alpaca's free feed is IEX-only (~4-15% of consolidated volume), which
# false-rejects liquid names whose IEX share is thin (ESLT: 4k IEX vs ~112k real).
# This pulls the consolidated tape instead, so the volume floor measures reality.
#
# Usage:
#   volume.sh <ticker>            # prints integer 30-day avg daily volume (consolidated)
#   volume.sh <ticker> 60         # average over last N trading days (default 30)
#
# Prints a single integer on stdout. Exits non-zero on fetch/parse failure so
# `set -e` callers fail loud rather than treating a name as zero-volume.
set -euo pipefail

TICKER="${1:?usage: volume.sh <ticker> [days=30]}"
DAYS="${2:-30}"

URL="https://query1.finance.yahoo.com/v8/finance/chart/${TICKER}?interval=1d&range=3mo"

JSON=$(curl -sS --fail "$URL" -H "User-Agent: Mozilla/5.0" 2>/dev/null) || {
  echo "volume.sh: fetch failed for $TICKER" >&2
  exit 1
}

ADV=$(echo "$JSON" | jq -r --argjson n "$DAYS" '
  [ .chart.result[0].indicators.quote[0].volume[]? | select(. != null) ] as $v
  | if ($v | length) == 0 then "ERR"
    else ($v[-$n:] | add / ($v[-$n:] | length) | floor)
    end
')

if [[ "$ADV" == "ERR" || -z "$ADV" ]]; then
  echo "volume.sh: no volume data for $TICKER" >&2
  exit 1
fi

echo "$ADV"
