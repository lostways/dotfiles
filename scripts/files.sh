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
