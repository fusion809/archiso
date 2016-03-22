#!/bin/bash
ln -s /usr/share/zoneinfo/Australia/Brisbane /etc/localtime
/usr/bin/useradd -m -g wheel fusion809
mv /etc/locale2.gen /etc/locale.gen
locale-gen
pacman -S plasma-meta kde-applications-meta --noconfirm
