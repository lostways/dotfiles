# Sourced from the end of ~/.bashrc (scripts/fish.sh adds the line).
#
# The login shell stays bash so scripts, ssh commands, scp and rsync get a
# POSIX shell, and a broken fish can't lock you out of a server. Interactive
# sessions hand off to fish. Run `bash` from fish, or set NO_FISH=1, to stay
# in bash.

# not interactive, nothing to do
case $- in
    *i*) ;;
      *) return;;
esac

# hand off to fish unless running a command (bash -c), started from fish,
# NO_FISH is set, or fish isn't installed
if [[ -z $BASH_EXECUTION_STRING && -z $NO_FISH ]] \
    && [[ $(cat /proc/$PPID/comm 2>/dev/null) != fish ]] \
    && command -v fish >/dev/null; then
    if shopt -q login_shell; then
        exec fish --login
    fi
    exec fish
fi
