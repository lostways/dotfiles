# yazi - a tui file manager written
log "Installing Yazi file manager..."

# Dependencies
sudo apt install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick

echo 'deb http://download.opensuse.org/repositories/home:/justkidding/xUbuntu_25.04/ /' | sudo tee /etc/apt/sources.list.d/home:justkidding.list
curl -fsSL https://download.opensuse.org/repositories/home:justkidding/xUbuntu_25.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_justkidding.gpg > /dev/null
sudo apt update
sudo apt install -y ueberzugpp

# Download and install yazi
pushd /tmp
wget https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi-x86_64-unknown-linux-gnu.zip
sudo mv ./yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin/
sudo mv ./yazi-x86_64-unknown-linux-gnu/ya /usr/local/bin/
rm -rf ./yazi-x86_64-unknown-linux-gnu
popd
