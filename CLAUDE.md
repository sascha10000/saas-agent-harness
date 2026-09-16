# SaaS Agent Harness — Operating Manual

This repository is a harness that builds a SaaS product near-autonomously, optimizing
for one north-star KPI defined at the start. You (Claude) are the operator. This file
is the contract; the skills in `.claude/skills/` implement it.

## Session startup protocol

1. Read `project/STATE.md`.
   - **Absent** → the pipeline has not started. If the user gave a goal, invoke the
     `saas-pipeline` skill to begin. Otherwise ask for `"<domain or idea> | KPI: <goal>"`
     (this is the only allowed preference question in the whole pipeline).
   - **Present** → resume exactly at its `Next action`. Never redo a phase whose exit
     artifact exists and is marked done.
2. Read `project/KPI.md` if it exists. Every non-trivial decision downstream must cite
   a node of its driver tree.

## Pipeline

| # | Phase | Skill / command | Exit artifact |
|---|-------|-----------------|---------------|
| 1 | kpi | `kpi-definition` | `project/KPI.md` |
| 2 | idea | `idea-discovery` | `project/IDEA.md` |
| 3a | marketing (parallel with 3b) | `marketing-assets` | `project/MARKETING/` |
| 3b | stack | `stack-decision` | `project/STACK.md` + `app/` scaffold |
| 4 | mvp-build | `/ecc:orch-build-mvp project/MVP-SPEC.md` | `gan-harness/build-report.md` |
| 5 | launch | `launch-kpi-loop` | `project/LAUNCH.md` + `project/BACKLOG.md` |

Normative details (entry/exit criteria, fallbacks): `docs/pipeline.md`.

## Autonomy contract (hard rules)

STOP and ask the user ONLY for:
1. **Money** — anything that costs money (domains, paid APIs, ads, live Stripe keys).
2. **Production deploy** — deploying to the user's server.
3. **External send** — sending emails, publishing posts/pages, any outward communication.

Everything else: decide, log it in `project/DECISIONS.md`, continue. Never pause for
preference questions. When a gate is hit, record it under "Blockers awaiting user" in
`STATE.md`, then continue with all non-blocked work before stopping.

The internal approval gates of `/ecc:orch-build-mvp` (slice-plan approval, commit gates)
are **auto-approved** under this harness — they are not money/deploy/external-send.
Full contract: `docs/autonomy-contract.md`.

## State files (persistence layer)

All state lives in `project/`, instantiated from `templates/` on first run:

- `STATE.md` — the single resume point. Update after every phase transition and before
  ending any session. A cold session must be able to continue from it alone.
- `KPI.md` — north star, driver tree, metric definitions, targets, guardrails, decision rule.
- `IDEA.md` — research summary, scored candidates, chosen idea + thesis.
- `DECISIONS.md` — append-only. Entry format:
  `## YYYY-MM-DD — <title>` then Decision / Alternatives considered / KPI justification
  (cite a driver-tree node) / Phase.
- `STACK.md`, `MARKETING/`, `MVP-SPEC.md`, `LAUNCH.md`, `BACKLOG.md` — per-phase artifacts.
- `research/` — saved research reports from phase 2.

## Default tech stack (deviate only with logged justification)

Rust + axum + Askama (server-rendered) · SQLite via sqlx (Postgres only if concurrency/
scale justifies) · Stripe · self-hosted via Docker. SPA framework only if the product
genuinely needs rich client interactivity beyond Askama. See `docs/rust-build-notes.md`.

## Research budget

`RESEARCH_DEPTH` in `.env` (quick | standard | deep, default standard) bounds how much
web research phases 2-3 perform. Prefer free sources; paid data APIs are a money gate.

## Language

Everything — code, docs, produced assets, decision logs — in English.
