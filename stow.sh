#!/usr/bin/env bash
# Stow all packages in dependency order (macOS and Linux).
# Usage: ./stow.sh [--os mac|linux] [--vscode-target PATH] [--adopt] [--dry-run]
#   --os mac|linux       override OS detection (default: uname -s)
#   --vscode-target PATH override the vscode stow target
#   --adopt              resolve conflicts by adopting existing files (stow --adopt)
#   --dry-run            print what would run without changing anything
set -euo pipefail

# Portable across bash and zsh: BASH_SOURCE under bash, $0 under zsh.
_SCRIPT_PATH="${BASH_SOURCE[0]:-$0}"
DOTFILES_DIR="$(cd "$(dirname "$_SCRIPT_PATH")" && pwd)"
source "$DOTFILES_DIR/apps-to-stow.sh"

OS_OVERRIDE=""
VSCODE_TARGET_OVERRIDE=""
MODE="--restow"
DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --os=*) OS_OVERRIDE="${1#--os=}"; shift ;;
    --os) OS_OVERRIDE="${2:-}"; shift 2 ;;
    --mac) OS_OVERRIDE="mac"; shift ;;
    --linux) OS_OVERRIDE="linux"; shift ;;
    --vscode-target=*) VSCODE_TARGET_OVERRIDE="${1#--vscode-target=}"; shift ;;
    --vscode-target) VSCODE_TARGET_OVERRIDE="${2:-}"; shift 2 ;;
    --adopt) MODE="--adopt"; shift ;;
    --dry-run|--simulate|-n) DRY_RUN=1; shift ;;
    -h|--help)
      echo "Usage: $(basename "$0") [--os mac|linux] [--vscode-target PATH] [--adopt] [--dry-run]"
      exit 0
      ;;
    *)
      echo "Unknown arg: $1" >&2
      exit 1
      ;;
  esac
done

detect_os() {
  case "$(uname -s)" in
    Darwin*) echo "mac" ;;
    Linux*) echo "linux" ;;
    *) echo "unknown" ;;
  esac
}

OS="${OS_OVERRIDE:-$(detect_os)}"
case "$OS" in
  mac)
    DEFAULT_VSCODE_TARGET="$HOME/Library/Application Support/Code/User"
    INSTALL_HINT="brew install stow"
    ;;
  linux)
    DEFAULT_VSCODE_TARGET="$HOME/.config/Code/User"
    INSTALL_HINT="sudo apt install -y stow"
    ;;
  *)
    echo "error: unknown OS \"$OS\" (uname: $(uname -s)). Pass --os mac|linux." >&2
    exit 1
    ;;
esac
VSCODE_TARGET="${VSCODE_TARGET_OVERRIDE:-$DEFAULT_VSCODE_TARGET}"

if ! command -v stow >/dev/null; then
  echo "error: GNU stow not found. Install it first: $INSTALL_HINT" >&2
  exit 1
fi

cd "$DOTFILES_DIR"

run_stow() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] stow $*"
  else
    stow "$@"
  fi
}

for pkg in "${APPS_TO_STOW[@]}"; do
  run_stow --verbose "$MODE" --target="$HOME" "$pkg"
done

mkdir -p "$VSCODE_TARGET"
run_stow --verbose "$MODE" --target="$VSCODE_TARGET" vscode
