# Claude Trading Routine

A 24/7 autonomous Alpaca trading agent built on Claude Code routines (cron jobs).

> **Working title:** *I Gave Claude $10K and a Cron Job — and It Trades While I Sleep*
>
> **Hook (recommended — Variant 3):** Alpaca paper account climbs from $10,000 (Day 1) to $10,847 (Day 30), green line beating a gray S&P benchmark, with a picture-in-picture of all 5 Claude routines firing on schedule. Voiceover: *"$10K. 30 days. Zero human input. It beat the S&P."*
>
> (Alternates in `OUTLINE.md` — closed-laptop-vs-trader, and four-notifications-in-a-day.)

---

## What this repo gives you

- **Five Claude Code routines** (pre-market 6:00, market-open 8:30, midday 12:00, end-of-day 3:55, Friday weekly-review 4:00) — drop them straight into Claude's remote routines panel.
- **A pre-flight guardrail skill** (`.claude/skills/bull/preflight-check.sh`) that runs *inside the routine* and refuses to call the Alpaca order endpoint when a trade violates the caps in `memory/guardrails.md` (max position %, daily loss cap, no-options, no-shorting, etc.).
- **Paper-trading as the hard default.** Live trading requires a deliberate env flag plus a one-time CLI confirmation.
- **Pre-fixed env var names** — every routine prompt references the exact same key names defined in `.env.example`. No more first-run no-ops because `ALPACA_API_KEY` vs `ALPACA_KEY` drift.
- **Memory in markdown, committed to main.** Each routine reads `memory/*.md`, acts, then commits the updated files back so the next cron picks up where the last one left off.
- **A backtest harness** (`scripts/backtest.sh`) — replay the last 30 days against your `strategy.md` before going live.

---

## Setup

1. Create an Alpaca paper account at https://alpaca.markets, generate paper API keys.
2. Get an xAI (Grok) API key at https://console.x.ai for real-time news research, and a Resend API key at https://resend.com for end-of-day email notifications.
3. Clone this repo and push it to your own private GitHub repo (the routines will commit to `main`).
4. Copy `.env.example` to `.env` and fill in every key. `.env` is for local testing only — never commit it.
5. Run `./install.sh` — verifies deps, env vars, mode/URL agreement, and Alpaca auth in one pass.
6. Review `memory/strategy.md` and `memory/guardrails.md`. The shipped strategy is a news-driven 14-day-hold system on liquid US large-caps; edit to taste.
7. Run `./scripts/backtest.sh 90` to sanity-check the exit logic on the last 90 days of bars.
8. In Claude Code → Routines → New → Remote: create a cloud environment named `trading`, paste in your API keys as environment variables (matching `.env.example` names exactly), grant full network access, and enable unrestricted branch pushes.
9. Schedule each `routines/*.md` prompt against the `trading` environment at the cron times listed in the file headers (all Central time).
10. Click "Run Now" on each routine at least twice and verify a commit lands on `main`.

---

## Going live (don't skip)

Live trading is gated. To enable:

```bash
./install.sh --enable-live   # prompts for typed confirmation
```

This flips `BULL_MODE=live` in your cloud environment. The pre-flight check stays on regardless — it cannot be disabled without editing `preflight-check.sh` directly.
