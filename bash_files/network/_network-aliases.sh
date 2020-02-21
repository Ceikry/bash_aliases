
#--------------------------------------------------
# network aliases
#--------------------------------------------------

alias myip='echo_info "curl -s https://api.ipify.org"; echo "`curl -s https://api.ipify.org`\n"' ## Get ip from ipify.org
alias local-ip='echo_info "hostname -I"; hostname -I'                                            ## Print ip
alias open-ports='echo_info "lsof -i -Pn | grep LISTEN"; lsof -i -Pn | grep LISTEN'              ## List open ports

alias close-ssh-tunnels='sudo pkill ssh'               ## Close all ssh tunnels
alias find-ssh-process='ps aux | grep ssh'             ## find ssh processes
alias hosts='sudo subl /etc/hosts'                     ## edit hosts with sublime
alias list-ssh='netstat -n --protocol inet | grep :22' ## list open ssh connections
alias mac='ifconfig | grep HWaddr'                     ## print mac address
alias mysql-start='sudo /etc/init.d/mysql start'       ## start mysql server
alias mysql-stop='sudo /etc/init.d/mysql stop'         ## stop mysql server
alias resolve='host'                                   ## resolve reverse hostname
alias iptables-list-rules='echo_info "sudo iptables -S"; sudo iptables -S; echo_info "sudo iptables -L"; sudo iptables -L' ## list iptables rules
