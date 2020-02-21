#!/bin/bash

#/**
# * Uninstall Powerline Fonts
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

apt-cache policy fonts-powerline &&
echo_success 'remove powerline fonts cache'

sudo apt purge -y fonts-powerline &&
echo_success 'powerline fonts uninstalled'
