
## Create new user
function create-user() {
    local NEW_USER
    local GROUP

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :g:h OPTION; do
            case "${OPTION}" in
                g) GROUP="${OPTARG}";;
                h) echo_label 'description'; echo_primary 'Create new user and adds to desired group'
                    echo_label 'usage';      echo_primary 'create-user [new_user] -g [group] -h (help)'
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
        echo_label 'usage'; echo_primary 'create-user [new_user] -g [group] -h (help)'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        echo_error "too many arguments (${#ARGUMENTS[@]})"
        echo_label 'usage'; echo_primary 'create-user [new_user] -g [group] -h (help)'
        return 1
    fi

    NEW_USER=${ARGUMENTS[${LBOUND}]}

    sudo adduser ${NEW_USER}

    if [ -z "${GROUP}" ]; then
        return 0;
    fi

    if [ -z "$(groups|grep ${GROUP})" ]; then
        sudo addgroup ${GROUP}
    fi

    sudo adduser ${NEW_USER} ${GROUP}
}

