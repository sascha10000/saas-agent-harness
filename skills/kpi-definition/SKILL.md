---
name: kpi-definition
description: >
  Phase 1 of the saas-pipeline: turn a founder goal (e.g. "maximum MRR", "most paying
  users") into a north-star KPI with a measurable driver tree, targets, and guardrail
  metrics, written to project/KPI.md. Also invokable standalone to revise KPIs after
  real launch data arrives.
---

# KPI Definition

## Input
The raw goal string from `project/STATE.md` (or given as argument). If it is ambiguous
between two plausible north stars, pick the one closest to revenue, log the choice in
DECISIONS.md — do not ask.

## Procedure
1. Normalize the goal to ONE north-star KPI: definition, unit, measurement window
   (e.g. "MRR: sum of active subscription amounts, EUR/month, measured monthly").
2. Build the driver tree top-down, 3-4 levels, every node measurable. Example shape
   (adapt to the actual goal, do not copy):
   MRR → paying users × ARPU → signups × free-to-paid conversion → traffic ×
   visitor-to-signup conversion.
3. For each node: definition, unit, and a data source that is **instrumentable inside
   the product itself** (DB table, server event, Stripe API) — this feeds the
   launch-kpi-loop instrumentation later. No node may depend on data we cannot collect.
4. Set 90-day targets per node: order-of-magnitude estimates, explicitly flagged as
   assumptions with the reasoning behind each.
5. Add 2-3 guardrail metrics (e.g. churn, refund rate, support load) that later
   decisions must not degrade.
6. Write `project/KPI.md` from `templates/KPI.md` — all six sections: North Star,
   Driver Tree (mermaid + table), Metric Definitions, Targets & Assumptions,
   Guardrails, Decision Rule.

## Output contract
- `project/KPI.md` (overwrite; history is in git)
- One DECISIONS.md entry: chosen north star + rejected interpretations.
- STATE.md: phase 1 done, `Next action:` "Invoke the idea-discovery skill."

## Exit criteria
All six sections present; every tree node has unit + in-product data source; at least
two guardrails defined.

## Revision mode (post-launch)
When invoked by launch-kpi-loop with real data: replace assumption-based targets with
data-derived ones, keep the tree structure unless the funnel proved different, and log
every changed target in DECISIONS.md with the observed number that motivated it.
