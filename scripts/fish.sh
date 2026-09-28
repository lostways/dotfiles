# FISH
# fish is the interactive shell, but the login shell stays bash, which hands
# interactive sessions off to fish (see cli/.config/bash/fish-handoff.sh)
log "Installing FISH..."
sudo apt-get update
sudo apt-get install -y fish curl

if [[ $(basename "$(getent passwd "$USER" | cut -d: -f7)") != bash ]]; then
  log "Setting bash as the login shell..."
  sudo chsh -s "$(command -v bash)" "$USER"
fi

# Add one line to the system's own ~/.bashrc rather than replacing it. The
# -f guard makes it a no-op if the dotfiles aren't linked.
handoff_line='[ -f ~/.config/bash/fish-handoff.sh ] && . ~/.config/bash/fish-handoff.sh'
if ! grep -qxF "$handoff_line" "$HOME/.bashrc" 2>/dev/null; then
  log "Adding fish hand-off to ~/.bashrc"
  if [[ $dry_run == "0" ]]; then
    printf '\n# dotfiles: hand interactive shells off to fish\n%s\n' "$handoff_line" >> "$HOME/.bashrc"
  fi
fi

# ==============
# Configure Fish
# ==============

log "Configuring Fish..."
# plugins are listed in cli/.config/fish/fish_plugins, linked by `files`
if [ ! -e "$HOME/.config/fish/fish_plugins" ]; then
  log "ERROR: ~/.config/fish/fish_plugins not found, run ./install.sh files first"
  exit 1
fi
fish "${script_dir}/scripts/setup-fish.fish"
