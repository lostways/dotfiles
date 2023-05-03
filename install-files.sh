#!/bin/bash

# Install Files

# VARS

PWD=`pwd`

# ==============
# Remove existing files
# ==============

rm ~/.vimrc
rm ~/.vim/plugins.vim
rm ~/.gitconfig
rm ~/.tmux.conf

# ==============
# Create symlinks to files
# ==============

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim/plugins.vim ~/.vim/plugins.vim
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.tmux.conf ~/.tmux.conf

# ==============
# Create links to scripts
# ==============
sudo ln -sf $PWD/bin/tm /usr/local/bin

# ==============
# Reload tmux config
# ==============

tmux source-file ~/.tmux.conf

# ==============
# Install Vim Plugins
# ==============

vim +PluginClean +PluginInstall +PluginUpdate +qall

# ==============
# Finish CoC install
# ==============

cd ~/.vim/bundle/coc.nvim
npm install


cd $PWD
