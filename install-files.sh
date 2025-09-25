#!/usr/bin/env bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dry_run="0"

if [[ $1 == "--dry-run" ]]; then
    dry_run="1"
fi

log() {
    if [[ $dry_run == "1" ]]; then
        echo -e "[DRY_RUN] \033[1;33m$1\033[0m"
        return
    else
        echo -e "\033[1;32m$1\033[0m"
    fi
}


copy() {
    log "removing $2"
    if [[ $dry_run == "0" ]]; then
        rm $2
    fi

    log "Copying $1 to $2"
    if [[ $dry_run == "0" ]]; then
        cp $1 $2
    fi
}

copy_dir() {
    pushd $1
    to=$2
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    for dir in $dirs; do
        directory=${2%/}/${dir#./}
        log "Removing $directory"
        if [[ $dry_run == "0" ]]; then
            rm -rf $directory
        fi

        log "Copying $dir to $directory"
        if [[ $dry_run == "0" ]]; then
	    mkdir -p $(dirname $directory)
	    cp -r $dir $(dirname $directory)
        fi
    done
    popd
}


log "script dir: $script_dir"

# Install Files

# VARS

PWD=`pwd`


# ==============
# Ensure TPM is installed
# ==============

log "Checking TPM..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "TPM not found, installing..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

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
# Install Fonts
# ==============

log "Installing fonts..."
if [ ! -d ~/.local/share/fonts ]; then
    mkdir -p ~/.local/share/fonts
fi
unzip -o $script_dir/fonts/Hack.zip -d ~/.local/share/fonts
fc-cache -f -v

# ==============
# Install tmux plugins
# ==============

log "Installing tmux plugins..."
tmux start-server
tmux new-session -d -s __temp
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t __temp

# ==============
# Setup GitHub CoPilot
# ==============

log "Setting up GitHub CoPilot..."
nvim "+Copilot setup" +qall

# ==============
# Configure Fish
# ==============

log "Configuring Fish..."
fish -c "source $PWD/setup-fish.fish"

cd $PWD
