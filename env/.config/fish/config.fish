# add ~/.local/bin to PATH
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/.local/scripts; and fish_add_path $HOME/.local/scripts

# add /.cargo/bin to PATH
fish_add_path $HOME/.cargo/bin

# Set TERMINAL to alacritty if it exists
if type -q alacritty
    set -Ux TERMINAL alacritty
end

# Setup PyEnv
set -Ux PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin

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

if type -q bat
    alias cat="bat"
else
    echo "bat not found, skipping cat alias setup"
end

# ./install.sh files changes this universal variable, which every open fish
# shell sees, so they all pick up the new config
function __dotfiles_reload_config --on-variable __dotfiles_reload
    source $HOME/.config/fish/config.fish
end
