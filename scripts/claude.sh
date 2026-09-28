# Claude Code, native installer. Installs to ~/.local/bin and keeps itself
# updated, so re-running this is only needed on a new machine.
log "Installing Claude Code..."
sudo apt-get install -y curl
curl -fsSL https://claude.ai/install.sh | bash
