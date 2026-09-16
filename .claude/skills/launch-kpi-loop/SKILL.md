---
name: launch-kpi-loop
description: >
  Phase 5 of the saas-pipeline: prepare launch (checklist with hard user gates),
  verify KPI instrumentation in the product, seed the growth backlog, and run the
  post-launch KPI feedback loop that revises targets against real data.
---

# Launch & KPI Loop

## Entry
Phase 4 complete (build report passing, `ecc:verification-loop` green) and marketing
assets present.

## Procedure — launch preparation (autonomous)
1. Write `project/LAUNCH.md` from `templates/LAUNCH.md`.
2. Work through every **Pre-launch (autonomous)** item; check off with evidence
   (command output, test result). Key item: every KPI.md driver-tree node emits data —
   verify with test fixtures end-to-end (e.g. test signup increments the signups
   source).
3. Fill the **Gates** section with concrete, copy-pasteable detail: proposed domains
   with prices, the exact deploy commands for the user's server, which MARKETING/
   files to publish where. Record all gates as blockers in STATE.md.
4. Seed `project/BACKLOG.md` from `templates/BACKLOG.md`: growth/iteration items,
   each tagged with a KPI node, sorted by expected impact.
5. STOP — the gates themselves are user actions. Everything above must be finished
   before stopping.

## Procedure — KPI feedback loop (each post-launch session)
1. Read the KPI data sources (DB queries, Stripe test/live data, request logs);
   produce a short KPI readout vs. targets in STATE.md session notes.
2. Identify the funnel bottleneck (the driver-tree node furthest below target).
3. Re-invoke `kpi-definition` in revision mode to replace assumption targets with
   data-derived ones.
4. Reprioritize BACKLOG.md toward the bottleneck node; move completed items to Done
   with predicted vs. measured impact.
5. Write an `ecc:growth-log` entry for any surprising result (failures first).
6. Execute the top backlog item if it needs no gate; otherwise queue it as a blocker.

## Exit criteria (phase 5 "done", loop continues indefinitely)
LAUNCH.md pre-launch items all checked; gates filled in and listed as blockers;
BACKLOG.md seeded with ≥5 KPI-tagged items.
