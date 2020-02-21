#!/bin/bash

#/**
# * Install ZSH
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# check zsh installed
if [ -x "$(command -v zsh)" ]; then
    echo_warning 'zsh already installed'
else
    {
        # install zsh
        sudo apt-get install -y zsh &&
        echo_success 'zsh installed'
    } || {
        echo_error 'could not install zsh'
        exit 1
    }
fi
