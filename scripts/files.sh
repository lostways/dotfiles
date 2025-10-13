#!/bin/env bash
# ==============
# Copy files 
# ==============

log "Copying config files..."
copy_dir $script_dir/env/.config $HOME/.config
copy_dir $script_dir/env/.local $HOME/.local

copy $script_dir/env/.gitconfig $HOME/.gitconfig
copy $script_dir/env/.tmux.conf $HOME/.tmux.conf
copy $script_dir/env/.tmux-start $HOME/.tmux-start
copy $script_dir/env/.zshrc $HOME/.zshrc
copy $script_dir/env/pyenv.fish $HOME/.config/fish/conf.d/pyenv.fish

# ==============
# Configure Fish
# =============

# If fish is installed, run the fish setup script
if command -v fish > /dev/null 2>&1; then
    log "Configuring Fish shell..."
    fish $script_dir/scripts/config-fish.fish
else
    log "Fish shell not found, skipping Fish configuration"
fi

# if we are in zsh reload the zsh config
if [ "$SHELL" == "$(which zsh)" ]; then
    log "Reloading zsh configuration..."
    zsh -c "source $HOME/.zshrc"
fi
