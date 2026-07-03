---
name: bull
description: Autonomous trading agent skill — research, decide, run preflight guardrails, execute via Alpaca, then journal results back to memory/*.md. Invoked from each routine in routines/.
---

# bull

The trading skill. Every routine in `routines/*.md` runs *through* this skill — they
are coordinator-shells that set the time-of-day context, then delegate to the
procedures defined here. Read this file once before doing anything else.

## Invariants (never break these)

1. **Preflight is mandatory before every order.** `./.claude/skills/bull/preflight-check.sh <ticker> <buy|sell> <qty> <price>` — non-zero exit means the order does not happen. There is no override.
2. **Strategy is read-only except in `weekly-review.md`.** Routines may read `memory/strategy.md` but must not edit it. Only the Friday review pass proposes edits, and only to `strategy.md` — never `guardrails.md`.
3. **`guardrails.md` is human-only.** No routine ever edits it. It is the human's safety budget.
4. **Source of truth is Alpaca.** When `memory/portfolio.md` and `./scripts/alpaca.sh positions` disagree, Alpaca wins. Rewrite the file; do not trust the file.
5. **Paper unless `BULL_MODE=live`.** `scripts/alpaca.sh` enforces that `BULL_MODE` and `ALPACA_BASE_URL` agree. If they disagree, every API call exits 2. Flip them together via `./install.sh --enable-live`.
6. **No shorts, no margin, no leveraged ETFs.** Options are long-call-only when enabled in `guardrails.md`: no puts, spreads, or sell-to-open.
7. **No adding to an existing position.** If we already hold a ticker, preflight rejects another buy.
8. **Every routine ends with a commit to `main`.** The next cron run reads the committed state. Uncommitted work effectively never happened.

## Inputs

Before any action, the agent reads in this order:

1. `CLAUDE.md` (repo root) — project ground rules.
2. `memory/strategy.md` — thesis, signal rubric, exit rules.
3. `memory/guardrails.md` — hard caps.
4. `memory/portfolio.md` — current state, reconciled against `alpaca.sh positions`.
5. `memory/trade-log.md` — append-only history.
6. `memory/research-log.md` — append-only research + rejections.

## Tools

| Tool | Purpose |
|------|---------|
| `./scripts/alpaca.sh` | All Alpaca REST calls — `account`, `positions`, `quote`, `bars`, `asset`, `clock`, `orders`, `buy`, `sell`, `cancel-all`. JSON out, non-2xx fails. |
| `./scripts/grok.sh` | xAI Grok with Web Search + X Search tools. Real-time news + fintwit. Plain-text out. |
| `./scripts/notify.sh` | Email via Resend. Used by midday halts, EOD summary, and weekly review. |
| `./.claude/skills/bull/preflight-check.sh` | Hard guardrail. Mandatory before every order. |
| `./scripts/backtest.sh` | Offline exit-rule sanity check against historical bars. Used before going live, not in any cron. |

## Prompt fragments

- `prompts/research.md` — invoked by `routines/pre-market.md`. Builds today's watchlist.
- `prompts/decision.md` — invoked by `routines/market-open.md`. Turns the watchlist into orders.

## Standard flow inside a routine

```
1. Read inputs above.
2. Call the appropriate prompt fragment OR follow the routine's inlined procedure.
3. For each candidate order: preflight, then alpaca.sh, then trade-log append.
4. Rewrite memory/portfolio.md from Alpaca's authoritative state.
5. git add memory/*.md && git commit -m "<routine> <date>: <summary>" && git push origin main
```

## Failure handling

- If a `scripts/alpaca.sh` critical call (account, positions, buy, sell) returns non-2xx twice in a row, **stop the routine**, email an alert via `notify.sh`, and exit. Do not continue blind.
- If preflight rejects, log the reason (preflight already does this) and move to the next candidate. Never retry the same order.
- If a Grok call fails or returns nonsense, treat that research dimension as missing — score conservatively (cleanliness 0) or skip the candidate.
- If a commit fails (merge conflict, push rejection), email an alert and exit. The next cron will retry from a clean state.
