#!/bin/bash
## Time Zone
echo "What timezone do you live in? This will be used to set your local time. For example, if you lived in Brisbane or elsewhere in Queensland\n
you would type Australia/Brisbane"
read TIMEZONE
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

## User Account
echo "Do you want to set up a user account? [y/n]"
read yn
if [[ $yn == 'y' ]]; then
  echo "Which username would you like this account to have?"
  read USERNAME
  echo "Which group(s) do you want this account to belong to? I would recommend `wheel` being amongst them."
  read GROUP
  /usr/bin/useradd -m -g $GROUP $USERNAME
fi

## Locales
echo "Do you want my locales, which are Australia-centric? [y/n]"
read yn2
if [[ $yn2 == 'y' ]]; then
  mv /etc/locale2.gen /etc/locale.gen
  locale-gen
elif [[ $yn2 == 'n' ]]; then
  rm /etc/locale2.gen
  nano /etc/locale.gen
  locale-gen
fi

## Desktop Environments
echo "What desktop environment do you want?\n Accepted answers are: DDE, GNOME, KDE, LXDE, Xfce and None."
read DE
if [[ $DE == 'DDE' ]]; then
  pacman -S deepin deepin-extra xorg --noconfirm
elif [[ $DE == 'GNOME' ]]; then
  pacman -S gnome gnome-extra xorg --noconfirm
elif [[ $DE == 'KDE' ]]; then
  pacman -S plasma-meta kde-applications-meta xorg --noconfirm
elif [[ $DE == 'LXDE' ]]; then
  pacman -S lxde xorg --noconfirm
elif [[ $DE == 'Xfce' ]]; then
  pacman -S xfce xfce-goodies xorg --noconfirm
elif [[ $DE == 'none' ]]; then
  echo "OK, suit yourself."
fi

echo "What is your graphics card(s) type? Valid options are NVIDIA, Intel and Both."
read GRAPHICS
if [[ $GRAPHICS == 'NVIDIA' ]]; then
  echo "What's your pleasure, the proprietary NVIDIA driver or FOSS Nouveau driver? Valid options are either NVIDIA or Nouveau."
  read NVIDIA
  if [[ $NVIDIA == 'NVIDIA' ]]; then
    pacman -S nvidia-dkms --noconfirm
    gpasswd -a $USERNAME video
  elif [[ $NVIDIA == 'Nouveau' ]]; then
    pacman -S xf86-video-nouveau --noconfirm
    gpasswd -a $USERNAME video
  fi
elif [[ $GRAPHICS == 'Intel' ]]; then
  pacman -S xf86-video-intel --noconfirm
  gpasswd -a $USERNAME video
elif [[ $GRAPHICS == 'Both' ]]; then
  pacman -S xf86-video-intel xf86-video-nouveau bumblebee --noconfirm
  usermod --groups="bumblebee video" $USERNAME
fi

## Do you want my goody bag of applications?
echo "Do you want my goody bag of applications? Valid options are y, n and list (which will list all these applications)."
read GOODIES
GOODS=('broadcom-wl-dkms' 'docker' 'git' 'virtualbox' 'yaourt' 'zsh')
if [[ $GOODIES == 'y' ]]; then
  pacman -S $GOODS --noconfirm
  usermod --groups="docker vboxusers" $USERNAME
elif [[ $GOODIES == 'n' ]]; then
  echo "OK; suit yourself."
elif [[ $GOODIES == 'list' ]]; then
  for i in $GOODS
  do
    echo $i
  done
fi
