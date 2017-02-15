#!/bin/bash
#  Setup script for Ubuntu16.04.

set -xue

# utility
has() {
    type "$1" > /dev/null 2>&1
}

# update apt
yes | sudo apt update
yes | sudo apt upgrade

# Desktop
# env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

# develop
yes | sudo apt install build-essential nasm pkg-config linux-headers-generic cmake

# Util
yes | sudo apt install git tree pv zsh valgrind linux-tools-common powertop hwloc unzip

# rustup
[ ! -e "$HOME/.cargo" ] && curl https://sh.rustup.rs -sSf | sh

# ripgrep
if has cargo; then
    cargo install ripgrep
fi

# anyenv (git required)
#   anyenv's setup is in https://github.com/kubo39/dotfiles/setup.sh
if [ ! -e "$HOME/.anyenv" ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv
    mkdir -p ~/.anyenv/plugins
fi

if [ ! -e "$HOME/.anyenv/plugins/anyenv-update" ]; then
    git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
fi

# dotfiles (git required)
if [ ! -e "$HOME/dotfiles" ]; then
    git clone https://github.com/kubo39/dotfiles ~/dotfiles
    sh ~/dotfiles/setup.sh
fi

# .emacs.d (git required)
if [ ! -e "$HOME/.emacs.d" ]; then
    git clone https://github.com/kubo39/.emacs.d ~/.emacs.d
fi
