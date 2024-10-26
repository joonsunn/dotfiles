# My dotfiles managed with GNU Stow

1. Clone this repo to home directory

```bash
git clone git@github.com:joonsunn/dotfiles.git
```

2. Navigate to `~/dotfiles/helper_scripts`, then run:

```bash
chmod +x pull_repos.sh
./pull_repos.sh
```

3. initialise Stow

```bash
cd ~/dotfiles
stow .
```
