
## Find / list available apt packages
function pkg-search() {
    echo_info "apt-cache search \"${@}\""
    apt-cache search "${@}"
}
