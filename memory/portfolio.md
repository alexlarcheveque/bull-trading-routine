# portfolio.md
# Updated 2026-07-17 EOD by end-of-day routine.

## Account
- equity: 40973.86
- cash: 1461.86
- day_pnl_pct: -55.33

## Open positions
| ticker | instrument | qty | entry_price | entry_date | target_exit | unrealized_pnl_pct |
|--------|------------|-----|-------------|------------|-------------|--------------------|
| MRK260724C00130000 | call | 449 | 2.01 | 2026-07-17 | 2026-07-24 | -53.2 |

## Notes
2026-07-17 EOD: 0 exits. Time stop not due (target_exit 07-24). Expiry guard clear today — 07-24 expiry is 5 trading days out; guard MUST force option-sell by ~2026-07-22 (never ride into expiry). Option bid $0.94 vs $2.01 entry = -53.2%, inside ±100% stop/target. Thesis INTACT per Grok safety-net check: no negative Lipfendra news, MRK -1.4% ($127.42) is broad-market weakness (S&P ~-1% tech selloff), peak-sales ests ~$5B. Weekly cap clear (WTD ~-61% vs -100%). Day -55.33% is mark-to-market of the all-in 7-DTE ATM call on a -1.4% underlying move — expected gamma profile of FULL YOLO sizing. EOD email sent (Resend c265622e). ⚠️ CRITICAL for 07-20/07-21/07-22 routines: midday must watch the ±100% band; EOD 07-22 must execute the expiry-guard sell — an EOD cron miss there means riding a near-0-DTE call with ~96% of the account in premium. Operator items STILL pending: caffeinate fix uncommitted, EOD cron move to ~12:45 PDT.
2026-07-17 market-open: BUY 449x MRK 07-24 $130 calls @ $2.01 (premium $90,249, order e3e48485). Score 8 — FDA approval of Lipfendra, first oral PCSK9 inhibitor. Spot $129.26 at entry, strike 130 nearest at/above spot, 07-24 only expiry in 3-7 DTE window. UNH (also 8) was the fallback, not taken (1/1 daily cap).
