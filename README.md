# My dotfiles managed with GNU Stow

## Getting started

1. Clone this repo to home directory

   ```bash
   git clone git@github.com:joonsunn/dotfiles.git
   ```

2. Navigate to `~/dotfiles/helper_scripts`, then run:

   ```bash
   chmod +x ./helper_scripts/run_first.sh
   ./helper_scripts/run_first.sh
   ```

3. Install all other apps. In this case:

   * `code` (VS Code)

4. initialise Stow

   ```bash
   cd ~/dotfiles
   stow .
   ```

5. If conflict occurs, then run

   ```bash
   stow . --adopt
   git reset --hard
   ```

##

## Stowed application settings

1. `git`
2. `zsh`
3. `bash`
4. `code` (VS Code)
