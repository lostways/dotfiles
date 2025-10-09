# FISH
log "Installing FISH..."
sudo add-apt-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish -y

# ==============
# Configure Fish
# ==============

log "Configuring Fish..."

# are we already using fish?
if [ "$SHELL" != "$(which fish)" ]; then
    fish -c "source $PWD/setup-fish.fish"
fi
