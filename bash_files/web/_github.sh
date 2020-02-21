
## Search on github.com
function github() {
    echo_info "open \"https://www.github.com/$(echo ${*}|sed 's/ /\//')\""
    open "https://www.github.com/$(echo ${*}|sed 's/ /\//')"
}

