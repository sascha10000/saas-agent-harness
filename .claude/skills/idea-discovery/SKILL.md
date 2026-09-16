---
name: idea-discovery
description: >
  Phase 2 of the saas-pipeline: research a domain, generate >=4 SaaS candidate ideas
  from mandated distinct perspectives, score them against the KPI driver tree, choose
  one, and validate it. Writes project/IDEA.md and saves research to project/research/.
---

# Idea Discovery

## Input
Domain/idea seed from STATE.md + the driver tree from `project/KPI.md` (required).
Respect `RESEARCH_DEPTH` from `.env` (quick | standard | deep; default standard).

## Procedure
1. **Domain research** — delegate, save each report under `project/research/`:
   - `ecc:market-research` for market shape, incumbents, pricing norms.
   - `ecc:competitive-platform-analysis` to scope and tier the competitor set.
   - `ecc:deep-research` only at RESEARCH_DEPTH=deep.
   Free sources only — paid data APIs are a money gate.
2. **Candidate generation** — at least 4 candidates covering at least 4 of these 5
   mandated perspectives (one candidate per perspective, no blending):
   - underserved niche (segment incumbents ignore)
   - better UX on an incumbent's solved problem
   - unbundling one feature into a focused product
   - pricing innovation (same job, different model)
   - distribution advantage (a channel we can win, e.g. SEO/programmatic)
   Each candidate must name who hurts, evidence from the research, and why users
   would *feel* a problem is solved.
3. **Scoring** — matrix per `templates/IDEA.md`: columns are KPI driver-tree nodes
   weighted toward the north star, plus effort and risk (inverted). State the weights;
   they must sum to 1.0.
4. **Choose** the top-weighted candidate. Ties break toward faster time-to-first-
   paying-user.
5. **Validate** the winner with `ecc:product-lens`. FAIL → choose the runner-up and
   re-validate; two FAILs → regenerate candidates once with the failure reasons as
   constraints.

## Output contract
- `project/IDEA.md` from `templates/IDEA.md`, fully populated.
- `project/research/*.md` — the saved reports (linked from IDEA.md).
- DECISIONS.md entry: chosen idea, losing candidates, KPI justification.
- STATE.md: phase 2 done; `Next action:` "Run marketing-assets and stack-decision in
  parallel." Set project name in Identity.

## Exit criteria
≥4 candidates from distinct perspectives, weighted scoring with stated weights,
one winner with product-lens PASS.
