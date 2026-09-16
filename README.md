# SaaS Agent Harness

A reusable Claude Code template for building SaaS products near-autonomously,
driven by a KPI you define up front (e.g. "maximize MRR").

## What it does

Given a one-line goal, the harness drives a six-phase pipeline:

1. **KPI definition** — your goal becomes a measurable north-star KPI with a driver tree.
2. **Idea discovery** — web research, multiple candidate ideas from different perspectives,
   scored against the KPI, one chosen.
3. **Marketing** (parallel) — positioning, channels, and produced assets (landing page copy,
   SEO plan, emails, social posts) as files. Publishing stays manual.
4. **Stack decision** — Rust + Askama + SQLite + Stripe, self-hosted, by default;
   deviations only with logged justification.
5. **MVP build** — autonomous spec → generate → evaluate loop with quality gates.
6. **Launch & KPI loop** — launch checklist, KPI instrumentation, growth backlog.

Everything runs without asking, **except** three hard gates that always require you:
spending money, deploying to production, and sending/publishing anything external.

## Usage

```bash
# 1. Copy this template
cp -r saas-agent-harness my-new-saas && cd my-new-saas
rm -rf .git && git init -b main

# 2. Start Claude Code and kick off the pipeline
claude
> /saas-pipeline "jobs and listings space | KPI: maximize MRR"

# 3. Resume any time (state lives in project/STATE.md)
> /saas-pipeline
```

## Layout

| Path | Purpose |
|---|---|
| `CLAUDE.md` | Operating manual Claude loads every session: pipeline, autonomy contract |
| `.claude/skills/` | The six pipeline skills (orchestrator + one per phase) |
| `templates/` | Templates for the state files instantiated into `project/` |
| `project/` | Per-project state: STATE.md (resume point), KPI.md, IDEA.md, DECISIONS.md, … |
| `scaffold/` | Compilable axum + Askama + sqlx starter, copied to `app/` in phase 3b |
| `docs/` | Normative pipeline spec, autonomy contract, Rust build notes |

Requires the **ecc plugin** (v2.2.0+) for research, marketing, and build-loop skills;
the harness orchestrates, ecc does the heavy lifting.
