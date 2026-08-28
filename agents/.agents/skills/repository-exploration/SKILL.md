# Repository Exploration

## Procedure

1. Define the specific question being investigated.
2. Inspect the smallest relevant scope first.
3. Search for relevant symbols, filenames, configuration, and terminology.
4. Trace callers, callees, interfaces, implementations, and data flow as needed.
5. Find analogous implementations.
6. Inspect relevant tests.
7. Verify important assumptions against repository evidence.
8. Stop when the question can be answered with sufficient confidence.

## Principles

* Prefer repository evidence over speculation.
* Expand the search only when evidence requires it.
* Prefer existing patterns over inventing new ones.
* Distinguish facts, inferences, and unknowns.
* Do not modify files unless explicitly instructed.

## Handoff

Return a compact report containing:

* relevant files/symbols
* relevant flow
* existing patterns
* tests
* constraints
* unresolved questions

Optimize for information density rather than completeness.
