#!/bin/bash

#/**
# * Check Update TangoMan bash_aliases
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
APP_VERSION=$(get_parameter 'app_version' -f ${CONFIG})

# check git is installed
if [ ! -x "$(command -v git 2>/dev/null)" ]; then
    echo_error 'git required, enter: "sudo apt-get install -y git" to install'
    exit 1
fi

# check git directory
if [ -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    echo_error 'cannot update TangoMan "bash_aliases": not a git directory'
    exit 1
fi

# listing latest tags from remote repository
git fetch --tags &>/dev/null
LATEST_VERSION="$(git tag --list | tail -1)"

if [ -n "${LATEST_VERSION}" ]; then
    if [ "${APP_VERSION}" != "${LATEST_VERSION}" ]; then
        echo_info 'update available for TangoMan "bash_aliases"'
        echo_warning "your version:   ${APP_VERSION}"
        echo_success "latest version: ${LATEST_VERSION}"
        echo_info 'enter "tango-update" in your terminal'
    else
        echo_success 'your version of TangoMan "bash_aliases" is up-to-date'
        exit 0
    fi
else
    echo_error 'could not check TangoMan "bash_aliases" latest available version'
    exit 1
fi

