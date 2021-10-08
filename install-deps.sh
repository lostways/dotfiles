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
echo "\nInstaling Vim.."
sudo apt-get -y install vim-nox

# Node and NPM
echo "\nInstalling Node..."
if [ "$(node -v | cut -c2-3)" -gt 12 ];
    then
        echo "Already running Node > 12.0.0 Skipping..."
    else
        curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        sudo apt-get install -y nodejs
fi

# TMUX
echo "\nInstalling TMUX"
sudo apt-get -y install tmux

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
