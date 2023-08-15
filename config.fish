# Pyenv
#set -Ux PYENV_ROOT $HOME/.pyenv
#set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
#pyenv init - | source

# LSD
if type -q lsd
  alias ll "lsd -l -a"
  alias lla "ll --tree --depth=2"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
