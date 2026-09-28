# Node and NPM from NodeSource (Ubuntu or Debian). Its nodejs package includes
# npm, Debian's own npm package pulls in hundreds of node-* packages.
node_major=24

log "Installing Node $node_major..."
installed=$(node -v 2>/dev/null | sed -E 's/^v([0-9]+).*/\1/')
if [[ -n $installed && $installed -ge $node_major ]]; then
    log "Node $(node -v) already installed, skipping"
    exit 0
fi

sudo apt-get install -y ca-certificates curl gnupg
sudo install -d -m755 /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor --yes -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$node_major.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list > /dev/null
sudo apt-get update
sudo apt-get install -y nodejs
node -v
npm -v
