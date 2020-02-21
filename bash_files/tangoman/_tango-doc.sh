
## Print bash_aliases documentation
function tango-doc() {
    echo_title 'tangoman functions'
    echo
    awk '/^function [a-zA-Z_-]+ ?\(\) ?\{/ { \
        COMMAND = substr($2, 0, index($2, "(")); \
        MESSAGE = substr(PREV, 4); \
        printf "\033[1;32m%s\t\033[0;35m%s\033[0m\n", COMMAND, MESSAGE; \
    } { PREV = $0 }' ~/.bash_aliases
    echo

    echo_title 'tangoman aliases'
    echo
    awk -F ' ## ' '/^alias [a-zA-Z_-]+=.+ ## / { \
        split($1, ALIAS, "="); \
        printf "\033[1;32m%s\t\033[0;35m%s\033[0m\n", substr(ALIAS[1], 7), $2; \
    }' ~/.bash_aliases
}

