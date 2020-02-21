#!/bin/bash

#/**
# * Uninstall ZSH
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# restore default shell
echo "chsh -s $(command -v bash)" &&
chsh -s $(command -v bash) &&
echo_success 'default shell restored'

# uninstall zsh
sudo apt-get purge -y zsh zsh-common &&
echo_success 'zsh uninstalled'

# cleaning
sudo apt -y autoremove &&
echo_success 'apt cache cleaned'
