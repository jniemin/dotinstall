#!/usr/bin/env bash

default="\033[39m"
black="\033[30m"
red="\033[0;31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
light_gray="\033[37m"
dark_gray="\033[90m"
light_red="\033[91m"
light_green="\033[92m"
light_yellow="\033[93m"
light_blue="\033[94m"
light_magenta="\033[95m"
light_cyan="\033[96m"
white="\033[97m"

info () {
  printf "\r  [ $cyan..$default ] $cyan$1$default\n"
}

debug () {
  printf "\r  [ $default.. ] $1$default\n"
}

user () {
  printf "\r  [ $light_yellow??$default ] $1\n"
}

success () {
  printf "\r\033[2K  [$green OK$default ] $green$1$default\n"
}

info "Preparing install juise's dotfiles"

if [ $# -ne 1 ] || [ "$1" != "-y" ];
    then
        user "Make sure your ssh private key is set, otherwise install is not able to download from private repository"
        read key;
fi

if test "$(uname)" = "Darwin"
	then
		info "Installing brew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		brew install git
fi
info "Cloning dotfiles"
install_dotdir="$HOME/.dotfiles"
git clone git@github.com:jniemin/dotfiles.git $install_dotdir
export PATH="$PATH:$install_dotdir/bin:"
dot zsh
success "Now quickly reboot and use \"dot\" command to install rest"
