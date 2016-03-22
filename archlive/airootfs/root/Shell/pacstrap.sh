function pacsup {
  echo "Which partition do you want to install Arch on? e.g., /dev/sda1, /dev/sda3, /dev/sdb1, etc."
  read PART
  mount $PART /mnt
  echo "Do you want to just install the base group of packages? [y/n]"
  read yn
  if [[ $yn == y ]]; then
    pacstrap /mnt base
  else
    echo "What other groups of packages do you wish to install?"
    read $GROUPS
    pacstrap /mnt base $GROUPS
  fi
}
