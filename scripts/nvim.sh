# Update apt sources
log "Updating APT Sources..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y

# NEOVIM
log "Installing Neovim..."
sudo apt-get -y install neovim

#NVIM
read -p "Install NVIM from source [y/n]?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get -y install ninja-build gettext cmake unzip curl build-essential
    cd /tmp
    git clone https://github.com/neovim/neovim
    cd neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    rm -rf /tmp/neovim
    cd $CWD
fi

# ==============
# Setup GitHub CoPilot
# ==============

log "Setting up GitHub CoPilot..."
nvim "+Copilot setup" +qall
