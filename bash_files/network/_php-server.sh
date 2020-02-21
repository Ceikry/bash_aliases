
## Starts php built-in server
function php-server() {
    local CONSOLE
    local DOCROOT
    local IP=localhost
    local PORT=8000

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :i:p:d:sh OPTION; do
            case "${OPTION}" in
                i) IP="${OPTARG}";;
                p) PORT="${OPTARG}";;
                d) DOCROOT="${OPTARG}";;
                s) STOP='true';;
                h) echo_label 'description'; echo_primary 'Start php builtin server'
                    echo_label 'usage';      echo_primary 'php-server (docroot) -i (ip) -p (port)'
                    return 0;;
                :) echo_error "\"${OPTARG}\" requires value"
                    return 1;;
                \?) echo_error "invalid option \"${OPTARG}\""
                    return 1;;
            esac
        done
        if [ "${OPTIND}" -gt 1 ]; then
            shift $(( OPTIND-1 ))
        fi
        if [ "${OPTIND}" -eq 1 ]; then
            ARGUMENTS+=("${1}")
            shift
        fi
    done

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        echo_error "too many arguments (${#ARGUMENTS[@]})"
        echo_label 'usage'; echo_primary 'php-server (docroot) -i (ip) -p (port)'
        return 1
    fi

    DOCROOT=${ARGUMENTS[${LBOUND}]}

    # guess correct docroot
    if [ -z "${DOCROOT}" ] && [ -d ./web ]; then
        # symfony 2/3 docroot
        DOCROOT=./web
    elif [ -z "${DOCROOT}" ] && [ -d ./public ]; then
        # symfony 4 docroot
        DOCROOT=./public
    fi

    if [ -z "${DOCROOT}" ]; then
        echo_info "php -d memory-limit=-1 -S ${IP}:${PORT}"
        php -d memory-limit=-1 -S ${IP}:${PORT}
    else
        echo_info "php -d memory-limit=-1 -S ${IP}:${PORT} -t ${DOCROOT}"
        php -d memory-limit=-1 -S ${IP}:${PORT} -t ${DOCROOT}
    fi
}

