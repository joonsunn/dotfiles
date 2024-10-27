# My dotfiles managed with GNU Stow

## Getting started

1. Clone this repo to home directory

   ```bash
   git clone [git@github.com:joonsunn/dotfiles.git](https://github.com/joonsunn/dotfiles.git)
   ```

2. Navigate to `~/dotfiles/helper_scripts`, then run:

   ```bash
   chmod +x ./helper_scripts/run_first.sh
   ./helper_scripts/run_first.sh
   ```

3. initialise Stow

   ```bash
   cd ~/dotfiles
   stow .
   ```

4. If conflict occurs, then run

   ```bash
   stow . --adopt
   git reset --hard
   ```

5. Proceed to install other apps, such as `vscode` and etc.

##

## Stowed application settings

1. `git`
2. `zsh`
3. `bash`
4. `code` (VS Code)
