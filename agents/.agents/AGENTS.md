# Agents.md

## Ground rules

- Never commit raw secrets (e.g. `.env`) to version control.
- Be concise and token-efficient in reasoning, responses, and any generated text.
- When editing this file or other repository docs, match the existing markdown style: one logical line per paragraph or list item. Do not hard-wrap prose at a fixed column width.
- Invoke the `unslop` skill before user-facing responses with descriptive prose; terse status confirmations (Done, Fixed, a bare result) are exempt. Manual self-editing does not satisfy this. Where no skill mechanism exists, apply `skills/unslop/SKILL.md` directly. Binds every agent and subagent.
- Update all relevant context files with information uncovered during the session.
- Always work in a git worktree, unless specifically instructed not to.
  - You may make changes directly to the `~/.agents` folder `main` branch when performing session maintenance

## General framework preferences

- Scripting language order of preference:
  1. TypeScript
  2. Golang
  3. JavaScript

- `pnpm` for JS/TS package manager
- `vite` for scaffolding frontend project

## Verification

- HTTP 200 does not prove a client-rendered app works; confirm rendering with screenshots or DOM markers.
- To screenshot non-default client state (e.g. a non-default theme), seed it with a throwaway Playwright spec (set localStorage, reload, screenshot) and delete the spec after.
- The Vite dev server does not resolve tsconfig paths on its own; add vite-tsconfig-paths even when the production build passes.
- Before adopting a new TypeScript or ESLint major, confirm the lint plugins support it.

## Custom skills and agents

`agents/.agents/` in the dotfiles repo is the source of truth all harnesses inherit from. Each harness package (e.g. `codex/.codex/`, `opencode/.config/opencode/`) holds relative symlinks back to it for `AGENTS.md`, `skills/`, `docs/`, and `agents/`, and `stow agents` plus `stow <harness>` links those into place on the machine (`~/.agents/`, `~/.codex/`, `~/.config/opencode/`, etc.). Concretely:

- Put skills in `agents/.agents/skills/<name>/SKILL.md`, not inside a harness package.
- Put shared agents, docs, and commands under `agents/.agents/` as well.
- To wire a new harness, replicate its expected config path in dotfiles, symlink each shared entry back to `agents/.agents/` with a relative link, then `stow` the package. See `agents/README.md` for the steps.
- Do not create skills or agents directly inside a harness package; edit the source of truth so every harness inherits the change. Harness-local files (e.g. `opencode.json`, `config.toml`) stay in the harness package.

## Agent Orchestration

- For tasks involving subagent orchestration, read `docs/AGENT_ORCHESTRATION.md` before delegating work.
- The default entry point may be a lower-cost implementation-oriented agent.
- The entry-point agent should perform lightweight triage before committing to substantial work.
- Straightforward, well-understood tasks should be handled directly.
- Escalate to the Architect when the task requires consequential architectural judgment, substantial repository discovery, or decisions outside the agent's established scope.
- When escalating, provide the Architect with a concise context and escalation brief rather than requiring it to rediscover already-established facts.

## Git worktrees

- When about to branch in a non-exempt repository, use a Git worktree instead of checking the branch out in the canonical checkout. Read `docs/GIT_WORKTREES.md` for the full convention (procedure, branch naming, cleanup, and example layout).

## CSS layout patterns

- Read `docs/CSS_LAYOUT_PATTERNS.md` for common CSS gotchas discovered across sessions (height transitions, inline element limitations, scroll-driven animation pitfalls).
