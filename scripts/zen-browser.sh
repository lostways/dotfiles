# Installation script for Zen Browser on Linux
# https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz
log "Installing Zen Browser..."

curl -L -o /tmp/zen.tar.xz https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz

sudo tar -xvf /tmp/zen.tar.xz -C /opt/
sudo rm -f /usr/bin/zen
sudo ln -s /opt/zen/zen /usr/bin/zen
rm /tmp/zen.tar.xz

#copy $script_dir/env/applications/zen-browser.desktop /usr/share/applications/zen-browser.desktop

