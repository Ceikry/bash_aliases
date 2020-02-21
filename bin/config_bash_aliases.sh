#!/bin/bash

#/**
# * Config TangoMan bash_aliases
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/yaml.sh

CONFIG=${BASEDIR}/../config/config.yaml
AUTHOR=$(get_parameter 'author' -f ${CONFIG})
APP_NAME=$(get_parameter 'app_name' -f ${CONFIG})

# create .bashrc when not present
if [ ! -e ~/.bashrc ]; then
    echo_info 'touch ~/.bashrc' &&
    touch ~/.bashrc &&
    echo_success '".bashrc" file created' ||
    echo_error 'could not create ".bashrc" file'
fi

# add config if not present
if [ -z "$(sed -n '/\.\s~\/\.bash_aliases/p' ~/.bashrc)" ];then
    cat >> ~/.bashrc <<EOF

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
    echo_success 'TangoMan "bash_aliases" config added to .bashrc file'
else
    echo_info "info: .bashrc file unchanged"
fi

# check zsh installation
if [ -x "$(command -v zsh)" ]; then

    # append .zshrc config if present
    if [ ! -e ~/.zshrc ]; then
        echo_error 'file .zshrc does not exit'
    else
        # add hostname config if not present
        if [ -z "$(sed -n '/export\sHOSTNAME=${HOST}/p' ~/.zshrc)" ];then
            cat >> ~/.zshrc <<EOF

# set HOSTNAME
export HOSTNAME=\${HOST}
EOF
            echo_success 'HOSTNAME config added to .zshrc file'
        else
            echo_info '.zshrc file unchanged'
        fi

        # add config if not present
        if [ -z "$(sed -n '/\.\s~\/\.bash_aliases/p' ~/.zshrc)" ];then
            cat >> ~/.zshrc <<EOF

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
            echo_success 'TangoMan "bash_aliases"config added to .zshrc file'
        else
            echo_info '.zshrc file unchanged'
        fi

    fi
fi
