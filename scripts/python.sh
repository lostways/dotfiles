#!/usr/bin/bash

# Install Python
python_version="3.13.7"

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
# Install Python with pyenv
# =================

pyenv update
pyenv install $python_version
pyenv rehash
pyenv global $python_version
pyenv versions

echo "Please restart your session to finish installation!"
