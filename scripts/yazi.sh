# yazi - a tui file manager
log "Installing Yazi file manager..."

# Dependencies
sudo apt-get install -y ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick unzip curl gnupg

# ueberzugpp (image previews) isn't in Ubuntu/Debian, its author publishes it
# per release on the openSUSE build service
. /etc/os-release
case $ID in
    ubuntu) obs_dist="xUbuntu_$VERSION_ID" ;;
    debian) obs_dist="Debian_$VERSION_ID" ;;
    *) obs_dist="" ;;
esac
obs_url="https://download.opensuse.org/repositories/home:/justkidding/$obs_dist"
if [[ -n $obs_dist ]] && curl -fsIL -o /dev/null "$obs_url/Release.key"; then
    log "Adding ueberzugpp repo ($obs_dist)..."
    sudo install -d -m755 /etc/apt/keyrings
    curl -fsSL "$obs_url/Release.key" | gpg --dearmor | sudo tee /etc/apt/keyrings/home_justkidding.gpg > /dev/null
    # replace any earlier entry for this repo, e.g. one for an older release
    sudo rm -f /etc/apt/sources.list.d/home:justkidding.list /etc/apt/sources.list.d/home:justkidding.sources /etc/apt/trusted.gpg.d/home_justkidding.gpg
    echo "deb [signed-by=/etc/apt/keyrings/home_justkidding.gpg] $obs_url/ /" | sudo tee /etc/apt/sources.list.d/home_justkidding.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y ueberzugpp
else
    log "No ueberzugpp build for ${obs_dist:-$ID}, skipping image previews"
fi

# Download and install yazi
case $(uname -m) in
    x86_64) arch=x86_64 ;;
    aarch64|arm64) arch=aarch64 ;;
    *) log "ERROR: no yazi release build for $(uname -m)"; exit 1 ;;
esac
pushd /tmp > /dev/null
rm -rf yazi-$arch-unknown-linux-gnu yazi.zip
curl -fL -o yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-$arch-unknown-linux-gnu.zip
unzip -q yazi.zip
sudo install -m755 yazi-$arch-unknown-linux-gnu/yazi yazi-$arch-unknown-linux-gnu/ya /usr/local/bin/
rm -rf yazi-$arch-unknown-linux-gnu yazi.zip
popd > /dev/null
yazi --version
