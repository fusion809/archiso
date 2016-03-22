#!/bin/bash
ln -s /usr/share/zoneinfo/Australia/Brisbane /etc/localtime
/usr/bin/useradd -m -g wheel fusion809
mv /etc/locale2.gen /etc/locale.gen
locale-gen
GOODS=('broadcom-wl-dkms' 'bumblebee' 'docker' 'git' 'virtualbox' 'xf86-video-intel' 'xf86-video-nouveau' 'yaourt' 'zsh')
pacman -S plasma-meta kde-applications-meta $GOODS --noconfirm
usermod --groups="bumblebee docker video vboxusers" $USERNAME
GHUB=/home/$USERNAME/GitHub
ARCHS=$GHUB/arch-scripts
mkdir $GHUB
git clone https://github.com/fusion809/arch-scripts $ARCHS
cp -a $ARCHS/{Shell,.bashrc,.zshrc} /home/$USERNAME/
cp -a $ARCHS/root/{Shell,.bashrc,.zshrc} /root/
chsh -s /bin/zsh
chsh -s /bin/zsh $USERNAME
source ~/.bashrc
su -c "/usr/local/bin/user-config.sh" -l $USERNAME
