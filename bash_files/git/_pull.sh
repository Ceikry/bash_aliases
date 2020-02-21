
## Fetch from remote repository to local branch
function pull() {
    # Check git installation
    if [ ! -x "$(command -v git)" ]; then
        echo_error 'git required, enter: "sudo apt-get install -y git" to install'
        return 1
    fi

    # check git user configured
    if [ -z "$(git config --global user.username)" ] && [ -z "$(git config --global user.email)" ]; then
        echo_error 'missing git default account identity'
        return 1
    fi

    local RECURSIVE='false'

    local OPTARG
    local OPTIND=0
    local OPTION
    while getopts :rh OPTION; do
        case "${OPTION}" in
            r) RECURSIVE='true';;
            h) echo_label 'description'; echo_primary 'Pull history from remote repository'
                echo_label 'usage'; echo_primary 'pull -r (recursive) -h (help)'
                return 0;;
            \?) echo_error "invalid option \"${OPTARG}\""
                return 1;;
        esac
    done

    if [ "${RECURSIVE}" = 'false' ]; then
        # check git directory
        if [ -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
            echo_error 'Not a git repository (or any of the parent directories)'
            return 1
        fi

        dashboard
        echo_info 'git pull'
        git pull
    fi

    if [ "${RECURSIVE}" = 'true' ]; then
        # Find all .git folders, git pull
        find . -maxdepth 1 -type d | while read FOLDER
        do
            if [ -d "${FOLDER}/.git" ]; then
                echo_box "$(basename ${FOLDER})"
                echo

                echo_info "cd \"${FOLDER}\""
                cd "${FOLDER}"

                echo_info 'git pull'
                git pull
                echo

                echo_info 'cd ..'
                cd ..
                echo
            fi
        done
    fi
}

