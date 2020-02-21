
## Starts symfony built-in server
function symfony-server() {
    local CONSOLE
    local DOCROOT
    local IP
    local STOP='false'

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :d:sh OPTION; do
            case "${OPTION}" in
                d) DOCROOT="${OPTARG}";;
                s) STOP='true';;
                h) echo_label 'description'; echo_primary 'Start / stop symfony builtin server'
                    echo_label 'usage';      echo_primary 'server (ip:port) -d (docroot) -s (stop)'
                    return 0;;
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
        echo_label 'usage'; echo_primary 'server (ip:port) -d (docroot) -s (stop)'
        return 1
    fi

    IP=${ARGUMENTS[${LBOUND}]}

    # find correct console executable
    if [ -x ./app/console ]; then
        CONSOLE=./app/console

    elif [ -x ./bin/console ]; then
        CONSOLE=./bin/console

    else
        echo_error 'no symfony console executable found'
        return 1
    fi

    if [ "${STOP}" = 'true' ]; then
        echo_info "php -d memory-limit=-1 ${CONSOLE} server:stop"
        php -d memory-limit=-1 ${CONSOLE} server:stop || echo_warning 'Is your symfony application running in production mode ?'
        return 0
    fi

    if [ -d "${DOCROOT}" ]; then
        echo_info "php -d memory-limit=-1 ${CONSOLE} server:start ${IP} --docroot=\"${DOCROOT}\""
        php -d memory-limit=-1 ${CONSOLE} server:start ${IP} --docroot="${DOCROOT}"
    else
        echo_info "php -d memory-limit=-1 ${CONSOLE} server:start ${IP}"
        php -d memory-limit=-1 ${CONSOLE} server:start ${IP}
    fi

    if [ $? -gt 0 ]; then
        echo_warning 'Is your symfony application running in production mode ?'
    fi
}

