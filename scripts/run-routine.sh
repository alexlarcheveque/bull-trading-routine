#!/usr/bin/env bash
# run-routine.sh — invoke a bull routine headless from cron.
#
# Usage:
#   run-routine.sh <routine-name>
#     e.g.  run-routine.sh pre-market
#           run-routine.sh market-open
#
# Reads routines/<name>.md as the prompt, pipes it to `claude -p` headless,
# tees all output to logs/<name>-YYYY-MM-DD.log.
set -euo pipefail

# Cron has a minimal PATH — add Homebrew (Intel + Apple Silicon) and claude's install dir.
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$HERE/.." && pwd)"

ROUTINE="${1:?usage: run-routine.sh <routine-name>}"
PROMPT_FILE="$REPO/routines/$ROUTINE.md"

[[ -f "$PROMPT_FILE" ]] || { echo "run-routine.sh: $PROMPT_FILE not found" >&2; exit 1; }

# Load .env (Alpaca, xAI, Resend, BULL_MODE)
set -a
# shellcheck disable=SC1090
source "$REPO/.env"
set +a

LOG_DIR="$REPO/logs"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/${ROUTINE}-$(date +%Y-%m-%d).log"

cd "$REPO"

{
  echo "=== $(date '+%Y-%m-%d %H:%M:%S %Z') START $ROUTINE ==="
  claude -p "$(cat "$PROMPT_FILE")" --dangerously-skip-permissions
  rc=$?
  echo "=== $(date '+%Y-%m-%d %H:%M:%S %Z') END $ROUTINE (exit=$rc) ==="
} >> "$LOG" 2>&1
