# NVIM
# The official release build, apt's neovim is too old for the plugin config on
# Debian/Ubuntu LTS releases.

log "Installing dependencies..."
# git: lazy.nvim, make/gcc: telescope-fzf-native and treesitter parsers,
# unzip/curl: mason, python3-venv: mason python tools (basedpyright, black,
# isort), ripgrep: telescope live grep
sudo apt-get install -y git make gcc unzip curl python3-venv ripgrep

case $(uname -m) in
    x86_64) arch=x86_64; biome_arch=x64 ;;
    aarch64|arm64) arch=arm64; biome_arch=arm64 ;;
    *) log "ERROR: no neovim release build for $(uname -m)"; exit 1 ;;
esac

log "Installing Neovim ($arch)..."
curl -fL -o /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz"
sudo rm -rf /opt/nvim-linux-$arch
sudo tar -xzf /tmp/nvim.tar.gz -C /opt
rm /tmp/nvim.tar.gz
sudo ln -sf /opt/nvim-linux-$arch/bin/nvim /usr/local/bin/nvim
nvim --version | head -1

# biome formats JS/TS. mason's biome package needs npm, the release binary
# doesn't. The repo also releases other packages, so find the CLI's newest tag.
log "Installing Biome..."
biome_tag=$(curl -fsSL "https://api.github.com/repos/biomejs/biome/releases?per_page=30" \
    | grep -o '"tag_name": *"@biomejs/biome@[^"]*"' | head -1 | cut -d'"' -f4)
if [[ -n $biome_tag ]]; then
    biome_tag_url=$(printf '%s' "$biome_tag" | sed 's/@/%40/g; s|/|%2F|g')
    curl -fL -o /tmp/biome "https://github.com/biomejs/biome/releases/download/$biome_tag_url/biome-linux-$biome_arch"
    sudo install -m755 /tmp/biome /usr/local/bin/biome
    rm /tmp/biome
    biome --version
else
    log "ERROR: could not find the latest biome release, JS/TS won't format"
fi

# TypeScript 7 is a native (Go) build of tsc with a built-in language server,
# the JS/TS LSP without node. nvim-lspconfig's tsc config uses it and skips
# older node based tsc binaries that don't have the language server.
log "Installing TypeScript 7 (tsc)..."
ts_tag=$(curl -fsSL "https://api.github.com/repos/microsoft/typescript-go/releases?per_page=30" \
    | grep -o '"tag_name": *"typescript/v[^"]*"' | head -1 | cut -d'"' -f4)
if [[ -n $ts_tag ]]; then
    ts_tag_url=$(printf '%s' "$ts_tag" | sed 's|/|%2F|g')
    rm -rf /tmp/tsgo && mkdir /tmp/tsgo
    curl -fL -o /tmp/tsgo/ts.tgz "https://github.com/microsoft/typescript-go/releases/download/$ts_tag_url/typescript-linux-$biome_arch.tgz"
    tar -xzf /tmp/tsgo/ts.tgz -C /tmp/tsgo
    # tsc loads the lib*.d.ts files next to it, so keep the directory together
    sudo rm -rf /opt/typescript7
    sudo mv /tmp/tsgo/package /opt/typescript7
    sudo ln -sf /opt/typescript7/lib/tsc /usr/local/bin/tsc
    rm -rf /tmp/tsgo
    /usr/local/bin/tsc --version
else
    log "ERROR: could not find the latest TypeScript 7 release, no JS/TS language server"
fi

# nvim-treesitter compiles parsers with the tree-sitter CLI, it needs a newer
# one than Debian/Ubuntu ship and says not to use npm's
log "Installing tree-sitter CLI..."
curl -fL -o /tmp/tree-sitter.gz "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-$biome_arch.gz"
gunzip -f /tmp/tree-sitter.gz
sudo install -m755 /tmp/tree-sitter /usr/local/bin/tree-sitter
rm /tmp/tree-sitter
tree-sitter --version

# nvim-treesitter moved from its master branch to main. A master install keeps
# compiled parsers in the plugin dir, where they'd clash with main's queries,
# so remove it and let lazy install main fresh.
ts_dir="$HOME/.local/share/nvim/lazy/nvim-treesitter"
if [[ -f $ts_dir/lua/nvim-treesitter/configs.lua ]]; then
    log "Removing nvim-treesitter's old master branch install..."
    rm -rf "$ts_dir"
fi

log "Installing plugins..."
# restore installs the commits pinned in lazy-lock.json, sync would update them
nvim --headless "+Lazy! restore" +qa

log "Installing treesitter parsers..."
nvim --headless "+lua require('nvim-treesitter').install(vim.g.ts_parsers):wait(300000)" +qa

# Copilot is the only part of the config that needs node
log "Run :Copilot setup in nvim to sign in to GitHub Copilot (needs Node, ./install.sh npm)"
