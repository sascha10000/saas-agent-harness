---
name: saas-pipeline
description: >
  Entry and resume point for the autonomous SaaS pipeline. Invoke as
  /saas-pipeline "<idea or domain> | KPI: <goal>" to start a new project, or bare
  /saas-pipeline to resume from project/STATE.md. Drives phases kpi → idea →
  (marketing ∥ stack) → mvp-build → launch. Use whenever the user asks to start,
  continue, or check the status of the SaaS project.
---

# SaaS Pipeline Orchestrator

## Startup protocol (ALWAYS first)

1. Read `project/STATE.md`.
   - **Missing + argument given:** instantiate `project/STATE.md` and
     `project/DECISIONS.md` from `templates/` (replace `{{…}}` placeholders; record the
     raw goal verbatim; today's date), set phase `1-kpi`, continue below.
   - **Missing + no argument:** ask the user for `"<domain or idea> | KPI: <goal>"` —
     the only allowed preference question in the pipeline.
   - **Present:** resume at `Next action` exactly as written. Completed phases (exit
     artifact exists + marked done) are never redone.
2. Read `project/KPI.md` if present — cite its driver-tree nodes in every decision.

## Phase table

| # | Phase | Entry | Action | Exit criterion |
|---|-------|-------|--------|----------------|
| 1 | kpi | goal recorded | invoke `kpi-definition` skill | KPI.md complete (6 sections) |
| 2 | idea | KPI.md exists | invoke `idea-discovery` skill | ≥4 scored candidates, one chosen, product-lens PASS |
| 3a | marketing | idea chosen | invoke `marketing-assets` skill (may run as background subagent) | all five MARKETING/ files exist |
| 3b | stack | idea chosen | invoke `stack-decision` skill | STACK.md written; `app/` passes `cargo check` |
| 4 | mvp-build | 3b done | fill `project/MVP-SPEC.md` from templates/MVP-SPEC.md using IDEA.md + STACK.md (+ positioning if 3a done); run `/ecc:orch-build-mvp project/MVP-SPEC.md` with env from `.env`; `/ecc:checkpoint create <slice>` after each passing slice | build report all slices passing + `ecc:verification-loop` green |
| 5 | launch | 3a + 4 done | invoke `launch-kpi-loop` skill | LAUNCH.md complete up to gates; BACKLOG.md seeded |

3a and 3b run concurrently. Phase 4 needs only 3b; phase 5 needs 3a and 4.

**Phase 4 fallback:** if `/ecc:orch-build-mvp` stalls on an internal prompt, drive
`/ecc:gan-build "<slice brief>" --skip-planner` per slice directly (see docs/pipeline.md).

## Autonomy contract (hard rules)

STOP for the user ONLY on: (a) money, (b) production deploy, (c) external send.
Everything else: decide, append to `project/DECISIONS.md` (per its entry format, citing
a KPI node), continue. Record gate hits under "Blockers awaiting user" in STATE.md,
then finish all non-blocked work before stopping. Internal gates of ecc commands
(slice-plan approval, commit gates) are auto-approved.

## State updates (non-negotiable)

After EVERY phase transition and before ending ANY session:
1. Update `project/STATE.md` (phase, status, Next action, blockers, session notes).
2. Append the phase's decisions to `project/DECISIONS.md`.
3. `/ecc:checkpoint create phase-<n>` at each phase exit.

STATE.md must always let a cold session resume without re-reading history.
