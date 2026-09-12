# Notes on `copilot`` stow package

The contents of the `.copilot` folder is mostly symlinked from `dotfiles/.agents`.
The `agents/` folder holds thin `*.agent.md` adapters, one per role, and `agents-ref/` is a symlink to the canonical role definitions in `agents/.agents/agents/`.
Each adapter links its reference file with markdown link syntax, e.g. `[tester role](../agents-ref/tester.md)`, and links skills the same way, e.g. `[playwright skill](../skills/playwright/SKILL.md)`.
Frontmatter per adapter: `name`, `description`, `model` for agent to LLM delegation, `tools` scoped to the role with least privilege, `agents` for downward subagent delegation, and `handoffs` with `send: false` for upward and lateral escalation.
Architect delegates to all four roles via `agents`; implementer delegates to explorer and hands off to architect and reviewer; explorer, reviewer, and tester are leaves with `agents: []` and hand off to architect, plus implementer for reviewer and tester.
