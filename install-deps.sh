# Installs dependancies for dotfiles


# CURL
sudo apt-get -y install curl

# VIM
sudo apt-get -y install vim


# Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Node and NPM
if which node > /dev/null
    then
        echo "node is installed, skipping..."
    else
        curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
        sudo apt-get install -y nodejs
fi

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


# Prettier
sudo npm install -g prettier

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ZSH
sudo apt-get -y install zsh

# Set ZSH to default shell
sudo chsh -s /usr/bin/zsh ${USER}

# Oh-My-ZSh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
