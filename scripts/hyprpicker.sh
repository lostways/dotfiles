# Description: Install hyprpicker (a color picker for Hyprland)
# Requires: Hyperland

wget -O /tmp/hyprpicker.tar.gz https://github.com/hyprwm/hyprpicker/archive/refs/tags/v0.4.5.tar.gz
pushd /tmp
tar -xvf hyprpicker.tar.gz
cd hyprpicker-0.4.5
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpicker -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
sudo cmake --install build
rm -rf hyprpicker.tar.gz
rm -rf /tmp/hyprpicker-0.4.5
popd

# Copy desktop file 
copy $script_dir/env/applications/hyprpicker.desktop $HOME/.local/share/applications/hyprpicker.desktop
