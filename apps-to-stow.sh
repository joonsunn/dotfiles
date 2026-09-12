#!/usr/bin/env bash
# Ordered list of stow packages for stow.sh.
# Sourced, not executed: `source ./apps-to-stow.sh` then loop over APPS_TO_STOW.
#
# Ordering constraints:
#   1. `stow` first — seeds ~/.stow-global-ignore so later packages ignore
#      README.md, NOTES.md, *.example, etc.
#   2. `agents` second — source of truth for harness symlinks.
#   3. `claude`, `codex`, `kilo`, `opencode` only after `agents`
#      (each contains relative symlinks back into agents/.agents).
#   4. Everything else is order-independent (alphabetical below).
#
# `vscode` is intentionally NOT in this list — it needs a platform-specific
# --target (see stow.sh).
# `oh-my-posh` is intentionally NOT in this list — .zshrc points at the
# theme in the repo (dotfiles/oh-my-posh/...) rather than a stowed copy.
# `helper_scripts` is intentionally NOT in this list — run the scripts
# directly instead of stowing them.

APPS_TO_STOW=(
  stow
  agents
  copilot
  claude
  codex
  kilo
  opencode
  bash
  ghostty
  git
  mise
  ssh
  tmux
  wezterm
  zellij
  zsh
)

# Packages whose target directories receive machine-local writes.
# Stow folds a package into a single directory symlink when the target
# does not exist yet, which would route those writes into this repo.
# stow.sh passes --no-folding for these so the target stays a real
# directory with file-level symlinks and app state lands beside them.
#   claude   — sessions/, backups/
#   codex    — auth.json, history.jsonl, logs, sessions
#   copilot  — config.json, logs/, ide/
#   kilo     — plugin node_modules, lockfiles
#   opencode — plugin node_modules, lockfiles
#   ssh      — keys, known_hosts (never fold; keys must not enter the repo)
NO_FOLD_PACKAGES=(
  claude
  codex
  copilot
  kilo
  opencode
  ssh
)
