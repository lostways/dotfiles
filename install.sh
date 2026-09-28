#!/usr/bin/env bash
# Usage: ./install.sh [--dry-run] <profile|script>...
#   profiles: cli (servers and desktops), desktop (cli + the Hyprland desktop)
#   scripts:  any scripts/<name>.sh, e.g. ./install.sh docker python
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dry_run="0"

if [[ $1 == "--dry-run" ]]; then
    dry_run="1"
    shift
fi

# Profiles run their scripts in order. files has to run before fish (plugin
# list), tmux and nvim (plugin installs need their configs). desktop runs
# files again after hyprland so the desktop package gets linked.
cli=(utils files fish tmux nvim gh)
desktop=("${cli[@]}" fonts hyprland files system yazi wiremix zen-browser)

log() {
    if [[ $dry_run == "1" ]]; then
        echo -e "[DRY_RUN] \033[1;33m$1\033[0m"
        return
    else
        echo -e "\033[1;32m$1\033[0m"
    fi
}

# Minimal systems (containers, fresh Debian) may not set USER or have sudo.
# As root, sudo just runs the command.
export USER=${USER:-$(id -un)}
if ! command -v sudo >/dev/null; then
    if [[ $EUID == 0 ]]; then
        sudo() { "$@"; }
        export -f sudo
    else
        echo "sudo is not installed; install it as root (apt-get install sudo) or run as root" >&2
        exit 1
    fi
fi

export -f log
export dry_run
export script_dir

log "script dir: $script_dir"

scripts=()
for arg in "$@"; do
    case $arg in
        cli) scripts+=("${cli[@]}") ;;
        desktop) scripts+=("${desktop[@]}") ;;
        *) scripts+=("$arg") ;;
    esac
done

for script in "${scripts[@]}"; do
    if [[ ! -f $script_dir/scripts/$script.sh ]]; then
        echo "no such script: scripts/$script.sh" >&2
        exit 1
    fi
done

# Fresh systems (and containers) start with empty package lists
if [[ $dry_run == "0" ]]; then
    log "Updating package lists..."
    sudo apt-get update
fi

for script in "${scripts[@]}"; do
    log "Running $script"
    bash $script_dir/scripts/$script.sh
done
