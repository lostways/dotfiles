# NVIM
# The official release build, apt's neovim is too old for the plugin config on
# Debian/Ubuntu LTS releases.

log "Installing dependencies..."
# git: lazy.nvim, make/gcc: telescope-fzf-native and treesitter parsers,
# unzip/curl: mason, ripgrep: telescope live grep
sudo apt-get install -y git make gcc unzip curl ripgrep

case $(uname -m) in
    x86_64) arch=x86_64 ;;
    aarch64|arm64) arch=arm64 ;;
    *) log "ERROR: no neovim release build for $(uname -m)"; exit 1 ;;
esac

log "Installing Neovim ($arch)..."
curl -fL -o /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz"
sudo rm -rf /opt/nvim-linux-$arch
sudo tar -xzf /tmp/nvim.tar.gz -C /opt
rm /tmp/nvim.tar.gz
sudo ln -sf /opt/nvim-linux-$arch/bin/nvim /usr/local/bin/nvim
nvim --version | head -1

log "Installing plugins..."
# restore installs the commits pinned in lazy-lock.json, sync would update them
nvim --headless "+Lazy! restore" +qa

log "Run :Copilot setup in nvim to sign in to GitHub Copilot (needs Node, ./install.sh npm)"
