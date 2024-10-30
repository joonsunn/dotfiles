# My dotfiles managed with GNU Stow

## Getting started

1. Clone this repo to home directory

   ```bash
   git clone https://github.com/joonsunn/dotfiles.git
   ```

2. Navigate to `~/dotfiles`, then run:

   ```bash
   chmod +x ./helper_scripts/run_first.sh
   ./helper_scripts/run_first.sh
   ```

   `run_first.sh` installs the following applications:

   - git
   - stow
   - zsh
   - oh-my-posh (curl-ing script from oh-my-posh repo)

3. Install all other apps. In this case:

   - `code` (VS Code) (as well as `install_vscode_extensions.sh` inside `helper_scripts` folder)

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

info:

- <https://stackoverflow.com/questions/64231650/why-doesnt-gnu-stow-ignore-single-files-in-main-directory>

## Stowed application settings

1. `git`
2. `zsh`
3. `bash`
4. `code` (VS Code)

## VS COde folder shenanigans

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
