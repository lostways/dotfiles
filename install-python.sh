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

grep -qxF 'source "$HOME/dotfiles/pyenv/.zprofile.pyenv"' ~/.zprofile || echo 'source "$HOME/dotfiles/pyenv/.zprofile.pyenv"' >> ~/.zprofile
grep -qxF 'source "$HOME/dotfiles/pyenv/.profile.pyenv"' ~/.profile || echo 'source "$HOME/dotfiles/pyenv/.profile.pyenv"' >> ~/.profile
grep -qxF 'source "$HOME/dotfiles/pyenv/.zshrc.pyenv"' ~/.zshrc.local || echo 'source "$HOME/dotfiles/pyenv/.zshrc.pyenv"' >> ~/.zshrc.local


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
pyenv install 3.11.4
pyenv rehash
pyenv global 3.11.4
pyenv versions

echo "Please restart your session to finish install \n"
