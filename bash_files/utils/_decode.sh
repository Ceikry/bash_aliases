
## Decode string from base64 format
function decode() {
    if [ -z "${*}" ]; then
        echo_error 'some mandatory argument missing'
        echo_label 'usage'; echo_primary 'decode [string]'
        return 1
    fi

    if [ "${#}" -gt 1 ]; then
        echo_error "too many arguments ($#)"
        echo_label 'usage'; echo_primary 'decode [string]'
        return 1
    fi

    echo $(echo ${*} | base64 --decode)
}

