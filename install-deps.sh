#!/usr/bin/env bash

# Installs dependancies for dotfiles

CWD = `pwd`

# Update apt sources
echo -e "\nUpdating APT Sources..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y

# CURL
echo -e "\nInstaling Curl.."
sudo apt-get -y install curl

# Install Ripgrep
echo -e "\nInstalling Ripgrep..."
sudo apt-get -y install ripgrep

# NEOVIM
echo -e "\nInstalling Neovim..."
sudo apt-get -y install neovim

# Node and NPM
echo -e "\nInstalling Node..."
if [ "$(node -v | cut -c2-3)" -gt 20 ];
    then
        echo "Already running Node > 20.0.0 Skipping..."
    else
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt-get update
        sudo apt-get install nodejs -y
fi

# TMUX
read -p "Install TMUX from source [y/n]?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "\nInstalling TMUX"
  #sudo apt-get -y install tmux
  sudo apt-get -y install libevent-dev
  sudo apt-get -y install ncurses-dev
  sudo apt-get -y install autoconf automake pkg-config byacc
  cd /tmp
  git clone https://github.com/tmux/tmux.git
  cd tmux
  sh autogen.sh
  ./configure && make
  sudo make install
  rm -rf /tmp/tmux
  cd $CWD
fi

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


# TPM
echo -e "\nInstalling TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ZSH
echo -e "\nInstalling ZSH..."
sudo apt-get install zsh -y

echo -e "\nInstalling Oh-My-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

echo -e "\nSetting ZSH as default shell..."
sudo chsh -s $(which zsh) $(whoami)

# FISH
echo -e "\nInstalling FISH..."
sudo add-apt-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish -y

# LSD
echo -e "\nInstalling lsd..."
sudo apt-get -y install lsd

# Done
echo -e "\nDone!"
echo -e "\n##########Restart session to continue##########"
