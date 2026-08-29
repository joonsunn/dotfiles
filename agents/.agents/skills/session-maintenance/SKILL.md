---
name: session-maintenance
description: Use when a task or session is concluding, or the user asks to wrap up, do maintenance, or sync context. Encapsulates updating AGENTS.md/README/SPEC and other context files with discoveries from the session, then verifying. Trigger on phrases like "end of task", "wrap up", "perform maintenance", or "sync context".
---

# Session Maintenance

This skill exists because "keep docs updated" is a standing rule that is easy to
skip when it is unclear that a session has ended. Invoking this skill makes the
step explicit and repeatable instead of waiting for the user to remember to ask.

## When to run

- The user says the work is done, asks for maintenance, or says to wrap up, sync
  context, or perform end-of-session cleanup.
- A multi-step implementation has just finished and you are reporting results.

Do not run it after every small edit. Reserve it for the end of a coherent chunk
of work.

## Steps

1. Reconstruct the session's changes. Use `git status` and `git diff` (or your
   recollection) to list what actually changed: new or removed dependencies, new
   commands, architecture or layout changes, design tokens, and anything the user
   corrected or rejected.
2. Decide where each fact belongs.
   - Project facts (conventions, deps, commands, architecture, layout, design
     tokens, rejected approaches) go in the repo's `AGENTS.md` first, then
     `README.md` / `SPEC.md` / `pnpm-workspace.yaml` comments if relevant.
   - Cross-project agent preferences go in the global `AGENTS.md`, but ask
     permission before editing that file.
3. Follow the repo's "Context maintenance" rule: update the context file in the
   same change as the work, so docs never drift from code. Keep entries short, in
   sentence case, with no em dashes. Record rejected approaches explicitly (for
   example "left margin rail rejected as off-center") so they are not
   reintroduced later.
4. Do not log ephemeral task minutiae. Record durable facts a future session would
   need.
5. Verify nothing broke. If the maintenance touched anything code references, run
   the repo's verification commands (for this repo: `pnpm build` and
   `pnpm astro check`). Docs-only edits usually need no build, but confirm you did
   not accidentally edit source files.
6. If a skill was loaded during the session and you learned something that would
   help next time, invoke `refine-skill` to fold those learnings back in.
7. Report what you updated and where.

## Notes

- The skill is the trigger. When the user signals the work is complete, run it
  rather than waiting to be reminded.
- Keep the procedure light. The goal is a small, accurate context update, not a
  changelog.
