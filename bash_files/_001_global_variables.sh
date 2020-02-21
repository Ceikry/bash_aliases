
#--------------------------------------------------
# global variables
#--------------------------------------------------

# zsh shell lower bound array start from 1
case "${SHELL}" in
    '/bin/bash'|'/usr/bin/bash')
        LBOUND=0
    ;;
    '/usr/bin/zsh')
        LBOUND=1
    ;;
esac

# set shortcut to installation directory
alias cdaliases="cd ${INSTALL_DIR}"

# set vim as default editor
export VISUAL=vim
export EDITOR="${VISUAL}"

# TODO: apt-get
# TODO: sudo

