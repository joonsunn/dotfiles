#!/bin/bash

cd ~/dotfiles/helper_scripts
sudo apt update
sudo apt install -y git stow zsh openssh-server command-not-found tmux curl fcitx5 fcitx5-chinese-addons
chsh -s $(which zsh)


curl -s https://ohmyposh.dev/install.sh | bash -s
export PATH=$PATH:$HOME/.local/bin
oh-my-posh font install meslo

curl https://mise.run | sh

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git
git clone https://github.com/junegunn/fzf.git
git clone https://github.com/Aloxaf/fzf-tab

./fzf/install --all
