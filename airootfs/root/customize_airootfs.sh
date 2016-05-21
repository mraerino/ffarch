#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

#sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

### create additional group
groupadd sshusers
### create additional user
# useradd -m  -G sshusers,wheel -s /usr/bin/zsh -p CRYPTPWD freifunk

#systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target

### enable sshd
systemctl enable sshd.service

### enable dnsmasq
systemctl enable dnsmasq.service

### enable acpid
#systemctl enable acpid.service

systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service

### disable predictable interface names
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

### enable dnsmasq
systemctl enable dnsmasq.service


### export package list
pacman -Q > /root/packages_all.txt

### uninstall packages
#pacman -Rusn --noconfirm f2fs-tools jfsutils pcmciautils reiserfsprogs xfsprogs mdadm licenses cryptsetup man-db \
# man-pages s-nail vi perl
pacman -Q > /root/packages_less.txt

### remove docs and man
rm -rf /usr/share/doc/*
rm -rf /usr/share/man/*
rm -rf /var/log/pacman.log
rm -rf /var/cache/pacman/pkg/*
