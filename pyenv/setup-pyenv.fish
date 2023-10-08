set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
echo 'eval (pyenv init - | source)' >> ~/.config/fish/config.fish
