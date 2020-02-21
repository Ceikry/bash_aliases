
## Associates with target wifi network
function wifi-fakeauth() {
    # Check ifconfig installation
    if [ -z "$(command -v 'ifconfig')" ]; then
        echo_error 'ifconfig not installed, try "sudo apt-get install -y ifconfig"'
        return 1
    fi

    # Check aireplay-ng installation
    if [ -z "$(command -v 'aireplay-ng')" ]; then
        echo_error 'aireplay-ng not installed, try "sudo apt-get install -y aircrack-ng"'
        return 1
    fi

    local CLIENT
    local DELAY=0
    local MAC_ADDRESSES
    local ROUTER

    local WIFI_ADAPTER
    local WIFI_ADAPTERS

    # showing wireless adapters only
    if [ -n "$(command -v 'arp')" ]; then
        WIFI_ADAPTER="`arp -a | cut -d' ' -f7 | grep -E '^w' | head -n1`"
        WIFI_ADAPTERS="$(printf "%s " `arp -a | cut -d' ' -f7 | grep -E '^w'`)"
    elif [ -n "$(command -v 'ip')" ]; then
        WIFI_ADAPTER="`ip token | cut -d' ' -f4 | grep -E '^w' | head -n1`"
        WIFI_ADAPTERS="$(printf "%s " `ip token | cut -d' ' -f4 | grep -E '^w'`)"
    else
        WIFI_ADAPTER="`ifconfig | grep -E '^w' | head -n1 | cut -d: -f1`"
        WIFI_ADAPTERS="$(printf "%s " `ifconfig | grep -E '^w\w+:' | cut -d: -f1`)"
    fi

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :c:d:r:h OPTION; do
            case "${OPTION}" in
                c) CLIENT="${OPTARG}";;
                d) DELAY="${OPTARG}";;
                r) ROUTER="${OPTARG}";;
                h) echo_label 'description'; echo_primary 'Associates with target wifi network'
                    echo_label 'usage';      echo_primary 'wifi-fakeauth (adapter) -r [router_mac] (-c client_mac) (-d delay) -h (help)'
                    echo_label 'note';       echo_primary "available adapters: ${WIFI_ADAPTERS}"
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
        echo_label 'usage'; echo_primary 'wifi-fakeauth (adapter) -r [router_mac] (-c client_mac) (-d delay) -h (help)'
        echo_label 'note'; echo_primary "available adapters: ${WIFI_ADAPTERS}"
        return 1
    fi

    if [ -z "${CLIENT}" ]; then
        # get monitor mode adapters mac addresses with awk
        MAC_ADDRESSES="`ifconfig | awk '/^[a-zA-Z0-9]+:/ { A = substr($1, 0, index($1, ":")) } /unspec ([0-9][0-9]-)+/ { printf "%s\n", A substr($2, 0, 17) }'`"
        CLIENT="`echo ${MAC_ADDRESSES} | grep -E '^w' | head -n1 | cut -d: -f2 | tr - :`"
    fi

    if [ -z "${CLIENT}" ] || [ -z "${ROUTER}" ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary 'wifi-fakeauth (adapter) -r [router_mac] (-c client_mac) (-d delay) -h (help)'
        echo_label 'note'; echo_primary "available adapters: ${WIFI_ADAPTERS}"
        return 1
    fi

    # check mac adress format valid
    if [[ ! "${ROUTER}" =~ ^([a-zA-Z0-9]{2}:){5}[a-zA-Z0-9]{2}$ ]]; then
        echo_error "wrong mac address format ${ROUTER}"
        echo_label 'usage'; echo_primary 'wifi-fakeauth (adapter) -r [router_mac] (-c client_mac) (-d delay) -h (help)'
        echo_label 'note'; echo_primary "available adapters: ${WIFI_ADAPTERS}"
        return 1
    fi

    # mac address of wireless adapter in monitor mode
    if [[ ! "${CLIENT}" =~ ^([a-zA-Z0-9]{2}:){5}[a-zA-Z0-9]{2}$ ]]; then
        echo_error "wrong mac address format ${CLIENT}"
        echo_label 'usage'; echo_primary 'wifi-fakeauth (adapter) -r [router_mac] (-c client_mac) (-d delay) -h (help)'
        echo_label 'note'; echo_primary "available adapters: ${WIFI_ADAPTERS}"
        return 1
    fi

    if [ -n "${ARGUMENTS[${LBOUND}]}" ]; then
        WIFI_ADAPTER="${ARGUMENTS[${LBOUND}]}"
    fi

    echo_info "sudo aireplay-ng --fakeauth ${DELAY} -a ${ROUTER} -h ${CLIENT} ${WIFI_ADAPTER}"
    sudo aireplay-ng --fakeauth ${DELAY} -a ${ROUTER} -h ${CLIENT} ${WIFI_ADAPTER}
}

