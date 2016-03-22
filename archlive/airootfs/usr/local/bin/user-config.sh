#!/bin/bash
PKG=$HOME/GitHub/PKGBUILDs
yaourt -S google-chrome
git clone https://github.com/fusion809/PKGBUILDs $PKG
cd $PKG/atom-editor
makepkg -si --noconfirm
