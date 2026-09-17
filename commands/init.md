---
description: Initialize (or update) a SaaS-harness project in the current directory — copies templates, Rust scaffold, docs, settings, and CLAUDE.md from the plugin
---

# /saas-harness:init [--update]

Bootstrap the current directory as a saas-harness project from the plugin's
bundled assets at `${CLAUDE_PLUGIN_ROOT}`.

## Fresh init (default)

Refuse if `project/STATE.md` already exists (that's a live project — suggest
`--update`). Otherwise copy from `${CLAUDE_PLUGIN_ROOT}` into the current
directory:

1. `templates/` → `./templates/` (state-file templates incl. COMPLIANCE/)
2. `scaffold/` → `./scaffold/` (compilable axum + Askama + sqlx starter)
3. `docs/` → `./docs/` (pipeline spec, autonomy contract, Rust build notes)
4. `CLAUDE.md` → `./CLAUDE.md` (the operating manual — note inside it that skills
   are plugin-provided, namespaced `saas-harness:<skill>`)
5. `.claude/settings.json` → `./.claude/settings.json` (pre-approved cargo/docker
   permissions so the build loop runs unprompted; merge, don't overwrite, if one
   exists)
6. `.env.example` → `./.env.example`; `.gitignore` → merge/append
7. `mkdir -p project` + `.gitkeep`; `git init` if not a repo

Then report: "Project initialized. Start with:
`/saas-harness:saas-pipeline \"<domain or idea> | KPI: <goal>\"`"

## --update (sync an existing project with a newer plugin version)

For each of `templates/`, `docs/`, `CLAUDE.md`, `.claude/settings.json`:
diff plugin version vs project version FIRST; apply only non-conflicting updates,
list conflicts for the user instead of overwriting (project files may carry
project-specific edits). NEVER touch `project/`, `app/`, `scaffold/` copies, or
`.env`. Summarize what changed. This is the answer to template drift.

## Notes

- All pipeline skills come from the plugin (`saas-harness:saas-pipeline`,
  `saas-harness:kpi-definition`, `saas-harness:idea-discovery`,
  `saas-harness:stack-decision`, `saas-harness:marketing-assets`,
  `saas-harness:launch-kpi-loop`, `saas-harness:compliance-docs`) — they are NOT
  copied into the project; updating the plugin updates them everywhere.
- Skills reference project-relative paths (`templates/`, `project/`, `scaffold/`)
  which exist after this init — that's why init must run before the pipeline.
