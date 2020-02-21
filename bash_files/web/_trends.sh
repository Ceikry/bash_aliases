
## Search on google trends
function trends() {
    echo_info "https://trends.google.fr/trends/explore?q=$(echo ${*}|sed 's/ /%20/')"
    open "https://trends.google.fr/trends/explore?q=$(echo ${*}|sed 's/ /%20/')"
}

