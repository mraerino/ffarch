#!/bin/sh
set DEVLABEL=/dev/disk/by-label/ffusb
mkfs.ext4 $DEVLABEL

grub-install --target=i386-pc --recheck --boot-directory=/mnt/boot $DEVLABEL
