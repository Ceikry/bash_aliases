
## Print git dashboard
function dashboard() {
    # Check git installation
    if [ ! -x "$(command -v git)" ]; then
        echo_error 'git required, enter: "sudo apt-get install -y git" to install'
        return 1
    fi

    local VERBOSE='false'

    local OPTARG
    local OPTIND=0
    local OPTION
    while getopts :vh OPTION; do
        case "${OPTION}" in
            v) VERBOSE='true';;
            h) echo_label 'description'; echo_primary 'Print git dashboard'
                echo_label 'usage'; echo_primary 'dashboard -v (verbose) -h (help)'
                return 0;;
            \?) echo_error "invalid option \"${OPTARG}\""
                return 1;;
        esac
    done

    echo
    guser
    lremote

    if [ ${VERBOSE} = 'true' ]; then
        tag
        echo
    fi

    if [ ${VERBOSE} = 'true' ]; then
        lbranches -v
    else
        lbranches
    fi

    gstatus
}

