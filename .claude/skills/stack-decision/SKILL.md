---
name: stack-decision
description: >
  Phase 3b of the saas-pipeline: confirm or justify deviations from the harness
  default stack (Rust + axum + Askama, SQLite via sqlx, Stripe, self-hosted Docker),
  write project/STACK.md, copy scaffold/ to app/, and verify it compiles.
---

# Stack Decision

## Principle
The default stack is a decision already made — this phase only checks whether THIS
product justifies deviating. It is not an open evaluation. "No deviations" is the
expected outcome for most products.

## Deviation triggers (the only valid reasons)
- **Frontend → SPA** only if the core product experience needs rich client-side
  interactivity that server-rendered Askama + a sprinkle of vanilla JS cannot deliver
  (e.g. collaborative real-time editing, canvas-heavy UI). A dynamic form or filter
  list is NOT a trigger.
- **SQLite → Postgres** only if expected write concurrency, dataset size, or required
  extensions exceed SQLite's envelope at MVP scale. "It might scale later" is NOT a
  trigger — the compose file documents the migration path.
- Anything else (queue, cache, search): only if a feature slice in IDEA.md cannot ship
  without it.

For any proposed deviation, consult the `architect` agent (read-only review), then
decide and log. Do not ask the user.

## Procedure
1. Read IDEA.md + KPI.md; walk the deviation triggers.
2. Write `project/STACK.md` from `templates/STACK.md` (deviation table or the explicit
   "no deviations" statement, each row citing a KPI node).
3. `cp -R scaffold/ app/`; copy `.env.example` → `.env` if absent.
4. Verify: `cargo check` in `app/`, then `cargo build` (pre-warms the target dir so
   the phase-4 eval loop doesn't hit cold-compile timeouts).
5. Record scaffold status in STACK.md; DECISIONS.md entry; STATE.md: 3b done,
   `Next action:` "Fill project/MVP-SPEC.md and start phase 4 (mvp-build)."

## Exit criteria
STACK.md written; `app/` exists and `cargo check` passes.
