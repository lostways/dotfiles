# ZSH
log "Installing ZSH..."
sudo apt-get install zsh -y

log "Installing Oh-My-ZSH..."
sudo apt-get install curl -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

log "Setting ZSH as default shell..."
sudo chsh -s $(which zsh) $(whoami)
