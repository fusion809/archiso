function mountup {
  echo "Which partition do you want to install Arch on? e.g., /dev/sda1, /dev/sda3, /dev/sdb1, etc."
  read PART
  mount $PART /mnt
}

function pacsup {
  echo "Do you want to just install the base group of packages? (1) \nWould you also like to install base-devel group of packages? (2)"
  read opts
  if [[ $opts==1 ]]; then
    pacstrap /mnt base
  elif [[ $opts==2 ]]; then
    pacstrap /mnt base base-devel
  else
    echo "Please select one of the aforementioned options, either 1 or 2! Run `pacsup` again!"
  fi
}

function genf {
  genfstab -p /mnt >> /mnt/etc/fstab
}

function hostn {
  echo "What do you wish to call your PC?"
  read NAME
  echo "$NAME" >> /mnt/etc/hostname
}

function langn {
  echo "What language locale do you wish your PC to use? e.g., This ISO uses en_US.UTF-8."
  read LOCALE
  echo "LANG=$LOCALE" >> /mnt/etc/locale.conf
  cp -a /etc/pacman2.conf /mnt/etc/pacman.conf
}

function achroot {
  printf 'In this Arch Chroot of your new system you will need to set your timezone by running:\n
  ln -s /usr/share/zoneinfo/zone/subzone /etc/localtime\nFor example, for me in Queensland, Australia I would run\n
  ln -s /usr/share/zoneinfo/Australia/Brisbane /etc/localtime\n
  Then uncomment any locales you want in /etc/locale.gen (by removing the hashtag # before them) and run `locale-gen`.\n
  Optionally you can set your keymap or font preferences in /etc/vconsole.conf, edit your /etc/mkinitcpio.conf file (after which you should run\n
  `mkinitcpio -p linux`), set the root password (by running `passwd`), set up your user accounts (by running `useradd -m -g $USERNAME`),\n
  install a desktop environment (with `pacman -S $META` where `$META` is the name of the DEs metapackage), etc.'
  arch-chroot /mnt /bin/bash
}
