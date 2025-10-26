log "Installing TableView..."
wget -O /tmp/tableview.deb https://github.com/shshemi/tabiew/releases/download/v0.11.1/tabiew-x86_64-unknown-linux-gnu.deb
sudo dpkg -i /tmp/tableview.deb
rm /tmp/tableview.deb
