# Install hyprland and dependencies
log "Installing Hyprland and dependencies"
sudo apt install -y hyprland \
  waybar \
  wofi \
  hyprpaper \
  swayosd \
  dunst \
  wl-clipboard \
  wlogout \
  network-manager \
  network-manager-applet

if ! sudo apt install -y build-essential cmake git meson ninja-build curl \
    libwayland-dev wayland-protocols libcairo2-dev libjpeg-dev \
    libpango1.0-dev libxkbcommon-dev libpugixml-dev libopengl-dev \
    libegl1-mesa-dev libgles2-mesa-dev libsdbus-c++-dev libdrm-dev \
    libgbm-dev libwebp-dev libmagic-dev librsvg2-dev libpam0g-dev; then
  log "ERROR: build dependencies failed to install, aborting"
  log "If apt reports unsatisfiable versions, the package lists may be stale or corrupt:"
  log "  sudo rm -rf /var/lib/apt/lists/* && sudo apt update"
  exit 1
fi

# Build and install the latest release of a hyprwm package from source.
# Returns non-zero (without aborting the whole script) if any stage fails.
install_hypr_pkg() {
  local name=$1
  local tag version rc=0

  tag=$(curl -sL "https://api.github.com/repos/hyprwm/$name/releases/latest" \
    | grep -Po '"tag_name":\s*"\K[^"]+')

  if [ -z "$tag" ]; then
    log "ERROR: could not fetch latest release tag for hyprwm/$name"
    return 1
  fi

  version=${tag#v}
  log "Installing $name $tag"

  if ! wget -O /tmp/$name.tar.gz "https://github.com/hyprwm/$name/archive/refs/tags/$tag.tar.gz"; then
    log "ERROR: failed to download hyprwm/$name $tag"
    return 1
  fi

  pushd /tmp > /dev/null || return 1

  if tar -xf $name.tar.gz && cd $name-$version; then
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build \
      && cmake --build ./build --config Release --target all -j$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF) \
      && sudo cmake --install build
    rc=$?
    cd ..
  else
    rc=1
  fi

  rm -rf $name.tar.gz $name-$version
  popd > /dev/null

  if [ $rc -ne 0 ]; then
    log "ERROR: build/install of $name $tag failed"
  fi
  return $rc
}

# Track failed packages so a broken build is reported loudly at the end
hypr_failures=()

install_hypr_pkg_checked() {
  install_hypr_pkg "$1" || hypr_failures+=("$1")
}

# Core libraries — hyprpicker and hyprlock link against these, so a failure here
# makes everything downstream fail too. Stop rather than emit a wall of errors.
for pkg in hyprwayland-scanner hyprutils hyprlang hyprgraphics; do
  if ! install_hypr_pkg $pkg; then
    log "ERROR: $pkg is a required dependency, aborting"
    exit 1
  fi
done

log "Installing hyprpicker (a color picker for Hyprland)"
install_hypr_pkg_checked hyprpicker

# Copy desktop file
copy $script_dir/env/applications/hyprpicker.desktop $HOME/.local/share/applications/hyprpicker.desktop

log "Installing hyprlock (a screen locker for Hyprland)"
install_hypr_pkg_checked hyprlock

# Add user to video group for brightness control
sudo usermod -aG video $USER

# Disable the swayosd service to avoid caps lock notification
sudo systemctl disable swayosd-libinput-backend.service

if [ ${#hypr_failures[@]} -ne 0 ]; then
  log "ERROR: the following packages failed to install: ${hypr_failures[*]}"
  exit 1
fi
