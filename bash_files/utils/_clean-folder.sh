
## recursively delete junk from folder
function clean-folder() {
    # Check argument count
    if [ "${#}" -gt 1 ]; then
        echo_error "too many arguments ($#)"
        echo_label 'usage'; echo_primary 'clean-folder [folder]'
        return 1
    fi

    # Check source
    if [ "${#}" -lt 1 ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary 'clean-folder [folder]'
        return 1
    fi

    # Check source validity
    if [ ! -d "${1}" ]; then
        echo_error 'source must be folder'
        echo_label 'usage'; echo_primary 'clean-folder [folder]'
        return 1
    fi

    # excluding last forward slash if any
    local SOURCE="`realpath "${1}"`"

    echo_info "find \"${SOURCE}\" -type f -iname \"desktop.ini\" -delete"
    find "${SOURCE}" -type f -iname "desktop.ini" -delete

    echo_info "find \"${SOURCE}\" -type f -iname \"thumbs.db\" -delete"
    find "${SOURCE}" -type f -iname "thumbs.db" -delete

    echo_info "find \"${SOURCE}\" -type f -name \".DS_Store\" -delete"
    find "${SOURCE}" -type f -name ".DS_Store" -delete

    echo_info "find \"${SOURCE}\" -type f -regex \".+_undo\.sh$\" -delete"
    find "${SOURCE}" -type f -regex ".+_undo\.sh$" -delete

    find "${SOURCE}" -type d -name "__MACOSX" | while read FILE; do
        echo_info "rm -rf \"$FILE\""
        rm -rf "$FILE"
    done
}

