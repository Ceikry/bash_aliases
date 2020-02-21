#!/bin/bash

#/**
# * Initialize TangoMan bash_aliases config
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/yaml.sh
. ${BASEDIR}/../tools/tools.sh

CONFIG_DIST=${BASEDIR}/../config/config.yaml.dist
CONFIG=${BASEDIR}/../config/config.yaml

if [ -f "${CONFIG}" ]; then
    exit 0
fi

echo_title 'TangoMan bash_aliases Config'
echo
echo_primary 'Please set your bash_aliases config:'
echo

DEFAULT_GIT_SERVER=$(get_parameter 'git_server' -f "${CONFIG_DIST}")
DEFAULT_GIT_USERNAME=$(get_parameter 'git_username' -f "${CONFIG_DIST}")
DEFAULT_GIT_SSH=$(get_parameter 'git_ssh' -f "${CONFIG_DIST}")

# check git is installed
if [ `is_installed git` == 'true' ]; then
    # get app version from latest git tag
    APP_VERSION="$(echo `git describe --exact-match --abbrev=0 2>/dev/null`)"
    INSTALL_DIR="$(git rev-parse --show-toplevel 2>/dev/null)"
fi

if [ -z "${APP_VERSION}" ]; then
    APP_VERSION='0.1.0'
fi

if [ -z "${INSTALL_DIR}" ]; then
    INSTALL_DIR="$(dirname "${BASEDIR}")"
fi

# prompt user values
GIT_SERVER=$(prompt_user 'Default git server' -d "${DEFAULT_GIT_SERVER}")
GIT_USERNAME=$(prompt_user 'Default git username' -d "${DEFAULT_GIT_USERNAME}")
GIT_SSH=$(prompt_user 'Use SSH ?' -d "${DEFAULT_GIT_SSH}")

cat > ${CONFIG} << EOL
parameters:
    app_version: ${APP_VERSION}
    install_dir: ${INSTALL_DIR}

git:
    git_server:   ${GIT_SERVER}
    git_username: ${GIT_USERNAME}
    git_ssh:      ${GIT_SSH}
EOL

echo_caption 'This is your current config'
echo
cat ${CONFIG}
echo
