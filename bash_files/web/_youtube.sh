
## Search on youtube.com
function youtube() {
    echo_info "https://www.youtube.com/results?search_query=$(echo ${*} | tr ' ' '-')"
    open "https://www.youtube.com/results?search_query=$(echo ${*} | tr ' ' '-')"
}

