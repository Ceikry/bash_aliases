
## Clone remote git repository to local folder
function clone() {
    # Check git installation
    if [ ! -x "$(command -v git)" ]; then
        echo_error 'git required, enter: "sudo apt-get install -y git" to install'
        return 1
    fi

    local GIT_REPOSITORY

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :s:u:bglHSh OPTION
        do
            case "${OPTION}" in
                s) GIT_SERVER="${OPTARG}";;
                u) GIT_USERNAME="${OPTARG}";;
                b) GIT_SERVER='bitbucket.org';;
                g) GIT_SERVER='github.com';;
                l) GIT_SERVER='gitlab.com';;
                H) GIT_SSH='false';;
                S) GIT_SSH='true';;
                h) echo_label 'description'; echo_primary 'Clone remote git repository to local folder'
                    echo_label 'usage';      echo_primary 'clone [repository] [-u username] [-s server] -b (bitbucket) -g (github) -l (gitlab) -H (https) -S (ssh) -h (help)'
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
        echo_label 'usage'; echo_primary 'clone [repository] [-u username] [-s server] -b (bitbucket) -g (github) -l (gitlab) -H (https) -S (ssh) -h (help)'
        return 1
    fi

    GIT_REPOSITORY="${ARGUMENTS[${LBOUND}]}"

    if [ -z "${GIT_REPOSITORY}" ] || [ -z "${GIT_SERVER}" ] || [ -z "${GIT_USERNAME}" ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary 'clone [repository] [-u username] [-s server] -b (bitbucket) -g (github) -l (gitlab) -H (https) -S (ssh) -h (help)'
        return 1
    fi

    if [ "${GIT_SSH}" = 'true' ]; then
        echo_info "git clone git@${GIT_SERVER}:${GIT_USERNAME}/${GIT_REPOSITORY}.git"
        git clone git@${GIT_SERVER}:${GIT_USERNAME}/${GIT_REPOSITORY}.git
    else
        echo_info "git clone https://${GIT_SERVER}/${GIT_USERNAME}/${GIT_REPOSITORY}.git"
        git clone https://${GIT_SERVER}/${GIT_USERNAME}/${GIT_REPOSITORY}.git
    fi

    # when cloning sucessful and ".gitmodules" file present
    if [ "${?}" = '0' ] && [ -f "${GIT_REPOSITORY}/.gitmodules" ]; then
        (
            echo_info "cd \"${GIT_REPOSITORY}\""
            cd "${GIT_REPOSITORY}"

            echo_info 'git submodule update --init --recursive'
            git submodule update --init --recursive
        )
    fi
}

