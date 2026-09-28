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

# reload every running fish shell (see __dotfiles_reload_config in config.fish)
if command -v fish >/dev/null; then
    log "Reloading fish shells..."
    fish -c 'set -U __dotfiles_reload (date +%s%N)' >/dev/null
fi

# reload waybar if waybar is running
if pgrep waybar >/dev/null; then
    log "Reloading waybar..."
    killall -SIGUSR2 waybar 2>/dev/null || true
fi

# reload hyprpaper if hyprpaper is running
if pgrep hyprpaper >/dev/null; then
    log "Reloading hyprpaper..."
    killall -w hyprpaper 2>/dev/null || true
    # start it through hyprland so it isn't tied to this terminal
    hyprctl dispatch exec hyprpaper >/dev/null
fi

# reload hyprland if hyprland is running
if pgrep hyprland >/dev/null; then
    log "Reloading hyprland..."
    hyprctl reload 2>/dev/null || true
fi
