#!/bin/bash
USAGE(){
local msg="$1"
case "$msg" in
1)
cat <<- _EOF_
Usage: ./${0##*/} option
Example
./network_info.sh 1
Only 1 Argument can be provided.
_EOF_
;;
2) 
cat <<- _EOF_
Usage: Option Must be a Single digit.
Example: 0 1 2 
_EOF_
;;
3)
cat <<- _EOF_
Given Option is not in a valid Format!
Valid Format - 0 1 2
_EOF_
;;
esac
echo "Exiting!.."
}

MENU(){ 
    cat <<- _EOF_
Press 0 to Exit
Press 1 to see Hostname  
Press 2 to show IP Addresses  
Press 3 to show Default Gateway  
Press 4 to show Current DNS Servers
_EOF_
}


IPInfo(){
    ip -br a show up | tr -s '[:blank:]' '#' | cut -d '#' -f3
    return 0;
}

GatewayInfo(){
    ip route | sed -n '1s/default/default gateaway/p'
    return 0;
}

DNSInfo(){
    resolvectl status | grep -w "DNS Server"
    return 0;
}

ShowOutput(){
    local choice="$1"
case "$choice" in
0)
    exit 0
    ;;
1)
    echo -e "Hostname: $HOSTNAME\n"
    ;;
2)
    IPInfo
    ;;  
3) 
    GatewayInfo
    ;;
4)
    DNSInfo
    ;;

esac
}

check_arg(){
    local arg="$1"
    if [[ $arg =~ ^[01234]{1}$ ]]; then
    return 0
    else
    echo "Given Option is Not Valid!" >&2
    return 1
    fi
}

if (($# == 0)); then
while true; do
MENU
read -p "Pls Provide An Option [0-4] " -n 1
echo
if check_arg "$REPLY"; then
ShowOutput "$REPLY"
fi
sleep 3
clear
done
elif (( $# > 1)); then
USAGE 1
else
if check_arg "$1"; then
ShowOutput "$1"
fi
fi