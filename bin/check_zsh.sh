#!/bin/bash

#/**
# * Check ZSH Installed
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

    # check .zshrc file present
    if [ ! -e ~/.zshrc ]; then
        echo_error '.zshrc file not found'
        exit 1
    fi

    # check oh-my-zsh installed
    if [ ! -d ~/.oh-my-zsh ]; then
        echo_error 'oh-my-zsh not installed'
        exit 1
    fi
else
    echo_error 'zsh not installed'
    exit 1
fi
