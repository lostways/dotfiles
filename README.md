# dotfiles
get them dots

```
./install.sh [--dry-run] <profile|script>...
```

## Profiles

| Profile | For | Runs |
|---|---|---|
| `cli` | servers and desktops (Ubuntu or Debian) | utils, files, fish, tmux, nvim, gh |
| `desktop` | Hyprland desktop (Ubuntu) | everything in `cli`, then fonts, hyprland, files, system, yazi, wiremix, zen-browser |

Any script in `scripts/` can also be run by name, e.g. `./install.sh docker python`.
Extras that no profile runs: claude, docker, gimp, inkdrop, localsend, npm, python, rust, sshd, tableview, zsh.

`--dry-run` only covers `files` and `system`, other scripts still install packages.

## Layout

- `cli/`, `desktop/`: GNU Stow packages mirroring `$HOME`. `files` links `cli`
  everywhere and `desktop` where Hyprland is installed. Existing files in the
  way are kept as `<file>.bak`.
- `etc/`: drop-ins copied into `/etc` by `system` (not linked, they're root owned).
- The login shell stays bash; `fish` adds one line to the system's `~/.bashrc`
  that hands interactive sessions off to fish. `NO_FISH=1` or running `bash`
  from fish stays in bash.
