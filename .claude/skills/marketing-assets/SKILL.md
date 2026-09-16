---
name: marketing-assets
description: >
  Phase 3a of the saas-pipeline (runs parallel to stack-decision): produce the
  marketing analysis and ready-to-publish assets for the chosen idea — positioning,
  landing page copy, SEO page plan, email sequence, social posts — as files under
  project/MARKETING/. Publishing them is a user action (external-send gate).
---

# Marketing Assets

## Input
`project/IDEA.md` (chosen idea + thesis) and `project/KPI.md` (the traffic/conversion
nodes these assets must serve).

## Procedure
1. **Brief** — compose a product brief from IDEA.md: product name, one-line
   description, specific audience, core problem, core benefit, tone, target channels,
   launch goal from KPI.md.
2. **Campaign** — run `/ecc:marketing-campaign <brief>` (full mode). Its ordering
   constraint is real: positioning is produced and locked BEFORE any copy. Direct all
   outputs into `project/MARKETING/`:
   - `positioning.md` (first, mandatory)
   - `landing-page.md`
   - `emails.md` (sequence)
   - `social.md` (launch posts)
3. **SEO** — with `ecc:seo` (+ seo-specialist agent for keyword→URL mapping), write
   `seo-plan.md`: target keywords, page/URL plan (programmatic pages if the domain
   suits), internal linking sketch, and which KPI node each page feeds.
4. **Verify files exist** — the campaign command's output location is not guaranteed;
   after each step confirm the file landed in `project/MARKETING/` and move/write it
   there if not.
5. Write `project/MARKETING/README.md`: "All assets are drafts. Publishing or sending
   anything here is an external-send gate — user action required."

## Output contract
- `project/MARKETING/{positioning,landing-page,seo-plan,emails,social,README}.md`
- DECISIONS.md entry: chosen positioning angle + channel priorities, citing the
  traffic/conversion KPI nodes.
- STATE.md: parallel track 3a done.

## Exit criteria
All six files exist and are non-empty; positioning.md was written before the copy files.
