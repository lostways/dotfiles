log "Installing LocalSend..."
sudo apt install gir1.2-appindicator3-0.1 gir1.2-ayatanaappindicator3-0.1 -y

wget -O /tmp/localsend.deb https://github.com/localsend/localsend/releases/download/v1.17.0/LocalSend-1.17.0-linux-x86-64.deb
sudo dpkg -i /tmp/localsend.deb
rm /tmp/localsend.deb
