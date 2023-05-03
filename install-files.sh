#!/bin/fish

# Install Files

# VARS

PWD=`pwd`

# ==============
# Backup existing files
# ==============

mv ~/.vimrc ~/.vimrc.old
mv ~/.vim/plugins.vim.old
mv ~/.gitconfig.old
mv ~/.tmux.conf.old
mv ~/.config/fish/fish_variables.old

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
