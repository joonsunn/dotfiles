---
name: code-review
description: Systematically evaluate a change for correctness, regressions, security, architecture, and test adequacy. Use when reviewing a diff, pull request, or submitted implementation.
---

# Code Review

## Purpose

Systematically evaluate a change for correctness, architectural integrity, regressions, security issues, maintainability, and inadequate verification.

## Core Principle

Review the implementation, not the implementation narrative.

Treat descriptions, comments, commit messages, and agent reports as claims that may need verification.

## Procedure

### 1. Establish the Intended Behavior

Determine:

* what the change is supposed to accomplish
* which existing behavior should remain unchanged
* which architectural decisions were intentional
* which constraints apply

Use the original task and architectural plan as the source of intent.

### 2. Inspect the Diff

Start with the complete change.

Identify:

* modified files
* added files
* deleted files
* API changes
* dependency changes
* configuration changes
* test changes

Do not review individual files in isolation.

### 3. Understand Surrounding Context

Read enough surrounding implementation to determine:

* how the changed code is used
* which assumptions callers make
* which invariants exist
* whether similar code behaves differently
* whether the change crosses architectural boundaries

### 4. Check Correctness

Look for:

* incorrect logic
* missing conditions
* invalid assumptions
* incorrect state transitions
* broken error paths
* race conditions
* resource leaks
* invalid input handling
* incorrect serialization/deserialization
* ordering issues
* failures under retries or repeated execution

### 5. Check Regression Risk

Determine whether the change unintentionally affects:

* existing APIs
* existing callers
* unrelated functionality
* backwards compatibility
* persistence
* configuration
* deployment behavior

### 6. Check Architecture

Determine whether the change:

* follows established patterns
* preserves dependency direction
* respects component boundaries
* introduces unnecessary abstractions
* duplicates existing mechanisms
* creates inappropriate coupling
* moves responsibilities to the wrong layer

### 7. Check Security

When relevant, inspect:

* authentication
* authorization
* input validation
* injection risks
* secret handling
* trust boundaries
* access control
* sensitive data exposure
* unsafe deserialization
* filesystem/network access

Do not perform a security review mechanically when the change has no meaningful security implications.

### 8. Check Performance

When relevant, inspect:

* algorithmic complexity
* unnecessary I/O
* repeated queries
* excessive allocations
* unbounded operations
* caching behavior
* concurrency
* resource consumption

Focus on meaningful risks rather than speculative micro-optimizations.

### 9. Check Tests

Determine whether tests adequately establish:

* intended behavior
* important edge cases
* failure behavior
* regression protection

A passing test suite does not establish adequate coverage by itself.

### 10. Verify Findings

Before reporting a problem:

* confirm it exists in the actual code
* understand the condition under which it occurs
* determine its practical impact
* distinguish defects from stylistic preferences

Do not report hypothetical issues without a credible triggering condition.

## Severity

Use:

* **Critical** — severe correctness, security, data-loss, or system-integrity issue
* **High** — significant defect or regression
* **Medium** — meaningful defect, risk, or maintainability problem
* **Low** — minor issue worth addressing
* **Informational** — observation that does not require correction

## Reporting

For each substantive finding:

1. Severity
2. Location
3. Problem
4. Why it matters
5. Trigger/condition
6. Recommended direction

Keep findings specific and actionable.

Do not bury important findings among stylistic observations.

## Final Assessment

Conclude with one of:

* **Approved** — no substantive issues identified.
* **Changes requested** — substantive issues must be addressed.
* **Needs architectural clarification** — correctness depends on an unresolved design decision.

Do not request changes simply because an alternative implementation would be preferable.

## Independence

Do not assume that an implementation is correct because it follows the
Architect's design.

Review both:

1. whether the implementation correctly realizes the intended architecture
2. whether the architectural approach itself creates a substantive problem

If the latter is true, report it explicitly rather than limiting the review
to implementation details.
