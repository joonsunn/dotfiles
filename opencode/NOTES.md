# Notes on OpenCode stow package

The contents of the `.config/opencode` folder is mostly symlinked from `dotfiles/.agents`.
Keep `~/.config/opencode` a real directory with file-level symlinks, not a folded symlink, because the plugin install (`package.json` plus `node_modules`) is machine-local and must live beside the links rather than inside the repo. Run installs from `~/.config/opencode`, never from the repo path.
