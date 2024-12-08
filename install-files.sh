#!/bin/bash

# Install Files

# VARS

PWD=`pwd`

# ==============
# Backup existing files
# ==============

cp -r ~/.config/nvim ~/.config/nvim.bak 2>/dev/null || true
cp ~/.gitconfig ~/.gitconfig.bak 2>/dev/null || true
cp ~/.tmux.conf ~/.tmux.conf.bak 2>/dev/null || true
cp ~/.zshrc ~/.zshrc.bak 2>/dev/null || true

# ==============
# Remove existing files
# ==============

rm -rf ~/.config/nvim
rm -rf ~/.gitconfig
rm -rf ~/.tmux.conf
rm -rf ~/.zshrc
sudo rm -rf /usr/local/bin/tm

# ==============
# Ensure TPM is installed
# ==============

if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "TPM not found, installing..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ==============
# Copy files 
# ==============

cp -r $PWD/nvim ~/.config/
cp $PWD/.gitconfig ~/.gitconfig
cp $PWD/.tmux.conf ~/.tmux.conf

# ==============
# Copy scripts
# ==============

sudo cp $PWD/bin/tm /usr/local/bin

# ==============
# Create new zshrc that sources ours
# Note: put all custom zshrc stuff in ~/.zshrc.local
# ==============

echo "source $PWD/.zshrc" > ~/.zshrc

# ==============
# Install tmux plugins
# ==============

tmux start-server
tmux new-session -d -s __temp
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t __temp

# ==============
# Setup GitHub CoPilot
# ==============

nvim "+Copilot setup" +qall

# ==============
# Configure Fish
# ==============
fish -c "source $PWD/setup-fish.fish"

cd $PWD
