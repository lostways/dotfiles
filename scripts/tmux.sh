# Install TMUX via apt
log "Installing TMUX via APT..."
sudo apt-get -y install tmux
tmux -V

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

# ==============
# Ensure TPM is installed
# ==============

log "Checking TPM..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "TPM not found, installing..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ==============
# Install tmux plugins
# ==============

log "Installing tmux plugins..."
tmux start-server
tmux new-session -d -s __temp
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-session -t __temp
