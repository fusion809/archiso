#!/bin/bash
echo "What timezone do you live in? This will be used to set your local time. For example, if you lived in Brisbane or elsewhere in Queensland\n
you would type Australia/Brisbane"
read TIMEZONE
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime
echo "Do you want to set up a user account? [y/n]"
read yn
if [[ $yn == y ]]; then
  echo "Which username would you like this account to have?"
  read USERNAME
  echo "Which group(s) do you want this account to belong to? I would recommend `wheel` being amongst them."
  read GROUP
  /usr/bin/useradd -m -g $GROUP $USERNAME
fi
echo "Do you want my locales, which are Australia-centric? [y/n]"
read yn2
if [[ $yn2 == y ]]; then
  mv /etc/locale2.gen /etc/locale.gen
  locale-gen
elif [[ $yn2 == n ]]; then
  rm /etc/locale2.gen
  nano /etc/locale.gen
  locale-gen
fi
