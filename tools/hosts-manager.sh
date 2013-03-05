#!/bin/sh

HOSTS_FILE="/usr/local/etc/hosts.local"

function die() {
    echo >&2 "$@"
    exit 1
}

function list_hosts() {
    [[ "$#" -eq 1 ]] || die "Only 1 argument required, $# provided"

    cat $HOSTS_FILE
}

function add_host() {
    [[ "$#" -eq 3 ]] || die "3 arguments expected, $# provided"
    
    local hostname=$2
    local ip=$3

    if ! valid_ip $ip; then
        die "Invalid IP given"
    fi
    
    if exists_host $hostname; then
        die "Host already exists"
    fi
    
    echo "$ip\t$hostname" >> $HOSTS_FILE
    
    echo "Host: '$hostname' added with IP: '$ip'"
    restart_service
}

function remove_host() {
    [[ "$#" -eq 2 ]] || die "2 arguments expected, $# provided"

    local hostname=$2
    
    if ! exists_host $hostname; then
        die "Host not found"
    fi
    
    sed -i '' '/[[:blank:]]'"$hostname"'$/d' $HOSTS_FILE
    
    echo "Host: '$hostname' removed"
    restart_service
}

function exists_host() {
    local stat=1
    local hostname=$1
    
    if grep --quiet "\s$hostname$" "$HOSTS_FILE"; then
        stat=0
    fi
    
    return $stat
}


function restart_service() {
    sudo launchctl stop homebrew.mxcl.dnsmasq
    sudo launchctl stop homebrew.mxcl.dnsmasq
}

# From: http://www.linuxjournal.com/content/validating-ip-address-bash-script
# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip() {
    local ip=$1
    local stat=1
    
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
      
    return $stat
}



[[ "$#" -ge 1 ]] || die "At least 1 argument required, $# provided"

if [[ ! -f $HOSTS_FILE ]]; then
    die "Host file: '$HOSTS_FILE' not found"
fi


case "$1" in
    "list")
        list_hosts "$@"
        ;;
    "add")
        add_host "$@"
        ;;
    "del")
        remove_host "$@"
        ;;
    *)
        die "Invalid argument $1"
        ;;
esac
