# ==============
# Install Fonts
# ==============

log "Installing fonts..."
if [ ! -d ~/.local/share/fonts ]; then
    mkdir -p ~/.local/share/fonts
fi
unzip -o $script_dir/fonts/Hack.zip -d ~/.local/share/fonts
fc-cache -f -v
