#!/bin/bash

sudo apt update
sudo apt install -y git stow zsh
chsh -s $(which zsh)

curl -s https://ohmyposh.dev/install.sh | bash -s
oh-my-posh font install
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git