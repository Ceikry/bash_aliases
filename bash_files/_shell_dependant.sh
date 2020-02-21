
#--------------------------------------------------
# shell dependant
#--------------------------------------------------

## Decode string from URL format
function urlencode() {
    if [ ! "${SHELL}" == '/bin/bash' ]; then
        echo_error 'your shell is not compatible with this function'
        return 1
    fi

    if [ -z "${*}" ]; then
        echo_error 'some mandatory argument missing'
        echo_label 'usage'; echo_primary 'urlencode [string]'
        return 1
    fi

    local STRING="${*}"
    local STRLEN=${#STRING}
    local RESULT
    local POS CHAR OUT

    for (( POS=0 ; POS<STRLEN ; POS++ )); do
        CHAR=${STRING:${POS}:1}
        case "${CHAR}" in 
            [-_.~a-zA-Z0-9] ) OUT=${CHAR} ;;
            * ) printf -v OUT '%%%02x' "'${CHAR}";;
        esac
        RESULT+="${OUT}"
    done

    echo "${RESULT}"
}

## Encode string to URL format
function urldecode() {
    if [ ! "${SHELL}" == '/bin/bash' ]; then
        echo_error 'your shell is not compatible with this function'
        return 1
    fi

    # Returns a string in which the sequences with percent (%) signs followed by
    # two hex digits have been replaced with literal characters.
    if [ -z "${1}" ]; then
        echo_error 'some mandatory argument missing'
        echo_label 'usage'; echo_primary 'urldecode [string]'
        return 1
    fi

    if [ "${#}" -gt 1 ]; then
        echo_error "too many arguments ($#)"
        echo_label 'usage'; echo_primary 'urldecode [string]'
        return 1
    fi

    local RESULT
    # This is perhaps a risky gambit, but since all escape characters must be
    # encoded, we can replace %NN with \xNN and pass the lot to printf -b, which
    # will decode hex for us
    printf -v RESULT '%b' "${1//%/\\x}"

    echo "${RESULT}"
}

