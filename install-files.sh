#!/bin/bash

# Install Files

# VARS

PWD=`pwd`

# ==============
# Backup existing files
# ==============

cp ~/.vimrc ~/.vimrc.bak
cp ~/.vim/plugins.vim ~/.vim/plugins.vim.bak
cp ~/.gitconfig ~/.gitconfig.bak
cp ~/.tmux.conf ~/.tmux.conf.bak
cp ~/.zshrc ~/.zshrc.bak

# ==============
# Remove existing files
# ==============

rm -rf ~/.vimrc
rm -rf ~/.vim/plugins.vim
rm -rf ~/.gitconfig
rm -rf ~/.tmux.conf
rm -rf ~/.zshrc

# ==============
# Create symlinks to files
# ==============

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim/plugins.vim ~/.vim/plugins.vim
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.tmux.conf ~/.tmux.conf

# ==============
# Create new zshrc that sources ours
# Note: put all custom zshrc stuff in ~/.zshrc.local
# ==============

echo "source $PWD/.zshrc" > ~/.zshrc

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
# Install Scoped Coc Extensions
# ==============

vim -c 'CocInstall -sync @yaegassy/coc-intelephense' -c 'q'

# ==============
# Install TPM Plugins
# ==============
~/.tmux/plugins/tpm/bin/install_plugins

# ==============
# Setup GitHub CoPilot
# ==============

vim "+Copilot setup" +qall


cd $PWD
