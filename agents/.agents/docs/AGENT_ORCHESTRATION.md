# Agent Orchestration

## Roles

Four conceptual roles; definitions live in `agents/` and describe **responsibility and authority**, not model selection.

- **Architect** — owns understanding, architectural decisions, decomposition, orchestration, and final integration.
- **Reviewer** — independently evaluates correctness, architectural integrity, risks, and verification.
- **Implementer** — executes well-defined tasks within the established architecture.
- **Explorer** — discovers and reports repository context without modifying the repo or making consequential design decisions.

## Authority Boundaries

- The **Architect** owns consequential technical decisions.
- The **Implementer** executes established decisions; it must not independently redesign the architecture.
- The **Explorer** discovers and reports; it must not modify the repository or make consequential design decisions unless explicitly instructed.
- The **Reviewer** evaluates independently; it must not treat the Implementer's report, tests, or stated assumptions as sufficient evidence.

## Delegation

Delegate when another role can act without the controlling agent's architectural judgment: repository exploration, tracing unfamiliar code, locating analogous implementations, routine implementation, test generation, mechanical refactoring, focused verification.

Retain directly: architectural decisions, ambiguous-requirement interpretation, significant tradeoffs, public-API or boundary changes, conflicting-approach resolution, final integration.

Before delegating, establish enough context and design that the task has a clear boundary. Delegation is not a substitute for architectural understanding.

When delegating, provide: objective, relevant context, established approach, explicit constraints, expected deliverable, relevant files, and decisions the agent must not change. Delegated agents report: work performed, assumptions, deviations, verification, unresolved concerns. If the established approach is incompatible with the repository, surface it rather than silently replacing the architecture.

## Workflow

For unfamiliar or complex work, prefer: Explore → Architect → Decompose → Implement → Review → Verify. Small, well-understood changes may go straight to implementation; complex or high-risk work warrants more exploration and review.

Orchestration is iterative, not linear. A typical complex flow loops Architect ↔ Explorer ↔ Implementer ↔ Reviewer until substantive issues resolve or an architectural decision is required. The Architect reassesses the plan whenever new information invalidates an assumption; do not continue an obsolete plan merely because implementation started.

Substantial changes should receive independent review: inspect the actual changes, surrounding code, architectural context, tests, and important edge and failure cases. If problems are found, return work to the Implementer and re-review; repeat until resolved or an architectural decision is needed.

## Skills

Roles use available skills for procedure. Skills are plain markdown under `skills/`, harness-independent content, not opencode-specific runtime objects; each harness must make the referenced `SKILL.md` available to the role agent. Reference skills by name and path.

Role-to-skill mapping:

- Architect → `architecture`
- Architect / Explorer → `repository-exploration`
- Implementer → `implementation`
- Reviewer → `code-review`

Skills provide procedures; roles provide responsibility and authority. Prefer adding a skill over a new role when the responsibility already fits an existing role.

## Context Management

Minimize context consumption: search narrowly before widening, read relevant files not whole directories, use existing patterns as evidence, delegate broad discovery, summarize discovered context before passing it on, and do not rediscover context already established. Pass the minimum context a delegated task needs while preserving what correct execution requires.

## Portability

Canonical definitions are harness-independent: describe what an agent should do, not how a specific harness performs it. They must not specify model or provider, model-specific capabilities or prompting syntax, harness-specific tool names, delegation mechanisms, or configuration formats. Model and role-to-agent selection are harness-specific deployment concerns; each harness maps roles via its native config and may define invocation, permissions, tools, and hooks.

## Authority Hierarchy

When deciding how to act, precedence is:

1. User requirements
2. Global agent instructions
3. Repository-local instructions
4. Role responsibilities and constraints
5. Applicable skills
6. Local implementation conventions
7. Agent preference (never overrides higher levels)

## Completion

Do not declare done merely because an assigned operation finished. Before completion, confirm: the objective is addressed; the result conforms to the established architecture; relevant edge and failure cases were considered; appropriate tests and verification ran; delegated work was reviewed where appropriate; and no known substantive issue remains. Surface any unresolved issue that needs an architectural decision rather than deciding it silently.
