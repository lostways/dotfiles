# Install hyprland and dependencies
# Ubuntu's own hypr packages are frozen per release, the cppiber PPA tracks
# upstream releases for the whole hypr stack
# https://launchpad.net/~cppiber/+archive/ubuntu/hyprland
log "Adding Hyprland PPA"
sudo add-apt-repository -y ppa:cppiber/hyprland
sudo apt-get update

# Ubuntu's libhyprcursor0 and libudis86-0 ship the same files as the PPA's
# libhyprcursor1/libudis86.1 without the PPA declaring a conflict, so dpkg
# refuses to install over them. Swap out Ubuntu's hyprland stack first.
for pkg in libhyprcursor0 libudis86-0; do
  if dpkg -s $pkg >/dev/null 2>&1; then
    log "Removing Ubuntu's $pkg (conflicts with the PPA)"
    sudo apt-get remove -y $pkg
  fi
done

log "Installing Hyprland and dependencies"
sudo apt-get install -y hyprland \
  hyprpaper \
  hyprlock \
  hyprpicker \
  xdg-desktop-portal-hyprland \
  waybar \
  wofi \
  swayosd \
  dunst \
  wl-clipboard \
  wlogout \
  network-manager \
  network-manager-applet

# Add user to video group for brightness control
sudo usermod -aG video $USER

# Disable the swayosd service to avoid caps lock notification
sudo systemctl disable swayosd-libinput-backend.service
