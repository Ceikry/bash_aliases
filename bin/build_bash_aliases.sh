#!/bin/bash

#/**
# * Build TangoMan bash_aliases
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

# check config present
CONFIG=${BASEDIR}/../config/config.yaml
if [ ! -f "${CONFIG}" ]; then
    echo_danger "config.yaml file not found"
    exit 1
fi

BASH_FILES=${BASEDIR}/../bash_files
if [ ! -d "${BASH_FILES}" ]; then
    echo_error 'no installation folder found, try to re-clone TangoMan "bash_aliases"'
    exit 1
fi

# destination file
BASH_ALIASES=${BASEDIR}/../.bash_aliases

# copy header.dist (avoid git conflicts)
HEADER_DIST=${BASH_FILES}/000_header.sh.dist
HEADER=${BASH_FILES}/_000_header.sh

echo_info "cp -f \"${HEADER_DIST}\" \"${HEADER}\""
cp -f "${HEADER_DIST}" "${HEADER}"

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

GIT_SERVER=$(get_parameter 'git_server' -f "${CONFIG}")
GIT_USERNAME=$(get_parameter 'git_username' -f "${CONFIG}")
GIT_SSH=$(get_parameter 'git_ssh' -f "${CONFIG}")

# Setting global variables
echo_primary "Setting global variables from \"${CONFIG}\""

echo_label 'APP_VERSION'; echo_info ${APP_VERSION}
set_parameter 'APP_VERSION' "${APP_VERSION}" -f "${HEADER}" -s '=' -n

echo_label 'INSTALL_DIR'; echo_info ${INSTALL_DIR}
set_parameter 'INSTALL_DIR' "${INSTALL_DIR}" -f "${HEADER}" -s '=' -n

echo_label 'GIT_SERVER'; echo_info ${GIT_SERVER}
set_parameter 'GIT_SERVER' "${GIT_SERVER}" -f "${HEADER}" -s '=' -n

echo_label 'GIT_USERNAME'; echo_info ${GIT_USERNAME}
set_parameter 'GIT_USERNAME' "${GIT_USERNAME}" -f "${HEADER}" -s '=' -n

echo_label 'GIT_SSH'; echo_info ${GIT_SSH}
set_parameter 'GIT_SSH' "${GIT_SSH}" -f "${HEADER}" -s '=' -n

echo_info "rm -f ${BASH_ALIASES}"
rm -f ${BASH_ALIASES}

# concat each sh file prefixed with underscore
find "${BASH_FILES}" -type d | while read FOLDER;
do
    echo_info "cat ${FOLDER}/_*.sh >> ${BASH_ALIASES}"
    cat ${FOLDER}/_*.sh >> ${BASH_ALIASES}
done

echo_success 'TangoMan "bash_aliases" generated'
