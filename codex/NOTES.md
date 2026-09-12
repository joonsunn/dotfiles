# Notes on Codex stow package

The contents of the `.codex` folder is mostly symlinked from `dotfiles/.agents`.
The `agents/` folder holds thin `*.toml` adapters, one per role, and `agents-ref/` is a symlink to the canonical role definitions in `agents/.agents/agents/`.
Each adapter sets `name`, `description`, and `sandbox_mode` with least privilege, omits `model` so the subagent inherits the parent session model, and points `developer_instructions` at the canonical file under `~/.agents/` plus the relevant skills, with an inline fallback if the file cannot be read.
Global subagent limits live in `config.toml` under `[agents]` with `max_threads` and `max_depth`.
