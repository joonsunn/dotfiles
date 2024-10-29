#!/bin/bash

sudo apt update
sudo apt install -y git stow zsh
chsh -s $(which zsh)

curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install meslo
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git
git clone https://github.com/Aloxaf/fzf-tab

./fzf/install