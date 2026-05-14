# CLAUDE.md
# Loaded into every routine run. Keep this file short — it costs tokens on every cron.

## Project: bull (24/7 autonomous trader)

- Mode is paper-trading unless BULL_MODE=live.
- Always read memory/*.md first, act, then commit updates to main.
- Every order MUST pass .claude/skills/bull/preflight-check.sh first.
- All API keys live in environment variables (see .env.example), NEVER in .env committed to git.
