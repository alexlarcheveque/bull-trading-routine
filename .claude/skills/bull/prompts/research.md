# research.md
# Prompt fragment for the Grok (xAI) real-time news research step.

Call `./scripts/grok.sh "<query>"` to pull live, sourced news for the symbols
on today's watchlist. Use it before every entry decision.

Suggested queries:
- "What material news has hit <TICKER> in the last 24 hours? Cite sources."
- "Pre-market movers <YYYY-MM-DD>: tickers, % change, catalyst."
- "Macro events today (CPI, FOMC, earnings) that could move SPY."

Pass the returned summary into the decision prompt verbatim — do not paraphrase
away the source citations.
