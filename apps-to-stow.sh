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
