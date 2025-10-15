log "Installing Inkdrop..."
wget https://api.inkdrop.app/download/linux/deb -O /tmp/inkdrop.deb && sudo dpkg -i /tmp/inkdrop.deb && rm /tmp/inkdrop.deb

# Install Inkdrop's dependencies if they are missing
sudo apt-get -f install
