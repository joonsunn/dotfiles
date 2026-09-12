---
name: sync-skill
description: Use when adding a new skill or substantially changing a skill definition. Wires skill references across canonical roles, AGENT_ORCHESTRATION.md, and codex/copilot adapters so context stays consistent. Skills need no adapter files since skills/ is symlinked whole into every harness.
---

# Sync skill

## Purpose

Propagate a new or substantially changed skill to every place that references it. Skills differ from roles: each harness symlinks the whole `skills/` directory, so a new `agents/.agents/skills/<name>/SKILL.md` appears in every harness automatically with no per-skill adapter file. The work is updating the references that point at it. Create or edit the skill in the canonical location first, then propagate outward. Never create a skill inside a harness package.

## When to use

Run this skill when a skill is added, renamed, or removed, or when an edit touches anything a reference depends on: the skill name, the frontmatter `description` (which controls discovery), the procedure a role relies on, or which roles use the skill. Cosmetic edits need no sync.

## New skill checklist

Write the `SKILL.md` with `name` and `description` frontmatter following the existing convention of singular concept nouns. Phrase the `description` as "Use when ..." trigger conditions, since that text is what makes the skill discoverable. Then wire these references, in order.

1. Role-to-skill mapping in `agents/.agents/docs/AGENT_ORCHESTRATION.md`. Add the skill to each consuming role's row. Current mapping: architect to `architecture`, architect and explorer to `repository-exploration`, implementer to `implementation`, reviewer to `code-review`, tester to `headless-chrome` and `playwright`.
2. Consuming canonical roles in `agents/.agents/agents/<role>.md`. Name the skill in the role's Procedure section with its `skills/<name>/SKILL.md` path, mirroring how tester names both its skills.
3. Copilot adapters in `copilot/.copilot/agents/<role>.agent.md` for each consuming role. Add a markdown skill link (`[skill](../skills/<skill>/SKILL.md)`) alongside the existing ones.
4. Codex adapters in `codex/.codex/agents/<role>.toml` for each consuming role. Add the `~/.agents/skills/<skill>/SKILL.md` path to `developer_instructions`.
5. Fallback paragraphs. If an adapter's inline fallback summarizes behavior the skill defines, update it to match. A skill rename must update every link, path, and fallback naming the old skill in the same change.

## Changed skill

Check each reference from the checklist above and update the ones the edit invalidated. A new `description` means re-reading the role-to-skill mapping and any adapter text that paraphrases the trigger scope. A changed procedure means checking the consuming roles' Procedure sections and the adapter fallbacks for stale summaries. A skill that gains or loses consuming roles means adding or removing links and paths in those roles' adapters.

## Rename or remove

Rename means creating the new skill directory, deleting the old one, and updating every mapping entry, role Procedure section, adapter link, adapter path, and fallback in the same change. Removal additionally means deciding which skill, if any, covers the removed one's responsibility and pointing orphaned references there. Never leave a dangling `../skills/<old>/SKILL.md` link or `~/.agents/skills/<old>/SKILL.md` path.

## Verify

Search the whole repo for the skill name and confirm every hit is intentional: the canonical file, the mapping row, the consuming role files, and the adapter links and paths. Confirm no stale references to an old name remain. Confirm the frontmatter `description` reads as trigger conditions and does not overlap another skill's scope. Re-run `stow` for each touched package. This is a maintainer skill, so do not add it to the role-to-skill mapping in `AGENT_ORCHESTRATION.md`.
