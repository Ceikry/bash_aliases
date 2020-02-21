
## Shortcut for apt-get remove -y
function pkg-remove() {
    echo_info "sudo apt-get remove -y ${1}"
    sudo apt-get remove -y ${1}
}

