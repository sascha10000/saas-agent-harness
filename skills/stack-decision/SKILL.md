---
name: stack-decision
description: >
  Phase 3b of the saas-pipeline: resolve platform (web / desktop / mobile) and
  tech stack for the chosen idea. User-stated constraints (e.g. "use Python",
  "only TypeScript", "as a mobile app") are BINDING and override defaults;
  otherwise per-platform defaults apply (web: Rust+axum+Askama+SQLite; desktop:
  Tauri v2; mobile: Flutter). Writes project/STACK.md, produces a verified
  scaffold, and sets the eval mode for phase 4.
---

# Stack Decision

## Resolution hierarchy (strict order)

1. **User-mandated constraints** — from STATE.md Identity → Constraints (parsed
   by saas-pipeline from the goal or any later user statement). Binding, never
   argued with, no justification needed; log them in STACK.md as user-mandated
   and pick best-in-class tools *within* them.
2. **Platform default** — decided from the chosen idea: does the core job
   genuinely require a desktop or mobile app (offline-first, OS integration,
   device sensors, store distribution)? Otherwise **web (SSR)**. Consult the
   `architect` agent when unclear; decide and log, don't ask.
3. **Deviation triggers** — only after 1+2 fixed the default, deviations from it
   need logged justification (table in STACK.md), exactly as before.

## Per-platform defaults (from CLAUDE.md, table is normative)

- **Web:** Rust + axum + Askama (SSR) + SQLite/sqlx. Python mandate → FastAPI +
  Jinja2/HTMX. TypeScript mandate → Next.js (SSR). SPA only if rich client
  interactivity truly demands it.
- **Desktop:** Tauri v2 (Rust core + web UI). TypeScript mandate → Electron or
  Tauri with TS frontend. Other mandates → best-in-class within constraint, logged.
- **Mobile:** Flutter. TypeScript mandate → Expo / React Native. Platform-specific
  native (Swift/Kotlin) only if a single-OS product is explicitly wanted.
- **Invariants:** Stripe for payments; server-side pieces self-hosted via Docker;
  Postgres only when concurrency/scale justifies.
- **Companion API rule:** desktop/mobile products MUST plan a small server-side
  companion API (KPI events, subscriptions/licensing) — the KPI driver tree must
  stay instrumentable. Default companion stack = the web default (or the
  user-mandated language). Mobile: flag store billing rules (Apple/Google
  in-app-purchase policies vs Stripe) as a launch-phase consideration in STACK.md.

## Deviation triggers (unchanged in spirit)

- SSR → SPA only for genuinely rich client interactivity.
- SQLite → Postgres only if write concurrency/dataset/extensions exceed SQLite at
  MVP scale.
- Extra infrastructure (queue, cache, search) only if a feature slice cannot ship
  without it.

## Procedure

1. Read IDEA.md + KPI.md + STATE.md Constraints; walk the hierarchy above.
2. Write `project/STACK.md` from `templates/STACK.md`: platform, user-mandated
   constraints (verbatim quotes), resulting default, deviation table (or explicit
   "no deviations"), companion-API plan for non-web, each row citing a KPI node.
3. **Scaffold:**
   - Web + Rust default → `cp -R scaffold/ app/` (pre-built, known green).
   - Anything else → generate via the ecosystem's own init tool
     (`npm create next-app`, `flutter create`, `npm create tauri-app`,
     `fastapi` project layout, `npx create-expo-app`, …), then trim to minimum +
     add: health endpoint (or equivalent smoke hook), KPI event sink (client →
     companion API for apps), migration/setup baseline, Dockerfile/compose for
     server-side parts.
   - Verify it builds/checks with the ecosystem's native gate (`cargo check`,
     `tsc`/`next build`, `flutter analyze`, `pytest`/`uv run` smoke) and pre-warm
     the build cache for the phase-4 loop.
4. **Eval mode for phase 4** (record in `.env` + STACK.md):
   web → `GAN_EVAL_MODE=playwright`; desktop/mobile → `code-only` (native test
   suites + build gates; simulator/screenshot checks only where tooling exists).
   Adjust `GAN_DEV_SERVER_CMD` to the ecosystem (or the companion API for apps).
5. Record scaffold status; DECISIONS.md entry; STATE.md: 3b done,
   `Next action:` "Fill project/MVP-SPEC.md and start phase 4 (mvp-build)."

## Exit criteria

STACK.md complete (platform + constraints + defaults + deviations + eval mode);
scaffold exists and its native check gate passes.
