#!/bin/bash

#/**
# * Config ZSH
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
        echo_error '.zshrc file does not exist'
    else

        # add hostname config if not present
        if [ -z "$(sed -n '/export\sHOSTNAME=$HOST/p' ~/.zshrc)" ];then
            cat >> ~/.zshrc <<EOF

# set HOSTNAME
export HOSTNAME=\$HOST
EOF
            echo_success 'HOSTNAME config added to .zshrc file'
        else
            echo_info '.zshrc file unchanged'
        fi

        # add DEFAULT_USER config if not present
        if [ -z "$(sed -n '/export\s$DEFAULT_USER=\".+\"/p' ~/.zshrc)" ];then
            cat >> ~/.zshrc <<EOF

# set DEFAULT_USER
export DEFAULT_USER="$USER"
EOF
            echo_success 'DEFAULT_USER config added to .zshrc file'
        else
            echo_info '.zshrc file unchanged'
        fi
    fi
fi

## make zsh default shell
#echo "chsh -s $(command -v zsh)" &&
#chsh -s $(command -v zsh) &&
#echo_success 'zsh set as defalut shell' &&
#echo_info 'You may need to restart your session'
