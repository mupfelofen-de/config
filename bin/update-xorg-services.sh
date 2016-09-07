#! /usr/bin/env sh

mkdir -p ~/cfg/run/xorg
for svc in \
    compton \
    disk_indicator \
    mytaffybar \
    myxmonad \
    redshift \
    unclutter \
    urxvtd \
    xscreensaver
do
    mkdir -p ~/cfg/run/xorg/$svc
    ln -sf ~/cfg/my/services/$svc/run ~/cfg/run/xorg/$svc/run
done
ln -sf /run/current-system/sw/bin/true ~/cfg/run/xorg/.s6-svscan/finish
