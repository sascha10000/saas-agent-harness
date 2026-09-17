---
name: compliance-docs
description: >
  Generate and maintain GDPR/compliance documentation derived from the actual
  codebase: data map, Art. 30 record of processing (RoPA), TOMs, subprocessor
  list, retention schedule, DSAR playbook, and a security-questionnaire answer
  sheet under project/COMPLIANCE/. First generated after stack-decision; MUST be
  refreshed at every mvp-build slice exit that touches data, and finalized in the
  launch phase. Also invokable standalone when a customer/DPO/auditor request
  arrives.
---

# Compliance Docs (derived from code, not asserted)

## Principle
Every claim in these documents must be **derivable from the repository** —
migrations, handlers, config, Docker/compose files — or explicitly marked
`[ASSUMPTION — verify]`. Never invent controls that don't exist in code; a
missing control is documented as a gap with a backlog item, which is itself
credible audit posture. All documents carry the standard header:

> Status: DRAFT derived from code at commit `<sha>` on `<date>`. Requires review
> and sign-off by the controller. This is documentation, not legal advice.

## Inputs
`app/migrations/` (what data exists), `app/src/` (how it flows: handlers,
auth, storage, external calls), `docker-compose.yml`/Dockerfile (where it runs),
`.env.example` (which third parties), `project/STACK.md`, `project/KPI.md`
(events/metrics collected), `project/LAUNCH.md` (backup strategy).

## Documents (from templates/COMPLIANCE/, written to project/COMPLIANCE/)
1. **DATA-MAP.md** — data-flow documentation: every personal-data category
   (walk the migrations table by table, column by column), where it enters
   (form/upload/webhook), where it's stored (table/disk path), who can read it
   (authz scope), where it leaves (exports, third-party calls), encryption/
   hashing state. Mermaid flow diagram. THE document for "Datenfluss" requests.
2. **ROPA.md** — Art. 30 GDPR record of processing activities: one entry per
   processing purpose (accounts, product data, payments, KPI telemetry, backups)
   with legal basis, categories of data subjects/data, recipients, transfers,
   retention, TOM reference. Note controller-vs-processor role per activity —
   B2B products storing customers' third-party data (e.g. their invoices) make
   the customer the controller and the product a processor → a DPA (AVV) with
   customers is required; flag it.
3. **TOMS.md** — Art. 32 technical & organisational measures, each mapped to
   its implementation evidence (file/line or config), not aspirational: access
   control, encryption/hashing, integrity (audit logs), availability (backups),
   resilience, testing practice. Gaps listed honestly with backlog refs.
4. **VENDORS.md** — subprocessor/vendor list: name, purpose, data shared,
   region, DPA status `[USER ACTION]`, link to their terms.
5. **RETENTION.md** — per data category: retention period, legal basis
   (e.g. GoBD 8-10y vs session 30d), deletion mechanism (or documented absence),
   what happens on account termination.
6. **DSAR-PLAYBOOK.md** — Betroffenenrechte handling: how to execute access/
   export/rectification/deletion/objection requests with the ACTUAL tools
   (SQL queries, file paths), the 1-month deadline, identity verification, and
   conflicts (e.g. deletion vs statutory retention — document the precedence).
7. **QUESTIONNAIRE.md** — reusable answer sheet for customer security
   questionnaires (hosting, encryption, auth, backups, incident response,
   subprocessors, certifications held/not held). Honest "No/Not yet + roadmap"
   answers where applicable — never claim SOC 2/ISO certification that doesn't
   exist; state "documentation aligned with, not certified against".

## Language
Documents in the product's market language if authorities/customers there expect
it (log the language decision in DECISIONS.md); QUESTIONNAIRE.md additionally in
English (international customers).

## Refresh contract (drift is the failure mode)
- Slice exit in phase 4 that adds/changes tables, endpoints, vendors, or data
  flows → regenerate affected sections same session; the build loop's evaluator
  may treat stale COMPLIANCE docs as a finding.
- Record the source commit sha in each doc header; a doc whose sha lags the
  migrations' last change is stale by definition.
- LAUNCH.md gets a pre-launch item: "COMPLIANCE/ current at launch commit +
  reviewed by user `[GATE-adjacent: user sign-off]`".

## Output contract
- project/COMPLIANCE/*.md (all seven), DECISIONS.md entry, STATE.md note.
- Anything requiring user action (sign DPAs, appoint DPO if thresholds met,
  fill Impressum/Datenschutz specifics) → listed in LAUNCH.md, not silently
  assumed.

## Hard limits (state them, don't soften them)
These documents make audits and inquiries CHEAP; they do not make them
unnecessary. SOC 2 / ISO 27001 require external auditors; GDPR accountability
requires the docs to match reality and be signed off by the controller. The
skill's job is that they always match the code — sign-off stays human.
