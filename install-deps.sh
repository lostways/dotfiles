#!/usr/bin/zsh

# Installs dependancies for dotfiles


# CURL
sudo apt-get -y install curl

# VIM
sudo apt-get -y install vim

# Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Tmux
sudo apt-get -y install tmux

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ZSH
sudo apt-get -y install zsh

# Oh-My-ZSh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set ZSH to default shell
sudo chsh -s /usr/bin/zsh ${USER}
