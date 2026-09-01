---
name: implementation
description: Implement a well-defined change with the smallest coherent modification while preserving repository conventions. Use when given a concrete task with a clear approach and known target files.
---

# Implementation

## Purpose

Provide a disciplined method for implementing a well-defined change while minimizing unnecessary modifications and preserving repository conventions.

## Procedure

### 1. Understand the Assignment

Before editing, establish:

* the desired behavior
* the architectural approach
* the files/components involved
* explicit constraints
* expected verification

If the assignment leaves a consequential design decision unresolved, ask the delegating agent rather than silently choosing an architecture.

A common pitfall: when adding a boolean field with a "default", clarify whether the default applies to the **schema** (the value filled in when the key is omitted) or to the **runtime behavior** (what happens when the key is absent). These diverge — `z.boolean().default(true)` makes omission equivalent to `true`, while `z.boolean().optional()` leaves omission as `undefined`. The distinction between "fail-open" (omitted = allow) and "fail-closed" (omitted = deny) is a design decision, not an implementation detail.

### 2. Inspect Before Editing

Read:

* the target implementation
* relevant interfaces
* nearby implementations
* related tests
* configuration or integration points when applicable

Do not assume that a filename or symbol fully describes its behavior.

### 3. Identify Existing Patterns

Determine how the repository handles:

* similar behavior
* errors
* validation
* dependencies
* state
* testing
* configuration

Follow established conventions unless the task explicitly requires changing them.

### 4. Implement the Smallest Complete Change

Make the minimum coherent set of changes required to satisfy the assignment.

Avoid:

* unrelated refactoring
* speculative abstractions
* dependency additions without need
* formatting unrelated files
* changing APIs unnecessarily
* opportunistic cleanup

A small change is preferable only when it is also complete and correct.

### 5. Preserve Existing Contracts

Unless explicitly instructed otherwise, preserve:

* public APIs
* existing behavior
* data formats
* error semantics
* compatibility expectations
* architectural boundaries

When behavior must change, identify which existing contract is intentionally changing.

### 6. Test the Change

Add or modify tests that establish the intended behavior.

Prioritize:

* normal behavior
* boundary conditions
* failure paths
* regressions related to the change

Prefer behavioral tests over tests tightly coupled to implementation details.

### 7. Verify Incrementally

Use this progression when practical:

```
focused test
    ↓
related test suite
    ↓
type/static checks
    ↓
broader test suite
```

Use the repository's established verification commands.

### 8. Inspect the Diff

Before reporting completion:

* inspect all changed files
* remove accidental changes
* verify that generated or temporary files are not included
* check for debugging code
* confirm the implementation matches the requested design

### 9. Report

Provide:

* implementation summary
* files changed
* tests added/changed
* verification performed
* deviations from the assignment
* unresolved concerns

## Triage Gate

Before substantial implementation, determine whether the task can be safely executed using established patterns and sufficiently understood context.

Proceed directly when:

* the desired behavior is clear
* the implementation pattern is established
* the affected scope is understood
* no consequential architectural decision is required

Escalate per the Implementer role's escalation criteria. Do not compensate for uncertainty by performing increasingly extensive implementation or exploration; escalation is preferable when uncertainty concerns architecture rather than implementation mechanics.
