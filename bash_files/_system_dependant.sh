
#--------------------------------------------------
# system dependant
#--------------------------------------------------

## Open file or folder with appropriate app
function open() {
    local ARGUMENTS=()
    for ARGUMENTS in "${@}"; do
        case "${OSTYPE}" in
            'cygwin'|'msys')
                start "${ARGUMENTS}";;
            'darwin'*)
                open "${ARGUMENTS}";;
            'linux-gnu'|'linux-androideabi')
                xdg-open "${ARGUMENTS}"&>/dev/null;;
            *)
                echo_error "ostype: \"${OSTYPE}\" is not handled"; return 1;;
        esac
    done
}

# system specific aliases
case "${OSTYPE}" in
    'cygwin'|'msys')
        alias appdata='echo_info "cd ~/AppData/Roaming && ls -lFh" && cd ~/AppData/Roaming && ls -lFh'
        alias desktop='echo_info "cd ~/Desktop && ls -lFh" && cd ~/Desktop && ls -lFh'
        alias documents='echo_info "cd ~/Documents && ls -lFh" && cd ~/Documents && ls -lFh'
        alias downloads='echo_info "cd ~/Downloads && ls -lFh" && cd ~/Downloads && ls -lFh'
        alias pictures='echo_info "cd ~/Pictures && ls -lFh" && cd ~/Pictures && ls -lFh'
        alias localappdata='echo_info "cd ~/AppData/Local && ls -lFh" && cd ~/AppData/Local && ls -lFh'
        alias system='echo_info "cd /c/ && ls -lFh" && cd /c/ && ls -lFh'
        alias www='echo_info "cd /c/www && ls -lFh" && cd /c/www && ls -lFh'
    ;;
    'linux-androideabi')
        alias sudo='tsudo'
        alias apt-get='pkg'
        export USER=$(whoami)
    ;;
    'linux-gnu')
        if [ "${DESKTOP_SESSION}" = 'ubuntu' ]; then
            if [ 'fr' = "$(locale | grep LANG= | cut -d'=' -f2 | cut -d'_' -f1)" ]; then
                # Shortcuts
                alias desktop='echo_info "cd ~/Bureau && ls -lFh" && cd ~/Bureau && ls -lFh'
                alias documents='echo_info "cd ~/Documents && ls -lFh" && cd ~/Documents && ls -lFh'
                alias pictures='echo_info "cd ~/Images && ls -lFh" && cd ~/Images && ls -lFh'
                alias downloads='echo_info "cd ~/Téléchargements && ls -lFh" && cd ~/Téléchargements && ls -lFh'
                alias music='echo_info "cd ~/Musique && ls -lFh" && cd ~/Musique && ls -lFh'
                alias videos='echo_info "cd ~/Vidéos && ls -lFh" && cd ~/Vidéos && ls -lFh'
            fi

            if [ 'en' = "$(locale | grep LANG= | cut -d'=' -f2 | cut -d'_' -f1)" ]; then
                # Shortcuts
                alias desktop='echo_info "cd ~/Desktop && ls -lFh" && cd ~/Desktop && ls -lFh'
                alias documents='echo_info "cd ~/Documents && ls -lFh" && cd ~/Documents && ls -lFh'
                alias downloads='echo_info "cd ~/Downloads && ls -lFh" && cd ~/Downloads && ls -lFh'
                alias music='echo_info "cd ~/Music && ls -lFh" && cd ~/Music && ls -lFh'
                alias pictures='echo_info "cd ~/Pictures && ls -lFh" && cd ~/Pictures && ls -lFh'
                alias videos='echo_info "cd ~/Videos && ls -lFh" && cd ~/Videos && ls -lFh'
            fi

            alias www='echo_info "cd /var/www && ls -lFh" && cd /var/www && ls -lFh'

            # Jump to last directory
            alias -- --='cd -'

            alias renamer='EDITOR="subl -w" qmv -f do'
        fi
        if [ "${SESSIONTYPE}" = 'gnome-session' ]; then
            echo 'ubuntu 16.04' &>/dev/null
        fi
        if [ -n "$(uname -rv | grep -i 'microsoft')" ]; then
            echo 'Windows Subsystem for Linux (WSL)' &>/dev/null
        fi
    ;;
esac

## kill google chrome process and clear cache on linux
function clear-chrome-cache() {
    if [ "${DESKTOP_SESSION}" = 'ubuntu' ]; then
        echo_info 'pkill chrome'
        pkill chrome

        echo_info 'rm -rf ~/.cache/google-chrome'
        rm -rf ~/.cache/google-chrome

        echo_info 'rm -f ~/.config/google-chrome/Default/Cookies'
        rm -f ~/.config/google-chrome/Default/Cookies

        echo_info 'rm -f ~/.config/google-chrome/Default/Cookies-journal'
        rm -f ~/.config/google-chrome/Default/Cookies-journal
    else
        echo_error 'this command is designed for ubuntu only'
    fi
}

