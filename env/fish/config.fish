# Pyenv initialization
if command -v pyenv >/dev/null 2>&1
    pyenv init - fish | source
end

# Alias
alias vim="nvim"
alias reload-waybar="killall -SIGUSR2 waybar"
if type -q lsd
    alias ls="lsd"
    alias ll="lsd -alh"
    alias la="lsd -A"
else
    echo "lsd not found, skipping ls alias setup"
end

# add ~/.local/bin to PATH
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin

# add /.cargo/bin to PATH
fish_add_path $HOME/.cargo/bin

# Set TERMINAL to alacritty if it exists
if type -q alacritty
    set -Ux TERMINAL alacritty
end

# Setup PyEnv
set -Ux PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin
