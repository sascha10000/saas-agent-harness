# Stack Decision

<!-- CONTRACT: Written by the stack-decision skill (phase 3b). The default stack is
     fixed; this file records only deviations and their justification. "No deviation"
     is a valid, logged outcome. -->

## Default stack (harness-wide)
Rust + axum + Askama (server-rendered) · SQLite via sqlx · Stripe · self-hosted (Docker).
SPA framework only if the product genuinely needs rich client interactivity.
Postgres only if concurrency/scale justifies it.

## Deviations
| Component | Default | Chosen | Justification | KPI impact (cite node) |
|-----------|---------|--------|---------------|------------------------|
| {{frontend}} | Askama SSR | {{Askama SSR / SPA:…}} | {{…}} | {{…}} |
| {{database}} | SQLite | {{SQLite / Postgres}} | {{…}} | {{…}} |

{{If no deviations: "No deviations — default stack adopted as-is." + one sentence why
the default suffices for this product.}}

## Scaffold status
- Copied `scaffold/` → `app/`: {{date}}
- `cargo check`: {{pass/fail}}
- `cargo build` (pre-warm for eval loop): {{pass/fail}}
