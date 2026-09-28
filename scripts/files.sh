#!/bin/env bash
# ==============
# Link files into $HOME with GNU stow
# ==============

if ! command -v stow >/dev/null; then
    log "Installing stow..."
    if [[ $dry_run == "0" ]]; then
        sudo apt-get install -y stow
    fi
fi

# Move anything in the way of a link out of the way. Files identical to the
# repo copy are just removed, anything else is kept as <file>.bak
log "Checking for conflicting files..."
pushd $script_dir/env > /dev/null
while IFS= read -r -d '' file; do
    rel=${file#./}
    source="$script_dir/env/$rel"
    target="$HOME/$rel"

    # nothing there, or already linked to the repo
    if [[ ! -e $target && ! -L $target ]]; then
        continue
    fi
    if [[ $(readlink -f "$target") == $(readlink -f "$source") ]]; then
        continue
    fi

    if [[ -f $target && ! -L $target ]] && cmp -s "$target" "$source"; then
        log "Removing $target (same as repo)"
        if [[ $dry_run == "0" ]]; then
            rm "$target"
        fi
        continue
    fi

    backup="$target.bak"
    if [[ -e $backup || -L $backup ]]; then
        backup="$target.bak.$(date +%Y%m%d%H%M%S)"
    fi
    log "Backing up $target to $backup"
    if [[ $dry_run == "0" ]]; then
        mv "$target" "$backup"
    fi
done < <(find . \( -type f -o -type l \) -print0)
popd > /dev/null

# --no-folding links individual files instead of whole directories, so apps
# writing new files into e.g. ~/.config/fish don't end up in the repo
log "Linking $script_dir/env into $HOME..."
if [[ $dry_run == "0" ]]; then
    stow --no-folding --restow -d "$script_dir" -t "$HOME" env
fi

# if we are in zsh reload the zsh config
if [ "$SHELL" == "$(which zsh)" ]; then
    log "Reloading zsh configuration..."
    zsh -c "source $HOME/.zshrc"
fi

# if we are in fish reload the fish config
if [ "$SHELL" == "$(which fish)" ]; then
    log "Reloading fish configuration..."
    fish -c "source $HOME/.config/fish/config.fish"
fi

# reload waybar if waybar is running
if pgrep waybar >/dev/null; then
    log "Reloading waybar..."
    killall -SIGUSR2 waybar 2>/dev/null || true
fi

# reload hyprpaper if hyprpaper is running
if pgrep hyprpaper >/dev/null; then
    log "Reloading hyprpaper..."
    killall -SIGUSR1 hyprpaper 2>/dev/null || true
    hyprpaper&
fi

# reload hyprland if hyprland is running
if pgrep hyprland >/dev/null; then
    log "Reloading hyprland..."
    hyprctl reload 2>/dev/null || true
fi
