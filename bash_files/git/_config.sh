
## Set bash_aliases git global settings
function config() {
    # default server = bitbucket.org
    if [ -z "${GIT_SERVER}" ]; then
        GIT_SERVER="bitbucket.org"
    fi

    if [ -z "${GIT_SERVER}" ]; then
        while [ -z "${GIT_SERVER}" ]; do
            echo_prompt "Enter git server name: "
            read GIT_SERVER
        done
    else
        echo_prompt "Enter git server name [${GIT_SERVER}]: "
        read USER_PROMPT
        if [ -n "${USER_PROMPT}" ]; then
            GIT_SERVER="${USER_PROMPT}"
        fi
    fi

    if [ -z "${GIT_USERNAME}" ]; then
        while [ -z "${GIT_USERNAME}" ]; do
            echo_prompt "Enter git username: "
            read GIT_USERNAME
        done
    else
        echo_prompt "Enter git username [${GIT_USERNAME}]: "
        read USER_PROMPT
        if [ -n "${USER_PROMPT}" ]; then
            GIT_USERNAME="${USER_PROMPT}"
        fi
    fi

    # translating boolean
    if [ "${GIT_SSH}" = 'true' ]; then
        DEFAULT_SSH=yes
    else
        DEFAULT_SSH=no
    fi

    echo_prompt "Do you want to use SSH? (yes/no) [${DEFAULT_SSH}]: "
    read USER_PROMPT
    if [[ "${USER_PROMPT}" =~ ^[Yy]([Ee][Ss])?$ ]]; then
        GIT_SSH='true'
    elif [[ "${USER_PROMPT}" =~ ^[Nn]([Oo])?$ ]]; then
        GIT_SSH='false'
    fi

    # check git user configured
    local COMMIT_EMAIL="$(git config --get user.email 2>/dev/null)"
    if [ -z "${COMMIT_EMAIL}" ]; then
        while [ -z "${COMMIT_EMAIL}" ]; do
            echo_prompt "Enter git commit email: "
            read COMMIT_EMAIL
        done
    else
        echo_prompt "Enter git commit email [${COMMIT_EMAIL}]: "
        read USER_PROMPT
        if [ -n "${USER_PROMPT}" ]; then
            COMMIT_EMAIL="${USER_PROMPT}"
        fi
    fi

    echo_info "git config --global user.email \"${COMMIT_EMAIL}\""
    git config --global user.email "${COMMIT_EMAIL}"

    local COMMIT_NAME="$(git config --get user.name 2>/dev/null)"
    if [ -z "${COMMIT_NAME}" ]; then
        while [ -z "${COMMIT_NAME}" ]; do
            echo_prompt "Enter git commit username: "
            read COMMIT_NAME
        done
    else
        echo_prompt "Enter git commit username [${COMMIT_NAME}]: "
        read USER_PROMPT
        if [ -n "${USER_PROMPT}" ]; then
            COMMIT_NAME="${USER_PROMPT}"
        fi
    fi

    echo_info "git config --global user.name \"${COMMIT_NAME}\""
    git config --global user.name "${COMMIT_NAME}"
}

