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
# Backup fish config
# ==============

if [ -f ~/.config/fish/config.fish ]; then
  mv ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
fi

# ==============
# Create symlinks to files
# ==============

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim/plugins.vim ~/.vim/plugins.vim
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.tmux.conf ~/.tmux.conf
ln -sf $PWD/config.fish ~/.config/fish/config.fish

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

# ==============
# Setup GitHub CoPilot
# ==============

vim "+Copilot setup" +qall


cd $PWD
