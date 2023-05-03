#!/usr/bin/fish

# Install Files

# VARS

PWD=`pwd`

# ==============
# Backup existing files
# ==============

mv ~/.vimrc ~/.vimrc.old
mv ~/.vim/plugins.vim.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.config/fish/fish_variables ~/.config/fish/fish_variables.old

# =============
# Fish Plugins
# =============

# Fisher
echo "\nInstalling Fisher..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher

# Tide
echo "\nInstalling Tide Plugin"
fisher install IlanCosman/tide@v5

# ==============
# Create symlinks to files
# ==============

ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.vim/plugins.vim ~/.vim/plugins.vim
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.tmux.conf ~/.tmux.conf
ln -sf $PWD/fish_variables ~/.config/fish/fish_variables

# ==============
# Reload tmux config
# ==============

tmux source-file ~/.tmux.conf

# ==============
# Install Vim Plugins
# ==============

vim +PluginClean +PluginInstall +PluginUpdate +qall

# ==============
# Finish CoC install
# ==============

cd ~/.vim/bundle/coc.nvim
npm install


cd $PWD
