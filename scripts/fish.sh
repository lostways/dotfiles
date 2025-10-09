# FISH
log "Installing FISH..."
sudo apt-get update
sudo apt-get install fish -y

# ==============
# Configure Fish
# ==============

log "Configuring Fish..."
# are we already using fish?
if [ "$SHELL" != "$(which fish)" ]; then
  fish -c "source ${script_dir}/scripts/setup-fish.fish"
fi
