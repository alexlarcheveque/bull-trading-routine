#!/usr/bin/env bash
# notify.sh — send a notification email via Resend.
#
# Usage:
#   notify.sh "<subject>" "<body>"
#   notify.sh "<subject>" < body.txt          # body from stdin
#
# Env:
#   RESEND_API_KEY    Resend API key (required)
#   NOTIFY_FROM       verified sender, e.g. "bull@yourdomain.com" or "onboarding@resend.dev" (required)
#   NOTIFY_TO         recipient email (required)
set -euo pipefail

: "${RESEND_API_KEY:?RESEND_API_KEY not set}"
: "${NOTIFY_FROM:?NOTIFY_FROM not set}"
: "${NOTIFY_TO:?NOTIFY_TO not set}"

SUBJECT="${1:?usage: notify.sh \"<subject>\" [<body> | -]}"

if [[ $# -ge 2 ]]; then
  BODY="$2"
else
  BODY="$(cat)"
fi

body=$(jq -n \
  --arg from "$NOTIFY_FROM" \
  --arg to   "$NOTIFY_TO" \
  --arg subj "$SUBJECT" \
  --arg text "$BODY" \
  '{from: $from, to: [$to], subject: $subj, text: $text}')

tmp=$(mktemp)
code=$(curl -sS -o "$tmp" -w "%{http_code}" -X POST https://api.resend.com/emails \
  -H "Authorization: Bearer $RESEND_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$body")

cat "$tmp"
rm -f "$tmp"

if [[ "$code" -lt 200 || "$code" -ge 300 ]]; then
  echo >&2
  echo "notify.sh: HTTP $code from Resend" >&2
  exit 1
fi
