# Install hyprland and dependencies
log "Installing Hyprland and dependencies"
sudo apt install -y hyprland \
  waybar \
  wofi \
  hyprpaper \
  swayosd \
  dunst \
  wl-clipboard \
  wlogout

sudo apt install -y build-essential cmake git meson ninja-build \
    libwayland-dev wayland-protocols libcairo2-dev libjpeg-dev \
    libpango1.0-dev libxkbcommon-dev libpugixml-dev libopengl-dev \
    libegl1-mesa-dev libgles2-mesa-dev libsdbus-c++-dev libdrm-dev \
    libgbm-dev libwebp-dev libmagic-dev librsvg2-dev libpam0g-dev


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
cd ..
rm -rf hyprutils.tar.gz
rm -rf /tmp/hyprutils-0.10.0
popd

wget -O /tmp/hyprlang.tar.gz https://github.com/hyprwm/hyprlang/archive/refs/tags/v0.6.4.tar.gz
pushd /tmp
tar -xvf hyprlang.tar.gz
cd hyprlang-0.6.4
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..
rm -rf hyprlang.tar.gz
rm -rf /tmp/hyprlang-0.6.4
popd

wget -O /tmp/hyprgraphics.tar.gz https://github.com/hyprwm/hyprgraphics/archive/refs/tags/v0.2.0.tar.gz
pushd /tmp
tar -xvf hyprgraphics.tar.gz
cd hyprgraphics-0.2.0
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprgraphics.tar.gz
rm -rf /tmp/hyprgraphics-0.2.0
popd

log "Installing hyprpicker (a color picker for Hyprland)"
wget -O /tmp/hyprpicker.tar.gz https://github.com/hyprwm/hyprpicker/archive/refs/tags/v0.4.5.tar.gz
pushd /tmp
tar -xvf hyprpicker.tar.gz
cd hyprpicker-0.4.5
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpicker -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprpicker.tar.gz
rm -rf /tmp/hyprpicker-0.4.5
popd

# Copy desktop file 
copy $script_dir/env/applications/hyprpicker.desktop $HOME/.local/share/applications/hyprpicker.desktop

log "Installing hyprlock (a screen locker for Hyprland)"
wget -O /tmp/hyprlock.tar.gz https://github.com/hyprwm/hyprlock/archive/refs/tags/v0.9.2.tar.gz
pushd /tmp
tar -xvf hyprlock.tar.gz
cd hyprlock-0.9.2
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
cd ..
rm -rf hyprlock.tar.gz
rm -rf /tmp/hyprlock-0.9.2
popd

# Add user to video group for brightness control
sudo usermod -aG video $USER

# Disable the swayosd service to avoid caps lock notification
sudo systemctl disable swayosd-libinput-backend.service
