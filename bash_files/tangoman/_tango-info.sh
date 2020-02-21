
## Print current system infos
function tango-info() {
    echo_title "TangoMan System Infos"
    echo

    echo_info "$(LANG=C date)"
    echo

    if [ -n "${HOSTNAME}" ]; then
        echo_caption 'hostname'
        echo_info "\${HOSTNAME}"
        echo_primary "${HOSTNAME}"
    fi

    if [ -n "$(command -v uname)" ]; then
        echo_caption 'box'
        echo_info "\$(uname -n | sed s/\`whoami\`-//)"
        echo_primary "$(uname -n | sed s/`whoami`-//)"
    fi

    if [ -n "$(command -v whoami)" ]; then
        echo_caption 'user name'
        echo_info "\`whoami\`"
        echo_primary "`whoami`"
    fi

    if [ -n "$(command -v id)" ]; then
        echo_caption 'user id'
        echo_info "\`id --user\`"
        echo_primary "`id --user`"
    fi

    if [ -n "$(command -v id)" ]; then
        echo_caption 'user groups'
        echo_info "\`id --groups\`"
        echo_primary "`id --groups`"
    fi

    if [ -n "$(command -v id)" ]; then
        echo_caption 'user groups id'
        echo_info "\`id --groups --name\`"
        echo_primary "`id --groups --name`"
    fi

    if [ -n "$(command -v hostname)" ]; then
        echo_caption 'local ip'
        echo_info "\`hostname -i\`"
        echo_primary "`hostname -i`"
    fi

    if [ -n "$(hostname -I 2>/dev/null)" ]; then
        echo_caption 'network ip'
        echo_info "\`hostname -I | cut -d' ' -f1\`"
        echo_primary "`hostname -I | cut -d' ' -f1`"
    fi

    if [ -n "${USER}" ]; then
        echo_caption 'user'
        echo_info "\${USER}"
        echo_primary "${USER}"
    fi

    if [ -z "${USERNAME}" ]; then
        echo_caption 'username'
        echo_info "\${USERNAME}"
        echo_primary "${USERNAME}"
    fi

    if [ -n "${SHELL}" ]; then
        echo_caption 'shell'
        echo_info "\${SHELL}"
        echo_primary "${SHELL}"
    fi

    if [ -n "${OSTYPE}" ]; then
        echo_caption 'ostype'
        echo_info "\${OSTYPE}"
        echo_primary "${OSTYPE}"
    fi

    if [ -n "$(lsb_release -d 2>/dev/null)" ]; then
        echo_caption 'os version'
        echo_info "\`lsb_release -d | sed 's/Description:\t//'\`"
        echo_primary "`lsb_release -d | sed 's/Description:\t//'`"
    fi

    if [ -n "$(command -v bash)" ]; then
        echo_caption 'bash version'
        echo_info "\`bash --version | grep -oE 'version\s[0-9]+\.[0-9]+\.[0-9]+.+$' | sed 's/version //'\`"
        echo_primary "`bash --version | grep -oE 'version\s[0-9]+\.[0-9]+\.[0-9]+.+$' | sed 's/version //'`"
    fi

    if [ -n "$(command -v zsh)" ]; then
        echo_caption 'zsh version'
        echo_info "\`zsh --version | sed 's/^zsh //'\`"
        echo_primary "`zsh --version | sed 's/^zsh //'`"
    fi

    if [ -n "${DESKTOP_SESSION}" ]; then
        echo_caption 'desktop_session'
        echo_info "\${DESKTOP_SESSION}"
        echo_primary "${DESKTOP_SESSION}"
    fi

    if [ -n "${XDG_CURRENT_DESKTOP}" ]; then
        echo_caption 'xdg_current_desktop'
        echo_info "\${XDG_CURRENT_DESKTOP}"
        echo_primary "${XDG_CURRENT_DESKTOP}"
    fi

    if [ -n "$(command -v ip)" ]; then
        echo_caption 'ip (ifconfig)'
        echo_info 'ip address'
        ip address
    fi

    if [ -n "$(command -v lshw)" ]; then
        echo_caption 'System infos'
        echo_info 'lshw -short'
        lshw -short
    fi
}
