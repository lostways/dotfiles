# Install TMUX via apt (git is needed for TPM)
log "Installing TMUX via APT..."
sudo apt-get -y install tmux git
tmux -V

# ==============
# Ensure TPM is installed
# ==============

log "Checking TPM..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "TPM not found, installing..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ==============
# Install tmux plugins
# ==============

log "Installing tmux plugins..."
tmux start-server
tmux new-session -d -s __temp
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t __temp
