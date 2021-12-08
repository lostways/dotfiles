# Installs dependancies for dotfiles

# Update apt sources
echo "\nUpdating APT Sources..."
sudo apt-get update

# CURL
echo "\nInstaling Curl.."
sudo apt-get -y install curl

# CTAGS
echo "\nInstaling Ctags.."
sudo apt-get -y install ctags

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
echo "\nInstalling Node..."
if [ "$(node -v | cut -c2-3)" -gt 16 ];
    then
        echo "Already running Node > 16.0.0 Skipping..."
    else
        curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
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
echo "\nInstalling Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# TPM
echo "\nInstalling TPM..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# SSHTO
echo "\nInstalling SSHTO"
sudo apt-get install -y dialog
cd /tmp
git clone git@github.com:vaniacer/sshto.git
cd sshto
mv sshto ~/dotfiles/utils/
rm -rf /tmp/sshto
cd ~/dotfiles

# ZSH
echo "\nInstalling ZSH..."
sudo apt-get -y install zsh

# Set ZSH to default shell
echo "\nSet ZSH as default shell..."
sudo chsh -s /usr/bin/zsh ${USER}

# Oh-My-ZSh
echo "\nInstalling OhMyZsh.."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# Restart session
exec zsh
