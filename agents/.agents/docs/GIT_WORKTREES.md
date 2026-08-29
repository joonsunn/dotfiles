# Git worktrees

A worktree keeps a branch's working tree outside the canonical checkout so the canonical checkout stays clean. This convention applies to any repository that is not exempt (see Exemptions).

## When to use a worktree
Use judgement: if a task is substantial enough to warrant its own branch, it warrants its own worktree. As a calibration, "substantial" includes any change touching more than one file's logic, or any API/behavior change. Trivial edits (a one-line typo fix, an untracked scratch file, or anything you would not normally branch for) do not require a worktree.

## Exemptions
These repositories are exempt and may be edited directly in their canonical checkout:
- **dotfiles** — the repo containing the global `AGENTS.md`. Edits to the global `AGENTS.md` itself follow the "request permission before editing" rule in Ground rules, not this worktree flow.

Add other exempt folders/projects here as needed, with a one-line reason.

## Procedure
- The canonical checkout lives at `/<parent>/<project>` and should remain on the repository's default branch (typically `main`).
- Do not check a task branch out directly in the canonical checkout.
- Ensure a sibling `.worktrees/` directory exists next to the canonical checkout (`/<parent>/<project>.worktrees/`); create it with `mkdir -p` if absent.
- Resolve the repository's default branch before branching, e.g. `git -C /<parent>/<project> symbolic-ref refs/remotes/origin/HEAD --short`.
- Before creating a worktree, check whether one already exists for the branch: `git -C /<parent>/<project> worktree list`.
- Create the worktree inside `.worktrees/`, branching from the default branch:
  ```bash
  git -C /<parent>/<project> worktree add \
      /<parent>/<project>.worktrees/<branch-name> \
      -b <branch-name> <default-branch>
  ```
  If the branch already exists, omit `-b`:
  ```bash
  git -C /<parent>/<project> worktree add \
      /<parent>/<project>.worktrees/<branch-name> \
      <branch-name>
  ```
- Perform all task-specific edits, tests, and commits from the task's worktree. The worktree path is the source of truth for which checkout an agent should modify.

## Branch naming
Use a collision-resistant scheme, e.g. `<type>/<slug>` where `<type>` is `feature`, `bugfix`, `experiment`, or `agent-authored`. Agent-authored branches are intended to be handed off to other agents across multiple sessions, so prefer stable, descriptive names over ephemeral agent IDs. Note that a `/` in a branch name produces a nested directory under `.worktrees/`.

## Cleanup
Do not remove worktrees automatically. Remove a worktree only when the user instructs, or when a merge initiated during the session completes — in that case, prompt the user whether to clean up (`git worktree remove <path>`, then `git worktree prune` if needed).

## Example layout
```text
/<parent>/
├── project-A/
│   ├── .git/
│   ├── AGENTS.md
│   └── ...
└── project-A.worktrees/
    ├── feature-branch-A/
    ├── feature-branch-B/
    └── bugfix-C/
```
