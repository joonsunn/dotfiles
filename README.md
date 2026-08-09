# My dotfiles managed with GNU Stow

## Getting started

1. Clone this repo to home directory

   ```bash
   git clone https://github.com/joonsunn/dotfiles.git
   ```

2. Navigate to `~/dotfiles/helper_scripts`, then run:

   ```bash
   chmod +x ./run_first.sh
   ./run_first.sh
   ```

   `run_first.sh` installs the following applications:
   - git
   - openssh-server
   - stow
   - zsh
   - tmux
   - oh-my-posh (curl-ing script from oh-my-posh repo)

3. Install all other apps. In this case:
   - `code` (VS Code) (using `install_vs_code.sh` as well as `install_vscode_extensions.sh` inside `helper_scripts` folder)

4. initialise Stow

   Either do one by one:

   ```bash
      stow --verbose --stow git
      stow mise # alternative command
      ...
   ```

   or use the `*/` glob pattern to expand:

   ```bash
      > echo */
      bash/ codex/ git/ ......
   ```

   so can do all one shot (stow all except vscode and tmux):

   ```bash
   cd ~/dotfiles
   stow --verbose --stow --target="$HOME" ^(vscode|tmux)/
   ```

5. Then stow VS Code settings separately (for macos):

   ```bash
   stow --verbose --target="$HOME/Library/Application\ Support/Code/User" --stow vscode
   ```

6. If conflict occurs, then run

   ```bash
   stow --adopt --verbose --target="$HOME" ^(vscode|tmux)/
   git reset --hard
   ```

7. Make a copy of `secrets.zsh.example`, rename it to `secrets.zsh`, and populate it with the relevant secrets/API keys. Run `exec zsh` to apply changes.

info: <https://stackoverflow.com/questions/64231650/why-doesnt-gnu-stow-ignore-single-files-in-main-directory>

## Stowed application settings

1. `git`
2. `zsh`
3. `bash`
4. `code` (VS Code)
5. `tmux` (to be installed separately, either linux-brew or from script)
6. `wezterm`
7. `oh-my-posh`
8. `mise`

## VS Code folder shenanigans

VS Code settings are excluded from global stow (using `--ignore vscode`) since VS Code stores settings in platform-specific locations. Use the `-t` flag to specify the correct target:

- **MacOS:** `~/Library/Application Support/Code/User`
- **Linux:** `~/.config/Code/User`

See [Cross-platform settings](#cross-platform-settings) for the correct commands.

## Adding new apps to stow

Create a folder for the app, then replicate the folder structure **within** that folder to emulate the home directory. Then at the root of this repo, run `stow [app folder name]`, or `stow --adopt [app folder name]`

## Cross-platform settings

### VS Code

VS Code stores its settings in platform-specific directories. Use stow's `-t` or `--target` flag to specify the correct target:

**On MacOS:**

```bash
stow --verbose --target="$HOME/Library/Application\ Support/Code/User" --stow vscode
```

**On Linux:**

```bash
stow --verbose --target="$HOME/.config/Code/User" --stow vscode
```

## Quick tips

`stow <app-name>` creates the symlink. Quick and dirty way of re-doing the stow is to manually delete any erroneously created symlinks at the non-`dotfiles` directory, then do `stow ...`.

Official way to undo stow (delete symlink created by `stow`): `stow --delete <app-name>`.
Can also add `alias=stow --delete` to `.zshrc`.

Manual symlink:

   ```bash
   cd "$(dirname <where-the-link-will-be>)"
   ln -s <path-from-here-to-source> <link-name>
   ```
