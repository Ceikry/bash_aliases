
## Own files and folders
function own() {
    local GROUP
    # 664: rw-rw-r-- default file
    # 755: rwxr-xr-x default folder
    # 775: rwxrwxr-x default executable
    local MODE='664'
    local RECURSIVE='false'
    local USER=`whoami`

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :dsrxm:u:g:h OPTION; do
            case "${OPTION}" in
                d) MODE='664';;
                r) RECURSIVE='true';;
                x) MODE='775';;
                m) MODE="${OPTARG}";;
                u) USER="${OPTARG}";;
                g) GROUP="${OPTARG}";;
                h) echo_label 'description'; echo_primary 'chown and chmod given files and folders'
                    echo_label 'usage';      echo_primary 'own (source) -u [user] -g [group] -m [mode] -r (recursive) -d (default=664) -x (executable=775) -h (help)'
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

    # Check argument count
    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        echo_error "too many arguments (${#ARGUMENTS[@]})"
        echo_label 'usage'; echo_primary 'own (source) -u [user] -g [group] -m [mode] -r (recursive) -d (default=664) -x (executable=775) -s (sudo) -h (help)'
        return 1
    fi

    if [[ ! "${MODE}" =~ ^[0-7]+$ ]]; then
        echo_error 'some mandatory parameter is invalid'
        echo_label 'usage'; echo_primary 'own (source) -u [user] -g [group] -m [mode] -r (recursive) -d (default=664) -x (executable=775) -s (sudo) -h (help)'
        return 1
    fi

    if [ -z "${GROUP}" ]; then
        GROUP="${USER}"
    fi

    # excluding last forward slash if any
    local SOURCE="`realpath "${ARGUMENTS[${LBOUND}]}"`"

    # Check source validity
    if [ ! -f "${SOURCE}" ] && [ ! -d "${SOURCE}" ]; then
        echo_error 'source is missing'
        echo_label 'usage'; echo_primary 'own (source) -u [user] -g [group] -m [mode] -r (recursive) -d (default=664) -x (executable=775) -s (sudo) -h (help)'
        return 1
    fi

    if [ -d "${SOURCE}" ] && [ "${RECURSIVE}" = 'true' ]; then
        echo_info "chown ${USER}:${GROUP} -R ${SOURCE}"
        chown ${USER}:${GROUP} -R ${SOURCE}

        # Find all subfolders
        find "${SOURCE}" -type d | while read FOLDER
        do
            echo_info "chmod 755 ${FOLDER}"
            chmod 755 ${FOLDER}
        done

        # Find all subfolders
        find "${SOURCE}" -type f | while read FILE
        do
            echo_info "chmod ${MODE} ${FILE}"
            chmod ${MODE} ${FILE}
        done

        return 0
    fi

    if [ -d "${SOURCE}" ]; then
        echo_info "chown ${USER}:${GROUP} ${SOURCE} && chmod 755 ${SOURCE}"
        chown ${USER}:${GROUP} ${SOURCE} && chmod 755 ${SOURCE}

        return 0
    fi

    if [ -f "${SOURCE}" ]; then
        echo_info "chown ${USER}:${GROUP} ${SOURCE} && chmod ${MODE} ${SOURCE}"
        chown ${USER}:${GROUP} ${SOURCE} && chmod ${MODE} ${SOURCE}
    fi
}

