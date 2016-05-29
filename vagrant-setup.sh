#!/bin/sh

mkdir -p /build
rsync -r /vagrant/src/* /build/

cd /build

pacman -Sy
pacman -S --noconfirm --needed base-devel

chmod a+x .
chown -R vagrant:vagrant localrepo

sudo -u vagrant sh -c "cd localrepo/batman-adv && makepkg -sr"
sudo -u vagrant sh -c "cd localrepo/batctl && makepkg -sr"

mkdir -p /tmp/localrepo
cp -r localrepo/**/*.pkg.tar.xz /tmp/localrepo/
repo-add /tmp/localrepo/ff-repo.db.tar.gz /tmp/localrepo/*.pkg.tar.xz

pacman -S --noconfirm archiso

chmod -R 755 airootfs
