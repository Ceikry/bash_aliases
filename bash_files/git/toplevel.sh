
## Jump to git toplevel folder
function toplevel() {
    # Check git installation
    if [ ! -x "$(command -v git)" ]; then
        echo_error 'git required, enter: "sudo apt-get install -y git" to install'
        return 1
    fi

    local OPTARG
    local OPTIND=0
    local OPTION
    while getopts :h OPTION; do
        case "${OPTION}" in
            h) echo_label 'description'; echo_primary 'Jump to git toplevel folder'
                echo_label 'usage'; echo_primary 'toplevel -h (help)'
                return 0;;
            \?) echo_error "invalid option \"${OPTARG}\""
                return 1;;
        esac
    done

    local TOPLEVEL="$(git rev-parse --show-toplevel 2>/dev/null)"

    if [ -z "${TOPLEVEL}" ]; then
        echo_error 'Not a git repository (or any of the parent directories)'
        return 1
    fi

    echo_info "cd ${TOPLEVEL}"
    cd "${TOPLEVEL}"
}

