# Notes on the .agents folder

This folder is meant to be the source of truth where all other harness will duplicate from. In short, we write the skill and AGENTS.md once, and symlink it to all the harnesses' global config folders. Symlinking will be the solution until all the harnesses agree to adopt the ~ level .agents folder. Some harnesses do recognise the home-level `.agents` folder, so it is recommended to `stow` this `agents` package, as well as the individual harness' stow package.

## How to set up new harness

E.g. `codex`, which expects the global config to be in `~/.codex`.

1. from the root of the `dotfiles` repo, `mkdir -p codex/.codex`
2. from the folder that was created, create a symlink back to the global `.agents` folder:

    ```sh
    ln -s ../../agents/.agents/* .
    ```

3. The `skills` folder and the `AGENTS.md` file should be symlinked in the aforementioned `.codex` folder.

    Take note of the levels deep in the home directory the harness' global config requires. For example, `opencode` expects the global config to reside in `~/.config/opencode` (resulting in the folder structure for the `opencode` package to be `/opencode/.config/opencode/`), so the symlink command needs to go 3 levels up, instead of just 2 for `codex`.

4. Don't forget to run `stow codex` from the root of this repo once you're done setting up.
