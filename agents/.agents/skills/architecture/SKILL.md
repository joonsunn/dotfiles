---
name: architecture
description: Turn a software requirement into a disciplined, repository-fitting implementation approach. Use when introducing a feature, changing APIs or interfaces, modifying architectural boundaries, or decomposing complex implementation work.
---

# Architecture

## Purpose

Provide a disciplined method for turning a software requirement into an implementation approach that fits the existing repository.

## When to Use

Use this skill when:

* introducing a new feature
* changing system behavior across multiple components
* changing APIs or interfaces
* introducing a new abstraction
* modifying architectural boundaries
* making changes whose consequences are not immediately obvious
* decomposing a complex implementation task

For trivial, localized changes, do not over-architect.

## Procedure

### 1. Establish the Objective

Identify:

* the desired behavior
* the current behavior
* explicit requirements
* implicit constraints
* compatibility requirements
* non-functional requirements

Separate requirements from assumptions.

If an important requirement is ambiguous, resolve the ambiguity before committing to a consequential design.

### 2. Understand the Existing System

Before designing something new, determine:

* where the relevant behavior currently lives
* which components participate
* how data flows through them
* which abstractions already exist
* which patterns similar features use
* where tests for the behavior live
* which configuration or external dependencies are involved

Prefer repository evidence over assumptions.

Use the repository-exploration skill when substantial discovery is required.

### 3. Identify Constraints

Consider:

* public APIs
* backwards compatibility
* architectural boundaries
* dependency direction
* persistence and data formats
* concurrency
* error handling
* security boundaries
* performance requirements
* deployment constraints
* testing requirements

### 4. Generate Candidate Approaches

For non-trivial changes, consider multiple viable approaches.

For each approach, evaluate:

* implementation complexity
* consistency with existing architecture
* maintainability
* compatibility
* failure modes
* testing complexity
* operational consequences

Do not enumerate alternatives merely for completeness. Compare alternatives when the choice has meaningful consequences.

### 5. Select the Approach

Prefer the simplest approach that:

* satisfies the requirements
* fits existing architecture
* preserves appropriate compatibility
* minimizes unnecessary new concepts
* can be adequately tested

Avoid speculative flexibility.

Avoid introducing abstractions solely because they might be useful later.

### 6. Define the Implementation Boundary

Break the chosen approach into concrete units of work.

For each unit, identify:

* target files or components
* intended behavior
* relevant existing patterns
* dependencies on other work
* constraints that must not be violated
* expected tests or verification

A delegated implementation task should be specific enough that the implementer does not need to rediscover the architecture.

### 7. Validate the Design

Before implementation, check:

* Does the design actually satisfy the original objective?
* Does it fit existing architectural boundaries?
* Does it introduce unnecessary complexity?
* Does it create duplicated mechanisms?
* Does it preserve required compatibility?
* Are failure paths understood?
* Can the behavior be tested?
* Are there hidden dependencies or integration points?

## Design Principles

### Prefer Existing Patterns

If the repository already solves a similar problem, prefer extending that solution over introducing a new mechanism.

### Minimize Architectural Surface Area

Every new abstraction creates maintenance cost.

Introduce a new abstraction only when it provides a concrete benefit.

### Preserve Boundaries

Do not solve a local problem by weakening architectural boundaries elsewhere.

### Separate Policy From Mechanism

Keep business or architectural decisions separate from implementation details where the existing architecture supports that separation.

### Optimize for Comprehension

Prefer designs that future maintainers can understand from the repository itself.

## Output

When communicating an architectural decision, provide:

1. Objective
2. Relevant existing architecture
3. Constraints
4. Chosen approach
5. Important alternatives considered
6. Implementation decomposition
7. Verification strategy
8. Remaining risks or uncertainties

Do not produce lengthy design documents for trivial changes.

## Escalation Context

When architectural work originates from an escalation, begin with the
provided escalation brief.

Validate consequential claims against the repository, but avoid repeating
discovery unnecessarily.

Focus investigation on resolving the specific architectural uncertainty that
caused escalation.

Return an actionable architectural decision and implementation decomposition
to the requesting agent.
