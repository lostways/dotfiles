# Installs dependancies for dotfiles

# Update apt sources
echo "\nUpdating APT Sources..."
sudo apt-get update

# CURL
echo "\nInstaling Curl.."
sudo apt-get -y install curl

# VIM
echo "\nInstaling Vim.."
if vim --cmd 'if v:version >= 802 | q | else | cq | fi' ;
  then
    # vim at least 8.2
    echo "Already running Vim > 8.2. Skipping..."
  else
    sudo apt-get install libncurses-dev
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure
    make
    sudo make install
    cd ..
    rm -rf vim
fi

# Node and NPM
echo "\nInstalling Node..."
if [ "$(node -v | cut -c2-3)" -gt 10 ];
    then
        echo "Already running Node > 10.0.0 Skipping..."
    else
        curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
        sudo apt-get install -y nodejs
fi

# TMUX
echo "\nInstalling TMUX"
TMUX_VERSION=$(tmux -V)
if [ "$TMUX_VERSION" = "tmux 2.6" ]; then
        echo "Tmux 2.6 already installed. skipping..."
    else
        # Tmux 2.6
        sudo apt-get -y remove tmux
        sudo apt-get -y install wget tar libevent-dev libncurses-dev

        VERSION=2.6
        wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
        tar xf tmux-${VERSION}.tar.gz
        rm -f tmux-${VERSION}.tar.gz
        cd tmux-${VERSION}
        ./configure
        make
        sudo make install
        cd -
        sudo rm -rf /usr/local/src/tmux-\*
        sudo mv tmux-${VERSION} /usr/local/src
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
git clone git@github.com:vaniacer/sshto.git
cd sshto
mv sshto ../utils/
cd ..
rm -rf sshto

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
