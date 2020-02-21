
## Extract each archive to destination
function extract-archives() {
    # Check argument count
    if [ "${#}" -gt 2 ]; then
        echo_error "too many arguments ($#)"
        echo_label 'usage'; echo_primary 'extract-archives [source] [destination]'
        return 1
    fi

    # Check source
    if [ "${#}" -lt 1 ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary 'extract-archives [source] [destination]'
        return 1
    fi

    # Check source validity
    if [ ! -d "${1}" ]; then
        echo_error 'source must be folder'
        echo_label 'usage'; echo_primary 'extract-archives [source] [destination]'
        return 1
    fi

    # Check destination validity
    if [ ! -d "${2}" ]; then
        echo_error 'destination must be folder'
        echo_label 'usage'; echo_primary 'extract-archives [source] [destination]'
        return 1
    fi

    # excluding last forward slash if any
    local SOURCE="`realpath "${1}"`"
    local DESTINATION="`realpath "${2}"`"

    # cache file count
    local TOTAL=$(find "${SOURCE}" -maxdepth 1 -type f -iregex '.+\.\(7z\|zip\|tar\.gz\)$' | wc -l)
    local COUNT=1
    local FILE_PATH
    local TOTAL

    find "${SOURCE}" -maxdepth 1 -type f -iregex '.+\.\(7z\|zip\|tar\.gz\)$' | while read FILE_PATH; do
        echo_info "Extracting $(( COUNT++ )) of ${TOTAL}..."

        # -aos => overwrite mode
        echo_info "7z x \"${FILE_PATH}\" -o\"${DESTINATION}\" -aos"
        7z x "${FILE_PATH}" -o"${DESTINATION}" -aos

        # echo_info "tar -zxvf ${ARCHIVE}"
        # tar -zxvf ${ARCHIVE}
    done
}

