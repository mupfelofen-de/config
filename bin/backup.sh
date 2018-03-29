#! /bin/sh

set -o errexit -o nounset


backup_close() {
    ! mountpoint -q /media/backup || umount /media/backup
    [[ ! -b /dev/backup/"$(hostname)" ]] || vgchange -qq -an backup
    [[ ! -b /dev/mapper/enc-backup ]] || cryptsetup close enc-backup
    [[ ! -b /dev/md/backup ]] || mdadm -q --stop /dev/md/backup
}


backup_open() {
    [[ -b /dev/md/backup ]] || \
        mdadm -q --assemble /dev/md/backup
    [[ -b /dev/mapper/enc-backup ]] || \
        cryptsetup open -d ~/backup/key /dev/md/backup enc-backup
    [[ -b /dev/backup/"$(hostname)" ]] ||
        vgchange -qq -ay backup
    mountpoint -q /media/backup ||
        mount /media/backup
    if [[ ! -f /media/backup/.token ]]; then
        echo "Token file missing" >&2
        exit 1
    fi
}


backup_run() {
    if mountpoint -q /media/backup
    then was_open=y
    else was_open=""; fi

    backup_open

    if ! sha512sum --quiet -c ~/backup/token.sha512; then
        echo "Token file hash mismatch" >&2
        [[ -n $was_open ]] || backup_close
        exit 1
    fi

    ionice -c3 ~/.nix-profile/sbin/btrbk \
        -c ~/cfg/my/btrbk."$(hostname)".conf \
        "$@" \
        run
    [[ -n $was_open ]] || backup_close
}


case "$*" in
    close) backup_close;;
    open)  backup_open;;
    run)   backup_run -q;;
    runi)  backup_run --progress;;
    *)
        echo "$0 {close|open|run}"
        exit 1;;
esac
