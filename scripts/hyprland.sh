# Install hyprland and dependencies
log "Installing Hyprland and dependencies"
sudo apt install -y hyprland \
  waybar \
  wofi \
  hyprpaper \
  swayosd \
  dunst

sudo apt install -y build-essential cmake git meson ninja-build \
    libwayland-dev wayland-protocols libcairo2-dev libjpeg-dev \
    libpango1.0-dev libxkbcommon-dev libpugixml-dev

wget -O /tmp/hyprwayland-scanner.tar.gz https://github.com/hyprwm/hyprwayland-scanner/archive/refs/tags/v0.4.5.tar.gz
pushd /tmp
tar -xvf hyprwayland-scanner.tar.gz
cd hyprwayland-scanner-0.4.5
cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
sudo cmake --install build
cd ..
rm -rf hyprwayland-scanner.tar.gz
rm -rf /tmp/hyprwayland-scanner-0.4.5
popd

wget -O /tmp/hyprutils.tar.gz https://github.com/hyprwm/hyprutils/archive/refs/tags/v0.10.0.tar.gz
pushd /tmp
tar -xvf hyprutils.tar.gz
cd hyprutils-0.10.0
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build
rm -rf hyprutils.tar.gz
rm -rf /tmp/hyprutils-0.10.0
popd

# Add user to video group for brightness control
sudo usermod -aG video $USER

# Disable the swayosd service to avoid caps lock notification
sudo systemctl disable swayosd-libinput-backend.service
