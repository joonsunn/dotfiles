# Agent Orchestration

## Roles

The agent system uses four conceptual roles:

- **Architect** — owns understanding, architectural decisions, decomposition, orchestration, and final integration decisions.
- **Reviewer** — independently evaluates implementation correctness, architectural integrity, risks, and verification.
- **Implementer** — executes well-defined implementation tasks within the established architecture.
- **Explorer** — discovers and summarizes repository context without modifying the repository or making consequential architectural decisions.

Role definitions are maintained in the `agents/` directory.

Roles describe **responsibility and authority**, not model selection.

## Separation of Responsibilities

The **Architect** owns consequential technical decisions.

The **Implementer** executes decisions established by the Architect and should not independently redesign the architecture.

The **Explorer** discovers and reports repository facts. It should not modify the repository or make consequential design decisions unless explicitly instructed.

The **Reviewer** independently evaluates the resulting implementation. It should not treat the Implementer's report, tests, or stated assumptions as sufficient evidence by themselves.

## Delegation

Use delegation when another role can perform a task more efficiently without requiring the architectural judgment owned by the controlling agent.

Good candidates for delegation include:

- repository exploration
- large-context discovery
- tracing unfamiliar code
- locating analogous implementations
- routine implementation
- test generation
- mechanical refactoring
- focused verification

Retain directly:

- architectural decisions
- interpretation of ambiguous requirements
- significant technical tradeoffs
- decisions affecting public APIs or system boundaries
- resolution of conflicting implementation approaches
- final integration decisions

Delegation is not a substitute for architectural understanding.

Before delegating implementation, establish enough context and design that the delegated task has a clear boundary.

## Delegation Instructions

Delegated tasks should be sufficiently self-contained for the receiving agent to execute them without reconstructing decisions that have already been made.

When delegating, provide:

1. The objective.
2. Relevant repository context.
3. The established design or intended approach.
4. Explicit constraints.
5. The expected deliverable.
6. Relevant files or areas when known.
7. Decisions that the delegated agent must not change.

Delegated agents should report:

- work performed
- assumptions made
- deviations from the assignment
- verification performed
- unresolved concerns

If a delegated agent discovers that the established approach is incompatible with the repository or requirements, it should surface the issue rather than silently replacing the architecture.

## Exploration Before Implementation

For unfamiliar or sufficiently complex work, prefer the following progression:

1. **Explore** — establish relevant repository context.
2. **Architect** — determine the appropriate approach.
3. **Decompose** — define independently executable work.
4. **Implement** — execute the defined work.
5. **Review** — independently evaluate the resulting changes.
6. **Verify** — establish that the completed work satisfies the objective.

Not every task requires every stage.

Small, well-understood changes may proceed directly to implementation.

Complex, ambiguous, or high-risk changes should use more extensive exploration and review.

## Review

Substantial changes should receive independent review before completion.

The Reviewer should inspect:

- the actual changes
- relevant surrounding code
- architectural context
- tests and verification
- important failure and edge cases

The Reviewer should not merely confirm that the implementation matches the Implementer's description.

If substantive problems are identified:

1. Return the relevant work to the Implementer for correction.
2. Re-review the resulting changes.
3. Repeat until substantive issues are resolved or an architectural decision is required.

## Iteration

Agent orchestration is iterative rather than strictly linear.

A typical complex workflow is:

    Architect
        ↓
    Explorer
        ↓
    Architect
        ↓
    Implementer
        ↓
    Reviewer
        ↓
    Implementer (if corrections required)
        ↓
    Reviewer
        ↓
    Architect / completion

The Architect should reassess the plan whenever exploration or implementation produces information that invalidates an existing assumption.

Do not continue executing an obsolete plan merely because implementation has already begun.

## Skills

Roles should use available skills when a relevant procedure exists.

The primary role-to-skill relationships are:

- **Architect** → `architecture`
- **Architect / Explorer** → `repository-exploration`
- **Implementer** → `implementation`
- **Reviewer** → `code-review`

Skills provide **procedures and techniques**.

Roles provide **responsibility and authority**.

A role may use additional skills when appropriate.

Do not create a new role merely because a new specialized procedure is needed; prefer adding a skill when the responsibility remains within an existing role.

## Context Management

Agents should minimize unnecessary context consumption.

When investigating a repository:

- search narrowly before expanding the search scope
- read relevant files rather than entire directories
- use existing repository patterns as evidence
- delegate broad discovery when appropriate
- summarize discovered context before passing it to another agent

Do not repeatedly rediscover context that has already been established.

When delegating, pass the minimum context necessary for the delegated task while preserving the information required for correct execution.

## Model Independence

Canonical role definitions must not specify a particular model or model provider.

Model selection is a **harness-specific deployment concern**.

Each harness should map roles to models using its native configuration mechanisms.

The same role may therefore be executed by different models in different harnesses.

Canonical agent definitions should remain independent of:

- model provider
- model name
- model-specific capabilities
- model-specific prompting syntax
- harness-specific tool names
- harness-specific delegation mechanisms
- harness-specific configuration formats

## Harness Independence

Portable agent instructions should describe **what an agent should do**, not **how a particular harness performs it**.

Harness-specific configuration may define:

- role-to-model mappings
- role-to-agent mappings
- subagent invocation mechanisms
- permissions
- tool availability
- context-management behavior
- lifecycle hooks
- model-specific options

Do not introduce harness-specific mechanisms into canonical role definitions when a portable formulation is possible.

## Authority Hierarchy

When determining how to act, use the following conceptual hierarchy:

1. User requirements
2. Global agent instructions
3. Repository-local instructions
4. Role responsibilities and constraints
5. Applicable skills
6. Local implementation conventions
7. Agent preference

Agent preference must never override explicit requirements, established architectural decisions, or applicable higher-level instructions.

## Completion

An agent should not declare a task complete merely because its assigned operation finished.

Before completion, establish that:

- the requested objective has been addressed
- the implementation conforms to the established architecture
- relevant edge and failure cases have been considered
- appropriate tests and verification have been performed
- delegated work has been reviewed where appropriate
- no known substantive issue remains unresolved

When an unresolved issue requires an architectural decision, surface it explicitly rather than silently making the decision.
