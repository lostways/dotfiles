#!/usr/bin/env fish

# Set Theme
#fish_config theme choose "ayu Dark"

# Fisher, bootstrapped for this session. fish_plugins lists fisher itself, so
# `fisher update` installs it for good.
if not functions -q fisher
    echo "Installing Fisher..."
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
end

# Install exactly the plugins listed in ~/.config/fish/fish_plugins
echo "Installing plugins from fish_plugins..."
fisher update
