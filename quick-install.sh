#!/bin/bash
if `which git > /dev/null`
if ! [[ -d $HOME/GitHub/mine/archiso ]]; then
  git clone https://github.com/fusion809/archiso $HOME/GitHub/mine/archiso
fi

sudo pacman -S archiso --noconfirm
if [[ -d /root/archlive ]]; then
  sudo rm -rf /root/archlive
fi

if [[ -d /root/customrepo ]]; then
  sudo rm -rf /root/customrepo
fi

sudo cp -a $HOME/GitHub/mine/archiso/archlive /root
sudo cp -a $HOME/GitHub/mine/archiso/customrepo /root
