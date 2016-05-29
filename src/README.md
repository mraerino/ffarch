# Freifunk Local Batman Master

## What is it?
The generated ISO turns x64 hardware in an local batman-adv master for a small mesh. It is based on archiso.

## Building

Needs: `archiso` package

```
$ git submodule init
$ git submodule update

$ sh -c "cd localrepo/batman-adv && makepkg -sr"
$ sh -c "cd localrepo/batctl && makepkg -sr"
$ mkdir /tmp/localrepo
$ repo-add /tmp/localrepo/ff-repo.db.tar.gz localrepo/**/*.pkg.tar.xz

$ sudo ./build.sh
```

## Configuration
We assume that the used hardware has only one nic.

###eth0
Purpose: Management Interface

Configuration: RFC1918 IPv4 via DHCP without Gateway

###Vlan 11
Purpose: WAN Interface

Configuration: RFC1918 IPv4 via DHCP and IPv6 with RA

###Vlan 12
Purpose: Batman-ADV Interface

Configuration: Static IP: 172.16.0.1/22 and DNS, DHCP

## Problems & Hints
- Please check your file permissions (755) for airootfs and subdirectories

## ToDo

### High Priority
* Test test test
* disable routing over eth0 if gateway send via dhcp
* check dnsmasq configuration

### Medium Priority
* IPv6 support
* Auto Updater
* usb multiboot
* set hostname by mac

### Low Priority
* uefi support
* remote syslog
* collectd
* cleanup
