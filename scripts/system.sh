# ==============
# Install system config files from etc/ into /etc
# ==============
# Files are copied, not linked, since they are root owned and read by system
# services. Only add drop-ins (*.d directories), never replace distro files.

changed=()

log "Installing system config files..."
pushd $script_dir/etc > /dev/null
while IFS= read -r -d '' file; do
    rel=${file#./}
    target="/etc/$rel"

    if cmp -s "$file" "$target"; then
        continue
    fi

    log "Installing $target"
    if [[ $dry_run == "0" ]]; then
        sudo install -Dm644 "$file" "$target"
    fi
    changed+=("$rel")
done < <(find . -type f -print0)
popd > /dev/null

if [ ${#changed[@]} -eq 0 ]; then
    log "System config files already up to date"
fi

# Reload whatever the changed files affect
for rel in "${changed[@]}"; do
    case $rel in
        systemd/logind.conf.d/*)
            reload_logind=1
            ;;
    esac
done

if [[ -n $reload_logind ]]; then
    # SIGHUP re-reads the config, restarting logind would end the session
    log "Reloading systemd-logind..."
    if [[ $dry_run == "0" ]]; then
        sudo systemctl kill -s HUP systemd-logind
    fi
fi
