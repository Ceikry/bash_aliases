
## Reset current git history
function greset() {
    # Check git installation
    if [ ! -x "$(command -v git)" ]; then
        echo_error 'git required, enter: "sudo apt-get install -y git" to install'
        return 1
    fi

    local TOPLEVEL="$(git rev-parse --show-toplevel 2>/dev/null)"

    if [ -z "${TOPLEVEL}" ]; then
        echo_error 'Not a git repository (or any of the parent directories)'
        return 1
    fi

    # check git user configured
    if [ -z "$(git config --global user.username)" ] && [ -z "$(git config --global user.email)" ]; then
        echo_error 'missing git default account identity'
        return 1
    fi

    local OPTARG
    local OPTIND=0
    local OPTION
    local FORCE='false'

    while getopts :fh OPTION; do
        case "${OPTION}" in
            f) FORCE='true';;
            h) echo_label 'description'; echo_primary 'Reset current git history'
                echo_label 'usage'; echo_primary 'greset -f (force remote) -h (help)'
                return 0;;
            \?) echo_error "invalid option \"${OPTARG}\""
                return 1;;
        esac
    done

    echo_info "cd ${TOPLEVEL}"
    cd "${TOPLEVEL}"

    # generate temp folder
    local TEMP="/tmp/tango_`date +%Y%m%d%H%M%S`_`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`"

    echo_info "mkdir ${TEMP}"
    mkdir ${TEMP}

    # backup git config
    echo_info "mv .git ${TEMP}/.git"
    mv .git ${TEMP}/.git

    # backup .gitmodules
    if [ -f .gitmodules ]; then
        echo_info "mv .gitmodules ${TEMP}/.gitmodules"
        mv .gitmodules ${TEMP}/.gitmodules
    fi

    # remove submodules
    if [ -f ${TEMP}/.gitmodules ]; then
        for SUBMODULE_PATH in `awk '/^(\t| )+path = .+/ { print $3 }' ${TEMP}/.gitmodules`; do
            echo_info "rm -rf ./${SUBMODULE_PATH}"
            rm -rf ./${SUBMODULE_PATH}
        done
    fi

    # initialize local git repository
    echo_info 'git init'
    git init

    # restore git config
    echo_info "cp ${TEMP}/.git/config .git/config"
    cp ${TEMP}/.git/config .git/config

    # update submodules
    if [ -f ${TEMP}/.gitmodules ]; then
        for URL in `awk '/^(\t| )+url = .+/ { print $3 }' ${TEMP}/.gitmodules`; do
            echo_info "git submodule add ${URL}"
            git submodule add ${URL}
        done
    fi

    echo_info 'git add .'
    git add .

    echo_info 'git commit -m "Initial Commit"'
    git commit -m "Initial Commit"

    if [ "${FORCE}" = 'true' ]; then
        echo_warning 'Resetting remote repository'

        echo_info 'tag -D'
        tag -D

        echo_info 'git push --force --set-upstream origin master'
        git push --force --set-upstream origin master
    fi

    dashboard
}

