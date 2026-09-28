log "Installing Ripgrep..."
sudo apt-get -y install ripgrep

log "Installing btop..."
sudo apt-get -y install btop

log "Installing jq..."
sudo apt-get -y install jq

log "Installing fd-find..."
sudo apt-get -y install fd-find

log "Installing fzf..."
sudo apt-get -y install fzf

log "Installing bat..."
sudo apt-get -y install bat

log "Installing lsd..."
sudo apt-get -y install lsd

# Ubuntu installs these as batcat and fdfind, link them to their usual names
log "Linking bat and fd into ~/.local/bin..."
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat
ln -sf /usr/bin/fdfind ~/.local/bin/fd
