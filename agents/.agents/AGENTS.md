# Agents.md

## Ground rules

- Never commit raw secrets (e.g. `.env`) to version control.
- Be concise and token-efficient in reasoning, responses, and any generated text.
- When editing this file or other repository docs, match the existing markdown style: one logical line per paragraph or list item. Do not hard-wrap prose at a fixed column width.
- Invoke the `unslop` skill before any user-facing response or generated text; manual self-editing does not satisfy this. Where no skill mechanism exists, apply `skills/unslop/SKILL.md` directly. Binds every agent and subagent.
- Update all relevant context files with information uncovered during the session.
- If a discovery belongs in this global AGENTS.md rather than a task/repo-level file, request permission before editing it.

## Custom skills and agents

`~/.agents` is the canonical home for custom skills, agents, and commands. It is symlinked into opencode's scanned paths, so anything created or edited there shows up in opencode. Concretely:

- Put skills in `~/.agents/skills/<name>/SKILL.md`, not `~/.config/opencode/skills`.
- Put agents and commands under `~/.agents` as well.
- `~/.config/opencode/AGENTS.md` is itself a symlink to `~/.agents/AGENTS.md` (both resolve to the same file), so editing either path edits the same global agents file. Treat `~/.agents/AGENTS.md` as the source of truth.
- Do not create skills or agents directly under `~/.config/opencode`; use `~/.agents` so the symlink keeps opencode's directory in sync.

## Agent Orchestration

- For tasks involving subagent orchestration, read `docs/AGENT_ORCHESTRATION.md` before delegating work.
- The default entry point may be a lower-cost implementation-oriented agent.
- The entry-point agent should perform lightweight triage before committing to substantial work.
- Straightforward, well-understood tasks should be handled directly.
- Escalate to the Architect when the task requires consequential architectural judgment, substantial repository discovery, or decisions outside the agent's established scope.
- When escalating, provide the Architect with a concise context and escalation brief rather than requiring it to rediscover already-established facts.

## Git worktrees

- When about to branch in a non-exempt repository, use a Git worktree instead of checking the branch out in the canonical checkout. Read `docs/GIT_WORKTREES.md` for the full convention (procedure, branch naming, cleanup, and example layout).
- Use a worktree when a task is substantial enough to warrant its own branch. Calibration: "substantial" includes any change touching more than one file's logic, or any API/behavior change. Trivial edits (a one-line typo fix, an untracked scratch file, or anything you would not normally branch for) do not require a worktree.
- The dotfiles repository is exempt and may be edited directly; edits to this global `AGENTS.md` follow the "request permission before editing" rule in Ground rules. Other exempt repositories are listed in `docs/GIT_WORKTREES.md`.

## CSS layout patterns

- Read `docs/CSS_LAYOUT_PATTERNS.md` for common CSS gotchas discovered across sessions (height transitions, inline element limitations, scroll-driven animation pitfalls).
