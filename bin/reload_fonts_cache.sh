#!/bin/bash

#/**
# * Reload Fonts Cache
# *
# * @category bin
# * @version  0.1.0
# * @licence  MIT
# * @author   "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

{
    sudo fc-cache -f -v &&
    echo_success 'font cache updated'
} || {
    echo_error 'could not update font cache'
}
