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

#systemctl enable pacman-init.service choose-mirror.service
systemctl set-default multi-user.target

### enable sshd
systemctl enable sshd.service
chown -R root:root /root/.ssh

### enable dnsmasq
systemctl enable dnsmasq.service

### enable acpid
systemctl enable acpid.service

### enable batman-adv
systemctl enable batman-adv.service

### enable beep
systemctl enable beep.service

systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service

### enable wol for interface eth0
systemctl enable wol@eth0.service

### disable predictable interface names
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules


### enable customized firewall
systemctl enable ferm.service

### enable new hostname
#systemctl enable hostname-by-mac.service

### lm_sensors autodetct
systemctl enable sensors-detect.service

### export package list
pacman -Q > /root/packages_all.txt

### uninstall packages
pacman -Rusn --noconfirm cryptsetup jfsutils mdadm man-db man-pages \
 netctl pcmciautils perl reiserfsprogs s-nail xfsprogs vi netctl 
#memtest86+
pacman -Q > /root/packages_less.txt

### remove docs and man
rm -rf /usr/share/doc/*
rm -rf /usr/share/man/*
rm -rf /var/log/pacman.log
rm -rf /var/cache/pacman/pkg/*
