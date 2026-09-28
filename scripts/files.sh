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

# cli is linked everywhere, desktop only where Hyprland is installed
packages=(cli)
if command -v Hyprland >/dev/null; then
    packages+=(desktop)
fi

for package in "${packages[@]}"; do
    # Move anything in the way of a link out of the way. Stale links into this
    # repo and files identical to the repo copy are just removed, anything
    # else is kept as <file>.bak
    log "Checking for conflicting files ($package)..."
    pushd $script_dir/$package > /dev/null
    while IFS= read -r -d '' file; do
        rel=${file#./}
        source="$script_dir/$package/$rel"
        target="$HOME/$rel"

        # nothing there, or already linked to the repo
        if [[ ! -e $target && ! -L $target ]]; then
            continue
        fi
        if [[ $(readlink -f "$target") == $(readlink -f "$source") ]]; then
            continue
        fi

        # a link into this repo from an old layout (e.g. before a file moved)
        if [[ -L $target && $(readlink -m "$target") == "$script_dir"/* ]]; then
            log "Removing stale link $target"
            if [[ $dry_run == "0" ]]; then
                rm "$target"
            fi
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
    log "Linking $script_dir/$package into $HOME..."
    if [[ $dry_run == "0" ]]; then
        stow --no-folding --restow -d "$script_dir" -t "$HOME" "$package"
    fi
done

# Reloading with the links not actually changed can make programs fall back
# to defaults (Hyprland writes a stub config when its config is missing)
if [[ $dry_run == "1" ]]; then
    log "Skipping reloads"
    exit 0
fi

# reload every running fish shell (see __dotfiles_reload_config in config.fish)
if command -v fish >/dev/null; then
    log "Reloading fish shells..."
    fish -c 'set -U __dotfiles_reload (date +%s%N)' >/dev/null
fi

# reload waybar if waybar is running
if command -v pgrep >/dev/null && pgrep waybar >/dev/null; then
    log "Reloading waybar..."
    killall -SIGUSR2 waybar 2>/dev/null || true
fi

# reload hyprpaper if hyprpaper is running
if command -v pgrep >/dev/null && pgrep hyprpaper >/dev/null; then
    log "Reloading hyprpaper..."
    killall -w hyprpaper 2>/dev/null || true
    # start it through hyprland so it isn't tied to this terminal
    hyprctl dispatch exec hyprpaper >/dev/null
fi

# reload hyprland if hyprland is running
if command -v pgrep >/dev/null && pgrep hyprland >/dev/null; then
    log "Reloading hyprland..."
    hyprctl reload 2>/dev/null || true
fi
