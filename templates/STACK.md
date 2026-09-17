# Stack Decision

<!-- CONTRACT: Written by the stack-decision skill (phase 3b). The default stack is
     fixed; this file records only deviations and their justification. "No deviation"
     is a valid, logged outcome. -->

## Platform
- **Platform:** {{web (default) | desktop | mobile}} — {{one-sentence rationale
  from the idea; web needs none}}
- **Companion API (non-web only):** {{stack + scope: KPI events, subscriptions/
  licensing | n/a for web}}

## User-mandated constraints (binding, no justification required)
{{none | verbatim quotes from STATE.md Constraints, e.g. "only TypeScript" —
resulting stack choices below are best-in-class WITHIN these}}

## Resulting default (from CLAUDE.md platform/stack table)
{{e.g. web default: Rust + axum + Askama (SSR) · SQLite via sqlx · Stripe ·
self-hosted Docker — or the constraint-mapped equivalent}}

## Deviations
| Component | Default | Chosen | Justification | KPI impact (cite node) |
|-----------|---------|--------|---------------|------------------------|
| {{frontend}} | Askama SSR | {{Askama SSR / SPA:…}} | {{…}} | {{…}} |
| {{database}} | SQLite | {{SQLite / Postgres}} | {{…}} | {{…}} |

{{If no deviations: "No deviations — default stack adopted as-is." + one sentence why
the default suffices for this product.}}

## Scaffold status
- Scaffold: {{copied scaffold/ → app/ (web-Rust default) | generated via {{init
  tool}} → app/}}: {{date}}
- Ecosystem check gate ({{cargo check | tsc/next build | flutter analyze | …}}):
  {{pass/fail}}
- Build cache pre-warmed for eval loop: {{pass/fail}}
- Phase-4 eval mode: {{playwright (web) | code-only (desktop/mobile)}}
