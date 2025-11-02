# GitHub CLI
log "Installing GitHub CLI..."
sudo apt-get install -y gh

# Check if already authenticated
log "Authenticating GitHub CLI..."
if ! gh auth status > /dev/null 2>&1; then
  gh auth login
else
  log "GitHub CLI is already authenticated."
fi
