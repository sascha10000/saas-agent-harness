# Rust Build Notes

Conventions for the scaffold and the phase-4 build loop.

## Stack rationale

- **axum** (not actix-web): first-class tokio/tower ecosystem, simpler extractor
  model — fewer macro-heavy patterns for generated code to get wrong — and clean
  pairing with sqlx and tower-http.
- **Askama**: templates compile into the binary; a template error is a compile error,
  which the build loop catches for free. No integration crate is used — handlers
  render to `String` and return `Html<String>` (version-stable across askama releases).
- **sqlx + SQLite**: `sqlx::migrate!` embeds `migrations/`; the DB file lives in
  `data/` (volume-mounted in Docker). Postgres path documented in docker-compose.yml.
- **events table**: the KPI instrumentation sink from day one. Phase-4 slices must
  write KPI events server-side (see templates/MVP-SPEC.md).

## Build loop configuration (phase 4)

From `.env` (see `.env.example`):

| Var | Value | Why |
|-----|-------|-----|
| GAN_DEV_SERVER_CMD | `cargo watch -q -x run` | rebuild-on-change during generator iterations; if cargo-watch is unavailable, use `cargo run` (free install: `cargo install cargo-watch`) |
| GAN_DEV_SERVER_PORT | 8080 | matches scaffold PORT |
| GAN_EVAL_MODE | playwright | server-rendered pages test fine via Playwright |
| GAN_PASS_THRESHOLD | 7.5 | quality bar per slice |
| GAN_MAX_ITERATIONS | 12 | bounded loop |

**Cold-compile rule:** Rust cold builds are slow compared to JS dev servers. The
evaluator must poll `GET /health` until HTTP 200 (timeout 180s) before any UI
testing — this instruction lives in templates/MVP-SPEC.md and must survive into
gan-harness/spec.md. The stack-decision phase pre-warms `target/` with a full
`cargo build` so iteration builds are incremental.

## Verification gates

- `cargo check` — fast structural gate, run after every generator iteration.
- `cargo clippy -- -D warnings` + `cargo fmt --check` + `cargo test` — the
  `ecc:verification-loop` set, required green at slice exit and phase exit.

## Self-hosting

`docker compose up -d --build` on the user's server (deploy itself is a gate).
SQLite file persists via the `./data` volume; back it up with a simple
`sqlite3 data/app.sqlite ".backup ..."` cron — documented in LAUNCH.md.
