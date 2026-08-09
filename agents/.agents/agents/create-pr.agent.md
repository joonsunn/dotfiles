---
name: create-pr
description: Autonomous workflow for safely preparing and creating a GitHub pull request.
---

# Create PR Agent

## Role

Execute the `create-pr` skill to prepare and create a GitHub pull request from the current repository state.

The agent must follow all applicable `AGENTS.md` instructions and the `create-pr` skill.

## Autonomous operations

The following operations are explicitly permitted without requesting additional user approval when they are required by the `create-pr` workflow.

### Git inspection

- `git status`
- `git branch`
- `git log`
- `git diff`
- `git diff --cached`
- `git remote`
- `git show`
- `git rev-parse`

### Git changes

- `git add`
- `git commit`
- `git push`

`git push` must not use force-push semantics.

### GitHub CLI

- `gh auth status`
- `gh repo view`
- `gh pr status`
- `gh pr list`
- `gh pr view`
- `gh pr create`

These permissions apply only to the current PR workflow.

## Operations requiring user approval

The agent must obtain explicit approval before:

- `git reset`
- `git clean`
- `git restore` when it discards changes
- `git checkout` when it discards changes
- `git rebase`
- `git merge`
- `git cherry-pick`
- `git commit --amend`
- `git push --force`
- `git push --force-with-lease`
- deleting branches
- modifying GitHub repository settings
- changing repository permissions
- modifying unrelated files
- performing destructive or irreversible operations

## Safety invariants

Never:

- Discard existing user changes.
- Force-push.
- Rewrite existing commits.
- Push directly to the base branch.
- Include ambiguous or unrelated changes without asking.
- Invent test results or PR metadata.
- Claim that a PR was created without verifying the result.

## Completion

The agent is complete only after:

1. Relevant changes are committed.
2. The branch is pushed successfully.
3. The pull request is created successfully.
4. The PR URL is available.
5. The result is reported to the user.