---
name: sync-agent-role
description: Use when adding, renaming, or removing an agent role or subagent, or when a role definition changed enough to invalidate harness adapters. Syncs codex toml adapters, copilot agent adapters, and opencode.json entries with the canonical role in agents/.agents/agents/.
---

# Sync agent role

## Purpose

Keep every harness's view of an agent role identical to the canonical definition. The canonical role lives at `agents/.agents/agents/<role>.md` in the dotfiles repo. Harness-specific files only mirror it, never extend it.

## When to use

Run this skill when a role is added, renamed, or removed, or when an edit to a canonical role file touches anything an adapter mirrors: the `description` frontmatter, responsibility or authority, escalation or handoff targets, delegation relationships, sandbox or tool scope, or the skills the role uses. Cosmetic edits need no sync.

## Source of truth

Canonical roles carry only the portable minimum: `description` and `mode` frontmatter, plus sections describing responsibility and authority. They must not specify model or provider, harness tool names, delegation mechanisms, or config syntax. See the Portability section of `agents/.agents/docs/AGENT_ORCHESTRATION.md`. Create or edit the role there first, then propagate outward. Never create a role directly inside a harness package.

## Per-harness work

Paths below are repo paths. After `stow`, `AGENTS.md`, `skills/`, `docs/`, and (for opencode and claude) `agents/` resolve to `~/.agents/`.

### Codex: `codex/.codex/agents/<role>.toml`

One thin adapter per role with `name`, `description`, `sandbox_mode`, and `developer_instructions`. Mirror the canonical `description` verbatim. Omit `model` so the subagent inherits the parent session model. Set `sandbox_mode` to least privilege: `read-only` for discovery and evaluation roles (explorer, reviewer), `workspace-write` for roles that edit or run things (architect, implementer, tester). Point `developer_instructions` at the canonical file under `~/.agents/agents/<role>.md` plus each skill the role uses under `~/.agents/skills/<skill>/SKILL.md`, then add an inline fallback paragraph summarizing the role for when the canonical file cannot be read. Codex adapters use absolute `~/.agents` paths, so codex needs no `agents-ref` symlink. Leave `config.toml` `[agents]` limits (`max_threads`, `max_depth`) alone unless the new role changes nesting depth.

### Copilot: `copilot/.copilot/agents/<role>.agent.md`

One thin adapter per role. Frontmatter: `name`, `description` mirrored verbatim from canonical, `model`, `tools` scoped to least privilege, `agents` for downward delegation, `handoffs` with `send: false` for upward and lateral escalation. Body: one line identifying it as the Copilot adapter, a markdown link to the canonical definition (`[role](../agents-ref/<role>.md)`), a link per skill the role uses (`[skill](../skills/<skill>/SKILL.md)`), and an inline fallback paragraph. Confirm `agents-ref/` still symlinks to `agents/.agents/agents/` since these relative links depend on it.

### Opencode: `opencode/.config/opencode/opencode.json`

No adapter file. Opencode reads the canonical `agents/*.md` directly through its symlinked `agents/` dir. Add one entry under `agent` with the role's `model` and a distinct `color`. Keep `build` and `plan` disabled and leave `default_agent` as is unless the new role should become the entry point.

### Claude: nothing to do

Claude reads the canonical files through its symlinked `agents/`, `skills/`, `docs/`, and `CLAUDE.md`. A new or changed role propagates automatically.

## Delegation graph

A new role changes who may call whom, so update every place that enumerates relationships. Current shape: architect delegates to explorer, implementer, reviewer, and tester; implementer delegates to explorer and hands off to architect and reviewer; explorer, reviewer, and tester are leaves handing off to architect, plus implementer for reviewer and tester. For the new role, decide its tools, its downward `agents` list, its `handoffs`, its codex `sandbox_mode`, and whether architect or implementer gains it as a delegatee. Then update `agents/.agents/docs/AGENT_ORCHESTRATION.md` (Roles, Authority Boundaries, and Workflow) if the role adds or moves authority. Copilot `agents` and `handoffs` lists and codex `sandbox_mode` must agree with that document.

## Rename or remove

Rename means add the new adapter files and delete the old ones in the same change, plus updating every `agents` and `handoffs` list that named the old role. Removal means deleting adapters and scrubbing all references. Never leave an adapter pointing at a canonical file that no longer exists.

## Verify

Confirm the canonical `description` string appears verbatim in the codex toml and the copilot frontmatter. Confirm every skill the canonical role names has a matching link or path in both adapters. Confirm symlinks the adapters depend on (`skills/`, `docs/`, copilot `agents-ref/`) still resolve. Re-run `stow` for each touched package and check the harness picks up the role. This is a maintainer skill, so do not add it to the role-to-skill mapping in `AGENT_ORCHESTRATION.md`.
