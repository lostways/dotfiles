#!/usr/bin/zsh

# Install Files

# VARS

PWD=`pwd`

# ==============
# Delete existing files
# ==============

sudo rm -rf ~/.vimrc
sudo rm -rf ~/.vim/plugins.vim
sudo rm -rf ~/.gitconfig
sudo rm -rf ~/.tmux.conf

# ==============
# Create symlinks to files
# ==============

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim/plugins.vim ~/.vim/plugins.vim
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.tmux.conf ~/.tmux.conf