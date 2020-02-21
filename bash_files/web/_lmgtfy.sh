
## Let me google that for you search
function lmgtfy() {
    echo_info "https://lmgtfy.com/?q=$(echo ${*}|tr ' ' '+')"
    open "https://lmgtfy.com/?q=$(echo ${*}|tr ' ' '+')"
}

