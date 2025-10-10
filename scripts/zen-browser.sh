# Installation script for Zen Browser on Linux
# https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz
log "Installing Zen Browser..."

curl -L -o /tmp/zen.tar.xz https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz

sudo tar -xvf /tmp/zen.tar.xz -C /opt/
sudo ln -s /opt/zen/zen /usr/bin/zen
rm /tmp/zen.tar.xz

# Create a desktop entry
# echo "[Desktop Entry]
# Name=Zen Browser
# Comment=Browse the web with Zen Browser
# Exec=/opt/zen/zen
# Icon=/opt/zen/resources/app/icon.png
# Terminal=false
# Type=Application
# Categories=Network;WebBrowser;" | sudo tee /usr/share/applications/zen-browser.desktop
