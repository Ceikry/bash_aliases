
## Update tangoman bash_aliases
function tango-update() {
    # Check git installation
    if [ ! -x "$(command -v git)" ]; then
        echo_error 'git required, enter: "sudo apt-get install -y git" to install'
        return 1
    fi

    echo_info "cd \"${INSTALL_DIR}\""
    cd "${INSTALL_DIR}"

    # listing latest tags from remote repository
    echo_info 'git fetch --tags &>/dev/null'
    git fetch --tags &>/dev/null

    local LATEST_VERSION="$(git tag --list | tail -1)"

    # check update available
    if [ -n "${LATEST_VERSION}" ]; then
        if [ "${APP_VERSION}" != "${LATEST_VERSION}" ]; then
            echo_info 'update available for TangoMan "bash_aliases"'
            echo_warning "your version:   ${APP_VERSION}"
            echo_success "latest version: ${LATEST_VERSION}"
        else
            echo_info "your version:   ${APP_VERSION}"
            echo_info "latest version: ${LATEST_VERSION}"
            echo_success 'your version of TangoMan "bash_aliases" is up-to-date'
            return 0
        fi
    else
        echo_error 'could not check TangoMan "bash_aliases" latest available version'
        return 1
    fi

    echo_info 'git pull'
    git pull

    echo_info "${INSTALL_DIR}/bin/init_bash_aliases.sh"
    ${INSTALL_DIR}/bin/init_bash_aliases.sh

    echo_info "${INSTALL_DIR}/bin/build_bash_aliases.sh"
    ${INSTALL_DIR}/bin/build_bash_aliases.sh

    echo_info "${INSTALL_DIR}/bin/install_bash_aliases.sh"
    ${INSTALL_DIR}/bin/install_bash_aliases.sh

    echo_info "${INSTALL_DIR}/bin/config_bash_aliases.sh"
    ${INSTALL_DIR}/bin/config_bash_aliases.sh

    tango-reload
}

