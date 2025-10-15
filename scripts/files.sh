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
copy $script_dir/env/fish/config.fish $HOME/.config/fish/config.fish
copy $script_dir/env/inkdrop/keymap.json $HOME/.config/inkdrop/keymap.json

# if we are in zsh reload the zsh config
if [ "$SHELL" == "$(which zsh)" ]; then
    log "Reloading zsh configuration..."
    zsh -c "source $HOME/.zshrc"
fi

# reload waybar
log "Reloading waybar..."
killall -SIGUSR2 waybar 2>/dev/null || true
