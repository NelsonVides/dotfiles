#!/usr/bin/env bash
# fail on error
set -e
sudo apt update
sudo apt install -y tmux curl
sudo apt install -y gnome-tweak-tool dconf-editor

# zsh
sudo apt install -y zsh zsh-syntax-highlighting zsh-theme-powerlevel9k
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# git
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update; sudo apt install -y git gitk
# git clone https://github.com/NelsonVides/.dotfiles.git dotfiles/

# Asdf:
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

# tmux and dotfiles
sh ./install-dotfiles.sh

# nvim
sudo snap install --beta nvim --classic
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.config/dein

# Applications
sudo snap install htop
sudo snap install slack --classic
sudo snap install skype --classic
sudo snap install deja-dup --classic
sudo snap install spotify chromium libreoffice vlc
