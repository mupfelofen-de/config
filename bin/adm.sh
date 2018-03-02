#! /bin/sh

set -o errexit -o nounset

case "$HOSTNAME" in
    elara)
        ext_part_num=1;;

    *) echo "Host $HOSTNAME not configured." >&2
       exit 1
esac

case "$*" in
    "md on")
        for arr in base efi; do
            mdadm /dev/md/"$HOSTNAME"-$arr --re-add /dev/disk/by-partlabel/"$HOSTNAME"-$arr$ext_part_num || true
        done
        ;;

    "md off")
        for arr in base efi; do
            for op in fail remove; do
                mdadm /dev/md/"$HOSTNAME"-$arr --$op /dev/disk/by-partlabel/"$HOSTNAME"-$arr$ext_part_num || true
            done
        done
        ;;

    "backup mount")
        cd /root/backup
        ./backup.sh -o
        ;;

    "backup run")
        cd /root/backup
        ./backup.sh -Sbd
        ;;

    "backup unmount")
        cd /root/backup
        ./backup.sh -c
        ;;

    *) echo "Unknown command" >&2
       exit 1
esac
