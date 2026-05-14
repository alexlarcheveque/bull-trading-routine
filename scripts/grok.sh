#!/usr/bin/env bash
# grok.sh — real-time news research via xAI Grok with the Web Search tool
# (Responses API; Chat Completions Live Search is deprecated).
# Usage: ./scripts/grok.sh "What moved AAPL today?"
set -euo pipefail

: "${XAI_API_KEY:?XAI_API_KEY not set}"

QUERY="${1:?usage: grok.sh \"<question>\"}"

curl -sS https://api.x.ai/v1/responses \
  -H "Authorization: Bearer ${XAI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg q "$QUERY" '{
    model: "grok-4.3",
    input: [
      {role: "system", content: "You are a market research assistant. Cite sources inline. Be concise."},
      {role: "user",   content: $q}
    ],
    tools: [
      { type: "web_search" },
      { type: "x_search" }
    ]
  }')" \
  | jq -r '.output_text // ([.output[]? | select(.type=="message") | .content[]?.text] | join("\n"))'
