#!/usr/bin/env bash
# backtest.sh — exit-rule sanity check on historical bars.
#
# HONEST SCOPE: this script validates whether strategy.md's exit rules
# (stop -7%, target +12%, time-stop 14d) produce sane returns on a basket
# of liquid large-caps, using a technical proxy for "catalyst day"
# (gap up >= 2% on >= 1.5x 20-day average volume).
#
# It does NOT prove the news-catalyst signal works. That would require a
# historical news archive Alpaca does not provide. Treat this as: "are the
# exits + sizing reasonable?" — not "will this strategy print money."
#
# Usage:
#   ./scripts/backtest.sh                 # default 90-day lookback
#   ./scripts/backtest.sh 180             # 180-day lookback
set -euo pipefail

: "${ALPACA_API_KEY:?source .env first (set -a; source .env; set +a)}"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"
ALPACA="$REPO/scripts/alpaca.sh"

# Universe — swap freely; these are liquid large-caps that mirror the strategy's universe.
BASKET=(AAPL MSFT NVDA META AMZN GOOGL TSLA AMD AVGO NFLX)

LOOKBACK_DAYS="${1:-90}"
HOLD_DAYS=14
STOP_PCT=7
TARGET_PCT=12
GAP_PCT=2
VOL_MULT=1.5

total_bars=$(( LOOKBACK_DAYS + HOLD_DAYS + 30 ))  # +30 for 20d avg-volume warmup

out_csv="/tmp/bull-backtest-$(date +%Y%m%d-%H%M%S).csv"
: > "$out_csv"

echo "backtest: basket=${BASKET[*]}"
echo "backtest: lookback=$LOOKBACK_DAYS days, hold=$HOLD_DAYS days, stop=-$STOP_PCT%, target=+$TARGET_PCT%"
echo "backtest: signal proxy = gap >= $GAP_PCT% on >= ${VOL_MULT}x avg volume"
echo

for ticker in "${BASKET[@]}"; do
  bars_json=$("$ALPACA" bars "$ticker" 1Day "$total_bars" 2>/dev/null) || {
    echo "  $ticker: bars fetch failed, skipping" >&2
    continue
  }

  echo "$bars_json" \
  | jq -r '.bars[] | [.o, .h, .l, .c, .v, .t] | @tsv' \
  | awk -v t="$ticker" \
        -v hold="$HOLD_DAYS" -v stop_pct="$STOP_PCT" -v tgt_pct="$TARGET_PCT" \
        -v gap_pct="$GAP_PCT" -v vol_mult="$VOL_MULT" \
        -v out="$out_csv" '
    { o[NR]=$1; h[NR]=$2; l[NR]=$3; c[NR]=$4; v[NR]=$5; ts[NR]=$6; n=NR }
    END {
      for (i=22; i<=n-1; i++) {  # need prior bar + at least one bar after entry
        sum=0; for (k=i-20; k<=i-1; k++) sum+=v[k]
        avgv = sum / 20
        gap = (c[i] - c[i-1]) / c[i-1] * 100
        if (gap < gap_pct) continue
        if (v[i] < avgv * vol_mult) continue

        # Entry at next bar open (no look-ahead leak)
        entry = o[i+1]
        stop_price = entry * (1 - stop_pct/100)
        tgt_price  = entry * (1 + tgt_pct/100)

        end_idx = (i+1+hold > n) ? n : i+1+hold
        exit_idx = -1; exit_price = 0; reason = ""
        for (j=i+1; j<=end_idx; j++) {
          # Stop checked first if both touched same bar (conservative)
          if (l[j] <= stop_price) { exit_idx=j; exit_price=stop_price; reason="stop";   break }
          if (h[j] >= tgt_price)  { exit_idx=j; exit_price=tgt_price;  reason="target"; break }
        }
        if (exit_idx == -1) {
          exit_idx = end_idx; exit_price = c[end_idx]; reason = "time"
        }
        ret = (exit_price - entry) / entry * 100
        printf "%s,%s,%s,%.2f,%.2f,%.2f,%s\n", t, ts[i+1], ts[exit_idx], entry, exit_price, ret, reason >> out
      }
    }
  '
done

total=$(wc -l < "$out_csv" | tr -d ' ')
if [[ "$total" -eq 0 ]]; then
  echo "no signals found in lookback window — try a longer lookback or wider gap threshold"
  exit 0
fi

awk -F, '
{
  total++; sum_ret += $6
  if ($6 > 0) { wins++; sum_win += $6 }
  if ($6 < 0) { losers++; sum_loss += $6 }
  if ($7 == "stop")   stops++
  if ($7 == "target") tgts++
  if ($7 == "time")   times++
}
END {
  printf "trades:                %d\n", total
  printf "win rate:              %.1f%%\n", wins/total*100
  printf "avg return per trade:  %.2f%%\n", sum_ret/total
  printf "avg winner:            %.2f%%\n", (wins ? sum_win/wins : 0)
  printf "avg loser:             %.2f%%\n", (losers ? sum_loss/losers : 0)
  printf "exits:                 stop=%d  target=%d  time=%d\n", stops, tgts, times
  printf "naive 5%%-sized PnL:    %.2f%% (sum of per-trade returns * 0.05)\n", sum_ret * 0.05
}
' "$out_csv"

echo
echo "raw trades: $out_csv"
echo "columns: ticker,entry_date,exit_date,entry,exit,ret_pct,reason"
