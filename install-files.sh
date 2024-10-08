#!/bin/bash

# Install Files

# VARS

PWD=`pwd`

# ==============
# Backup existing files
# ==============

cp -r ~/.config/nvim ~/.config/nvim.bak
cp ~/.gitconfig ~/.gitconfig.bak
cp ~/.tmux.conf ~/.tmux.conf.bak
cp ~/.zshrc ~/.zshrc.bak

# ==============
# Remove existing files
# ==============

rm -rf ~/.config/nvim
rm -rf ~/.gitconfig
rm -rf ~/.tmux.conf
rm -rf ~/.zshrc

# ==============
# Create symlinks to files
# ==============

# create nvim dir if it doesn't exist
# mkdir -p ~/.config/nvim

ln -sf $PWD/nvim ~/.config/nvim
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
# Install TPM Plugins
# ==============

~/.tmux/plugins/tpm/bin/install_plugins

# ==============
# Setup GitHub CoPilot
# ==============

nvim "+Copilot setup" +qall

cd $PWD
