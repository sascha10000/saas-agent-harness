# Launch Checklist — {{project name}}

<!-- CONTRACT: Written by launch-kpi-loop (phase 5). Items marked [GATE: USER] are the
     hard autonomy gates — they MUST NOT be executed autonomously. Everything else is
     done autonomously and checked off. -->

## Pre-launch (autonomous)
- [ ] `ecc:verification-loop` green (build, lint, tests)
- [ ] All KPI driver-tree nodes instrumented and emitting (verify with test data)
- [ ] Stripe test-mode flow: subscribe → webhook → access granted → cancel
- [ ] Docker image builds; `docker compose up` serves the app locally
- [ ] Landing page reflects MARKETING/positioning.md
- [ ] Backup strategy for the database documented
- [ ] `project/COMPLIANCE/` regenerated at the launch commit (compliance-docs
  skill) and REVIEWED/SIGNED OFF by the user — drafts must match reality before
  they are handed to any DPO/customer/auditor

## Gates (user required)
- [ ] [GATE: USER — money] Domain purchase: {{proposed domain(s) + price}}
- [ ] [GATE: USER — money] Stripe live keys activated
- [ ] [GATE: USER — deploy] Production deploy to self-hosted server: {{exact commands}}
- [ ] [GATE: USER — external-send] Publish landing page / SEO pages
- [ ] [GATE: USER — external-send] Send launch emails / post on channels
  (assets ready in project/MARKETING/)

## Post-launch (autonomous, feeds the KPI loop)
- [ ] First KPI readout after {{N}} days → revise KPI.md targets against real data
- [ ] Seed BACKLOG.md from funnel bottlenecks observed in the data
- [ ] growth-log entry: launch learnings
