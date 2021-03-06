
## Prompt user for parameter
function promt-user() {
    local PARAMETER

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :d:h OPTION; do
            case "${OPTION}" in
                d) DEFAULT_VALUE="${OPTARG}";;
                h) echo_label 'description'; echo_primary 'Prompt user for parameter value'
                    echo_label 'usage';      echo_primary 'promt-user [parameter] -d [default_value] -h (help)'
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
        echo_label 'usage'; echo_primary 'promt-user [parameter] -d [default_value] -h (help)'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        echo_error "too many arguments (${#ARGUMENTS[@]})"
        echo_label 'usage'; echo_primary 'promt-user [parameter] -d [default_value] -h (help)'
        return 1
    fi

    PARAMETER=${ARGUMENTS[${LBOUND}]}

    if [ -n "$DEFAULT_VALUE" ]; then
        echo_success "${PARAMETER} [${DEFAULT_VALUE}]: "
        read NEW_VALUE
        if [ -n "$NEW_VALUE" ]; then
            echo $NEW_VALUE
        else
            echo $DEFAULT_VALUE
        fi
    else
        echo_success "${PARAMETER}: "
        read NEW_VALUE
        echo $NEW_VALUE
    fi
}

