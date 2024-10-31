#!/bin/bash

sudo apt update
sudo apt install -y git stow zsh openssh-server
chsh -s $(which zsh)


curl -s https://ohmyposh.dev/install.sh | bash -s
export PATH:$PATH:$HOME/.local/bin
oh-my-posh font install meslo
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git
git clone https://github.com/junegunn/fzf.git
git clone https://github.com/Aloxaf/fzf-tab
wget https://www.c-nergy.be/downloads/xRDP/xrdp-installer-1.5.2.zip
unzip xrdp-installer-1.5.2.zip 
chmod +x ./xrdp-installer-1.5.2.sh
./xrdp-installer-1.5.2.sh -s -u

./fzf/install --all
