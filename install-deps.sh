#!/bin/bash

# Installs dependancies for dotfiles

# Update apt sources
echo -e "\nUpdating APT Sources..."
sudo apt-get update

# CURL
echo -e "\nInstaling Curl.."
sudo apt-get -y install curl

# VIM
read -p "Install VIM from source [y/n]?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "\nInstaling Vim.."
  #sudo apt-get -y install vim-nox
  sudo apt-get -y install ncurses-dev
  cd /tmp
  git clone https://github.com/vim/vim.git
  cd vim/src
  make distclean
  ./configure --enable-python3interp=yes
  make
  sudo make install
  rm -rf /tmp/vim
  cd ~/dotfiles
fi

# Node and NPM
echo -e "\nInstalling Node..."
if [ "$(node -v | cut -c2-3)" -gt 18 ];
    then
        echo "Already running Node > 18.0.0 Skipping..."
    else
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/nodesource.list
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
  cd ~/dotfiles
fi


# Vundle
echo -e "\nInstalling Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# TPM
echo -e "\nInstalling TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ZSH
echo -e "\nInstalling ZSH..."
sudo apt-get install zsh -y

echo -e "\nInstalling Oh-My-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

echo -e "\nSetting ZSH as default shell..."
chsh -s $(which zsh)

# FISH
echo -e "\nInstalling FISH..."
sudo apt-get install fish -y

# LSD
echo -e "\nInstalling lsd..."
sudo apt-get -y install lsd

# Done
echo -e "\nDone!"
echo -e "\n##########Restart session to continue##########"
