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
- Platform + stack per STACK.md (web SSR default; desktop/mobile per its Platform
  section); responsive/adaptive; accessible basics.
- UI slices: load the `frontend-design` and `frontend-ui-engineering` skills (if
  available in the session) before implementing frontend code; the evaluator's
  Design/UX score assumes that bar.
- All KPI events captured server-side (web) or via the companion API
  (desktop/mobile); no third-party analytics dependency by default.
- Server-side parts run via `docker compose up` for self-hosting; apps build via
  their ecosystem's release tooling.

## Evaluator notes
- Eval mode per STACK.md: web → playwright against `$GAN_DEV_SERVER_CMD`
  (poll `GET /health` until 200 before UI testing, timeout 180s — cold compiled
  builds are slow); desktop/mobile → code-only (native test suite + build gates;
  the companion API gets the /health-poll treatment).
- Stripe stays in test mode throughout the build (live keys are a money gate).
