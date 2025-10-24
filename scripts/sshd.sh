log "Installing OpenSSH server"
sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
