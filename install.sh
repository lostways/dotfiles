#!/usr/bin/env bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
dry_run="0"

if [[ $1 == "--dry-run" ]]; then
    dry_run="1"
fi

log() {
    if [[ $dry_run == "1" ]]; then
        echo -e "[DRY_RUN] \033[1;33m$1\033[0m"
        return
    else
        echo -e "\033[1;32m$1\033[0m"
    fi
}


copy() {
    log "removing $2"
    if [[ $dry_run == "0" ]]; then
        rm $2
    fi

    log "Copying $1 to $2"
    if [[ $dry_run == "0" ]]; then
        cp $1 $2
    fi
}

copy_dir() {
    pushd $1
    to=$2
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d)
    for dir in $dirs; do
        directory=${2%/}/${dir#./}
        log "Removing $directory"
        if [[ $dry_run == "0" ]]; then
            rm -rf $directory
        fi

        log "Copying $dir to $directory"
        if [[ $dry_run == "0" ]]; then
	    mkdir -p $(dirname $directory)
	    cp -r $dir $(dirname $directory)
        fi
    done
    popd
}

export -f log
export -f copy
export -f copy_dir
export dry_run
export script_dir

log "script dir: $script_dir"

for script in "$@"; do
    log "Running $script"
    bash $script_dir/scripts/$script.sh
done
