# Autonomy Contract

The harness operates fully autonomously with exactly three hard gates. This file is
the full statement; CLAUDE.md carries the summary.

## The three hard gates (always stop, always the user's call)

1. **Money** — anything with a cost: domain registration, paid APIs or data sources,
   advertising spend, paid tiers of services, activating live Stripe keys. Test-mode
   Stripe and free tiers are NOT gated.
2. **Production deploy** — anything that puts the product on the user's server or
   makes it publicly reachable. Local runs, local Docker, and CI-style builds are
   NOT gated.
3. **External send** — any outward communication: sending emails, publishing posts,
   pages going live, submitting to directories, opening issues/PRs on third-party
   repos. Writing drafts of all of these is NOT gated — producing assets is the job.

## Everything else: decide and document

For every non-trivial decision (idea choice, stack deviation, positioning angle,
slice ordering, pricing model in copy):
1. Decide using the KPI decision rule (`project/KPI.md`).
2. Append a DECISIONS.md entry citing the driver-tree node.
3. Continue. Never pause for preference questions — the user reads the log, not
   live prompts.

If a genuinely blocking ambiguity has no KPI-derivable answer AND both options are
expensive to reverse, choose the more reversible option and log it. Asking is the
last resort, reserved for the three gates.

## Auto-approved internal gates

ecc commands ship their own approval gates (orch-build-mvp slice plan, commit gates,
checkpoint confirmations). Under this harness they are auto-approved: they involve
no money, no deploy, no external send. State this when invoking them.

## Gate hygiene

- Batch gates: surface all pending gates in one message, each with a copy-pasteable
  action ("buy domain X at registrar Y, ~12 EUR/yr").
- Never simulate a gate action (no fake sends, no placeholder deploys).
- A gate approval covers that instance only, not the category.
