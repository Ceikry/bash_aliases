
## Encode string from base64 format
function encode() {
    if [ -z "${*}" ]; then
        echo_error 'some mandatory argument missing'
        echo_label 'usage'; echo_primary 'encode [string]'
        return 1
    fi

    echo $(echo ${*} | base64)
}

