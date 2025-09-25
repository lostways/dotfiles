#!/usr/bin/bash

# Install Python

# ================
# Install build deps for pyenv
# ================

sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# ================
# Run pyenv installer
# ================

curl https://pyenv.run | bash

# =================
# setup dot files
# =================

grep -qxF 'source "$HOME/pyenv/.zprofile.pyenv"' ~/.zprofile || echo 'source "$HOME/pyenv/.zprofile.pyenv"' >> ~/.zprofile
grep -qxF 'source "$HOME/pyenv/.profile.pyenv"' ~/.profile || echo 'source "$HOME/pyenv/.profile.pyenv"' >> ~/.profile
grep -qxF 'source "$HOME/pyenv/.zshrc.pyenv"' ~/.zshrc.local || echo 'source "$HOME/pyenv/.zshrc.pyenv"' >> ~/.zshrc.local

# if we are in a fish shell
if [ -f ~/.config/fish/config.fish ]; then
    grep -qxF 'pyenv init - fish | source' ~/.config/fish/config.fish || echo 'pyenv init - fish | source' >> ~/.config/fish/config.fish
fi

# =================
# Restart shell
# =================

source ~/.zprofile
source ~/.profile
source ~/.zshrc

# =================
# Install Python with pyenv
# =================

pyenv update
pyenv install 3.13.7
pyenv rehash
pyenv global 3.13.7
pyenv versions

echo "Please restart your session to finish install \n"
