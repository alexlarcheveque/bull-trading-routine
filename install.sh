#!/usr/bin/env bash
# install.sh
#
# No args:        verify setup (deps, .env, Alpaca auth, env vars) and print a checklist.
# --enable-live:  flip BULL_MODE to live in .env, after typed confirmation. Also swaps
#                 ALPACA_BASE_URL to the live host so alpaca.sh's mode/URL guard agrees.
# --disable-live: flip BULL_MODE back to paper and ALPACA_BASE_URL to the paper host.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$HERE/.env"

[[ -f "$ENV_FILE" ]] || { echo "install.sh: $ENV_FILE missing — copy from .env.example first" >&2; exit 2; }

ARG="${1:-}"

set_env() {
  local key="$1" val="$2"
  if grep -qE "^$key=" "$ENV_FILE"; then
    sed -i.bak -E "s|^$key=.*|$key=$val|" "$ENV_FILE"
    rm -f "$ENV_FILE.bak"
  else
    echo "$key=$val" >> "$ENV_FILE"
  fi
}

# ---- --enable-live ----------------------------------------------------------
if [[ "$ARG" == "--enable-live" ]]; then
  cat <<'WARN'

  ===================================================================
  YOU ARE ABOUT TO ENABLE LIVE TRADING.

  - Real money. Real losses.
  - The preflight check stays on, but it cannot save you from a
    bad strategy.
  - Make sure you have run ./scripts/backtest.sh and reviewed the
    last 7 days of trade-log.md in paper mode first.

  To proceed, type exactly:  ENABLE LIVE TRADING
  ===================================================================

WARN
  read -r -p "> " CONFIRM
  if [[ "$CONFIRM" != "ENABLE LIVE TRADING" ]]; then
    echo "Aborted. No changes made."
    exit 1
  fi

  set_env BULL_MODE live
  set_env ALPACA_BASE_URL https://api.alpaca.markets
  echo
  echo "BULL_MODE=live and ALPACA_BASE_URL=https://api.alpaca.markets in $ENV_FILE."
  echo "Remember to set the SAME env vars in your Claude Code remote routine environment."
  exit 0
fi

# ---- --disable-live ---------------------------------------------------------
if [[ "$ARG" == "--disable-live" ]]; then
  set_env BULL_MODE paper
  set_env ALPACA_BASE_URL https://paper-api.alpaca.markets
  echo "Reverted to paper mode in $ENV_FILE."
  exit 0
fi

# ---- no args: setup verification --------------------------------------------
echo "bull setup check"
echo

fail=0

for bin in curl jq awk sed git; do
  if command -v "$bin" >/dev/null 2>&1; then
    printf "  [OK]   %s found\n" "$bin"
  else
    printf "  [FAIL] %s missing — install it\n" "$bin"
    fail=1
  fi
done

set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

for var in ALPACA_API_KEY ALPACA_SECRET_KEY ALPACA_BASE_URL BULL_MODE XAI_API_KEY RESEND_API_KEY NOTIFY_FROM NOTIFY_TO; do
  if [[ -n "${!var:-}" ]]; then
    printf "  [OK]   %s set\n" "$var"
  else
    printf "  [WARN] %s empty in .env\n" "$var"
  fi
done

if [[ "${BULL_MODE:-}" == "live" && "${ALPACA_BASE_URL:-}" == *"paper"* ]]; then
  echo "  [FAIL] BULL_MODE=live but ALPACA_BASE_URL points at paper — alpaca.sh will refuse."
  fail=1
elif [[ "${BULL_MODE:-}" != "live" && "${ALPACA_BASE_URL:-}" != *"paper"* ]]; then
  echo "  [FAIL] BULL_MODE=${BULL_MODE:-?} but ALPACA_BASE_URL points at LIVE — alpaca.sh will refuse."
  fail=1
else
  echo "  [OK]   BULL_MODE=${BULL_MODE:-?} and ALPACA_BASE_URL agree"
fi

if "$HERE/scripts/alpaca.sh" account >/dev/null 2>&1; then
  equity=$("$HERE/scripts/alpaca.sh" account | jq -r .equity)
  echo "  [OK]   Alpaca auth works (equity=\$$equity)"
else
  echo "  [FAIL] Alpaca account call failed — check ALPACA_API_KEY/SECRET"
  fail=1
fi

if [[ -x "$HERE/.claude/skills/bull/preflight-check.sh" ]]; then
  echo "  [OK]   preflight-check.sh is executable"
else
  echo "  [FAIL] preflight-check.sh is not executable — chmod +x it"
  fail=1
fi

echo
echo "current mode: ${BULL_MODE:-?}"
echo
if [[ "$fail" == "1" ]]; then
  echo "Some checks failed. Fix them before running any routine."
  exit 1
fi
echo "All checks passed. Next steps:"
echo "  1. Fill memory/strategy.md with your real edge (or keep the seed)."
echo "  2. Review memory/guardrails.md numbers."
echo "  3. ./scripts/backtest.sh 90    # sanity-check exit logic"
echo "  4. Schedule routines/*.md in Claude Code → Remote routines."
echo "  5. When ready: ./install.sh --enable-live"
