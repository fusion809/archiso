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
