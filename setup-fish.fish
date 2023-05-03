#!/usr/bin/fish

# Set Theme
fish_config theme choose "ayu Dark"

# Fisher
echo "\nInstalling Fisher..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Tide
echo "\nInstalling Tide Plugin"
fisher install IlanCosman/tide@v5
