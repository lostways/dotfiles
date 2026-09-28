# ZSH
log "Installing ZSH..."
sudo apt-get install zsh -y

log "Installing Oh-My-ZSH..."
sudo apt-get install curl -y
# KEEP_ZSHRC keeps the installer from replacing the linked ~/.zshrc
KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
