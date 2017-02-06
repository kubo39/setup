#!/bin/bash
#  Setup script for Ubuntu16.04.

# FIXME: remove 'e'?
set -xue

# update apt
yes | sudo apt update
yes | sudo apt upgrade

# Desktop
# env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

# develop
yes | sudo apt install build-essential nasm

# Util
yes | sudo apt install git tree pv zsh valgrind linux-tools-common powertop hwloc

# rustup (curl required)
[ ! -e "$HOME/.cargo" ] && curl https://sh.rustup.rs -sSf | sh

# anyenv (git required)
#   anyenv's setup is in https://github.com/kubo39/dotfiles/setup.sh
[ ! -e "$HOME/.anyenv" ] && git clone https://github.com/riywo/anyenv ~/.anyenv
mkdir -p ~/.anyenv/plugins
if [ ! -e "$HOME/.anyenv/plugins" ]; then
    git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
fi

# dotfiles
if [ ! -e "$HOME/dotfiles" ]; then
    git clone https://github.com/kubo39/dotfiles ~/dotfiles
    sh ~/dotfiles/setup.sh
fi
