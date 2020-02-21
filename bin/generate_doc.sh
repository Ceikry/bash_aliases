#!/bin/bash

#/**
# * TangoMan BashDoc
# *
# * @version 0.1.0
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_title ' ######################### '
echo_title ' # TangoMan Generate Doc # '
echo_title ' ######################### '
echo

## Print bash_aliases documentation
function generate_markdown_documentation() {
    # Check argument count
    if [ "${#}" -gt 1 ]; then
        echo_error "too many arguments ($#)"
        echo_label 'usage'; echo_primary "${0} [folder]"
        return 1
    fi

    # Check source
    if [ "${#}" -lt 1 ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary "${0} [folder]"
        return 1
    fi

    # Check source validity
    if [ ! -d "${1}" ]; then
        echo_error 'source must be folder'
        echo_label 'usage'; echo_primary "${0} [folder]"
        return 1
    fi

    local DESTINATION=${BASEDIR}/../docs
    local FILE
    local TITLE

    # excluding last forward slash
    local SOURCE="`realpath "${1}"`"

    rm -rf "${DESTINATION}"
    mkdir "${DESTINATION}"

    echo 'TangoMan bash_aliases documentation' > "${DESTINATION}/bash_aliases.md"
    printf '%35s\n\n' | tr ' ' '=' >> "${DESTINATION}/bash_aliases.md"

    find "${SOURCE}" -maxdepth 1 -type d | while read FOLDER
    do
        TITLE="$(basename ${FOLDER})"
        echo "${TITLE}" >> "${DESTINATION}/bash_aliases.md"
        printf "%${#TITLE}s\n\n" | tr ' ' '-' >> "${DESTINATION}/bash_aliases.md"

        find "${FOLDER}" -maxdepth 1 -type f -name "_*.sh" | while read FILE
        do
            echo_info "${FILE}"
            awk '/^function [a-zA-Z_-]+ ?\(\) ?\{/ { \
                COMMAND = substr($2, 0, index($2, "(")); \
                MESSAGE = substr(PREV, 4); \
                printf "### %s\n\n%s\n\n", COMMAND, MESSAGE; \
            } { PREV = $0 }' "${FILE}" >> "${DESTINATION}/bash_aliases.md"

            awk -F ' ## ' '/^alias [a-zA-Z_-]+=.+ ## / { \
                split($1, ALIAS, "="); \
                COMMAND = substr($1, index($1, "=")+1); \
                gsub(/ +$/, "", COMMAND); \
                printf "### %s\n\n```bash\n%s\n```\n\n%s\n\n", substr(ALIAS[1], 7), COMMAND, $2; \
            }' "${FILE}" >> "${DESTINATION}/bash_aliases.md"
        done
    done
}

BASH_FILES=${BASEDIR}/../bash_files
if [ ! -d "${BASH_FILES}" ]; then
    echo_error 'no installation folder found, try to re-clone TangoMan "bash_aliases"'
else
    generate_markdown_documentation "${BASH_FILES}"
fi
