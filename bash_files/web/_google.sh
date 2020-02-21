
## Search on google.com
function google() {
    echo_info "https://www.google.com/search?q=$(echo ${*}|sed 's/ /%20/')"
    open "https://www.google.com/search?q=$(echo ${*}|sed 's/ /%20/')"
}

