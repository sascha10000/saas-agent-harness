# MVP Specification — {{project name}}

<!-- CONTRACT: Filled by the saas-pipeline skill from IDEA.md + STACK.md + MARKETING
     positioning before phase 4, then fed to /ecc:orch-build-mvp. Keep slices thin
     and vertical: each slice is independently shippable and testable. -->

## Product thesis
{{One paragraph from IDEA.md "Chosen Idea".}}

## Positioning (from MARKETING/positioning.md)
{{Target audience, core problem, core benefit, tone — the build must reflect this,
especially landing page and onboarding.}}

## KPI instrumentation requirements (from KPI.md)
Every driver-tree node's data source must be measurable in the product:
- {{node}} → {{table/event/endpoint that captures it}}

## Feature slices (thin, vertical, ordered)
1. **{{Slice 1 — e.g. landing page + waitlist signup}}** — {{acceptance criteria}}
2. **{{Slice 2 — e.g. auth + core object CRUD}}** — {{…}}
3. **{{Slice 3 — e.g. Stripe subscription (test mode)}}** — {{…}}
4. …

## Non-functional requirements
- Server-rendered (Askama) unless STACK.md deviates; responsive; accessible basics.
- UI slices: load the `frontend-design` and `frontend-ui-engineering` skills (if
  available in the session) before implementing frontend code; the evaluator's
  Design/UX score assumes that bar.
- All KPI events captured server-side (no third-party analytics dependency by default).
- Runs via `docker compose up` for self-hosting.

## Evaluator notes (Rust specifics)
- Dev server: `$GAN_DEV_SERVER_CMD` (see .env). Cold `cargo build` is slow —
  **poll `GET /health` until 200 before any Playwright testing**, timeout 180s.
- Stripe stays in test mode throughout the build (live keys are a money gate).
