# GitHub CLI
log "Installing GitHub CLI..."
sudo apt-get install -y gh

# Check if already authenticated
log "Authenticating GitHub CLI..."
if gh auth status > /dev/null 2>&1; then
  log "GitHub CLI is already authenticated."
elif [ -t 0 ]; then
  gh auth login
else
  # the login flow needs someone at a terminal
  log "Not a terminal, skipping login. Run gh auth login later."
fi
