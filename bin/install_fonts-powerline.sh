#!/bin/bash

#/**
# * Install fonts-powerline
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

{
    # install powerline fonts
    sudo apt-get install -y fonts-powerline &&
    echo_success 'powerline fonts installed'
} || {
    echo_error 'could not install fonts-powerline from apt-get'

    echo_info 'mkdir ~/.fonts-powerline'
    mkdir ~/.fonts-powerline

    echo_info 'git clone https://github.com/powerline/fonts.git ~/.fonts-powerline'
    git clone https://github.com/powerline/fonts.git ~/.fonts-powerline

    echo_info 'bash  ~/.fonts-powerline/install.sh'
    bash  ~/.fonts-powerline/install.sh

    echo_info 'rm -rf ~/.fonts-powerline'
    rm -rf ~/.fonts-powerline
}

