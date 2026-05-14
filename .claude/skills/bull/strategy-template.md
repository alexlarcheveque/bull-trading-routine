# strategy-template.md
# Reference template for forking your own edge. Copy to memory/strategy.md and
# rewrite the Thesis + scoring rubric. Keep the structure — the routines and
# decision.md prompt are wired to these section names.

## Thesis
<One paragraph. Plain English. What inefficiency are you capturing, on what
horizon, in what universe?>

## Universe
- <market cap floor>
- <volume floor>
- <listing constraints>
- Excluded: <list>

## What counts as a "tradeable signal"
A candidate qualifies only if it is all of:
1. <criterion 1>
2. <criterion 2>
3. <criterion 3>

Things that do NOT qualify, even if loud:
- <anti-pattern 1>
- <anti-pattern 2>

## Signal scoring (research routine ranks 0–10)
- <dimension 1> (0–N): <how to score>
- <dimension 2> (0–N): <how to score>
- ...
Threshold to trade: score >= <N>. If nothing qualifies, do not trade.

## Entry rules
- <when to enter>
- <order type>
- <position size>
- <pace limits>

## Exit rules
1. Profit target hit: +<X>% → sell.
2. Stop loss hit: -<Y>% → sell. No averaging down.
3. Thesis broken (new contradicting news) → sell next bar.
4. Time stop: <N> days from entry → sell regardless of P&L.

## Journaling
What `memory/trade-log.md` tracks and what the weekly review uses to grade the
edge. Spell out the metric ("best 14-day returns", "Sharpe", "win rate × avg R")
so the review routine can compute it consistently.

# See memory/strategy.md for the shipped reference implementation
# (news-driven, 14-day hold, +12% / -7% / 14d time stop).
