
## Find / list available apt packages
function pkg-list() {
    echo_info 'apt-cache pkgnames | sort'
    apt-cache pkgnames | sort
}

