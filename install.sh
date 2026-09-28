#!/usr/bin/env bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dry_run="0"

if [[ $1 == "--dry-run" ]]; then
    dry_run="1"
    shift
fi

log() {
    if [[ $dry_run == "1" ]]; then
        echo -e "[DRY_RUN] \033[1;33m$1\033[0m"
        return
    else
        echo -e "\033[1;32m$1\033[0m"
    fi
}


export -f log
export dry_run
export script_dir

log "script dir: $script_dir"

for script in "$@"; do
    log "Running $script"
    bash $script_dir/scripts/$script.sh
done
