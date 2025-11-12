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

   ```bash
   cd ~/dotfiles
   stow -vSt ~ */
   ```

5. If conflict occurs, then run

   ```bash
   stow --adopt -vSt ~ */
   git reset --hard
   ```

6. Make a copy of `secrets.zsh.example`, rename it to `secrets.zsh`, and populate it with the relevant secrets/API keys. Run `exec zsh` to apply changes.

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

When running stow with `--adopt` flag **after** instaling VS Code, the `vscode` folder inside `dotfiles` will be populated with all the other files aside from `settings.json`. To fix, run:

```bash
   stow --adopt -vDt ~ */
```

Then delete the vscode folder inside `dotfiles`. Then run

```bash
   git reset --hard
   stow -vSt ~ */
```

Maybe can `stow` first, then only start installing apps, then `git reset --hard` once everything is installed.

## Adding new apps to stow

Create a folder for the app, then replicate the folder structure **within** that folder to emulate the home directory. Then at the root of this repo, run `stow [app folder name]`, or `stow --adopt [app folder name]`
