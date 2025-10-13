# Alias
echo "Setting up aliases..."
alias --save vim="nvim"
alias --save reload-waybar="killall -SIGUSR2 waybar"
if type -q lsd
    alias --save ls="lsd"
    alias --save ll="lsd -alh"
    alias --save la="lsd -A"
else
    echo "lsd not found, skipping ls alias setup"
end

# add ~/.local/bin to PATH
echo "Adding ~/.local/bin to PATH..."
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin

# Setup PyEnv
echo "Setting up PyEnv..."
set -Ux PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin
