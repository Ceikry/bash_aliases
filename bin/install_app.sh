#!/bin/bash

#/**
# * Install App
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
INSTALL_DIR=$(get_parameter 'install_dir' -f ${CONFIG})

# check git is installed
if [ ! -x "$(command -v git)" ]; then
    echo_error "cannot install TangoMan "bash_aliases": git is not installed"
    exit 1
fi

# check git directory
if [ -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
    echo_error "cannot install TangoMan "bash_aliases": not a git directory"
    exit 1
fi

{
    # create installation folder
    echo_info "mkdir -p ${INSTALL_DIR}" &&
    mkdir -p ${INSTALL_DIR} &&
    # copy files to installation folder
    echo_info "cp -r ../ ${INSTALL_DIR}" &&
    cp -r ../ ${INSTALL_DIR} &&
    # install bash aliases
    bash ${BASEDIR}/build_bash_aliases.sh &&
    bash ${BASEDIR}/install_bash_aliases.sh &&
    bash ${BASEDIR}/config_bash_aliases.sh
} && { 
    echo_success "TangoMan "bash_aliases" installed"
    bash ${BASEDIR}/reload_warning.sh
} || { 
    echo_warning 'could not copy files to installation folder'
}
