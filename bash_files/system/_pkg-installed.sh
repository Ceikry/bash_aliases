
## Find / list installed apt packages
function pkg-installed() {
    echo_info 'apt list --installed'
    apt list --installed
}
