#!/bin/bash

#/**
# * Install TangoMan bash_aliases
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
AUTHOR=$(get_parameter author -f ${CONFIG})
APP_NAME=$(get_parameter app_name -f ${CONFIG})

if [ ! -s ${BASEDIR}/../.bash_aliases ]; then
    echo_error 'could not copy: ".bash_aliases" not found'
    exit 1
fi

{
    echo_info "cp -fv ${BASEDIR}/../.bash_aliases ~" &&
    cp -fv ${BASEDIR}/../.bash_aliases ~ &&
    echo_success 'TangoMan "bash_aliases" installed'
} || {
    echo_error 'could not install ".bash_aliases"'
}
