
## Search on giphy.com
function giphy() {
    echo_info "https://giphy.com/search/$(echo ${*}|tr ' ' '-')"
    open "https://giphy.com/search/$(echo ${*}|tr ' ' '-')"
}

