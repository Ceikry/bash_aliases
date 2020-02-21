
## Starts python built-in server
function python-server() {
    # Check python installation
    if [ ! -x "$(command -v python)" ]; then
        echo_error 'python required, enter: "sudo apt-get install -y python" to install'
        return 1
    fi

    local PORT=8000

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :p:h OPTION; do
            case "${OPTION}" in
                p) PORT="${OPTARG}";;
                h) echo_label 'description'; echo_primary 'Start python builtin server'
                    echo_label 'usage'; echo_primary 'python-server -p (port)'
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
        echo_label 'usage'; echo_primary 'python-server -p (port)'
        return 1
    fi

    echo_info "python -m SimpleHTTPServer \"${PORT}\""
    python -m SimpleHTTPServer "${PORT}"
}

