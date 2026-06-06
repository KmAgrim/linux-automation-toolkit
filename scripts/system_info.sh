#!/bin/bash
menu(){
cat <<- _EOF_
===== SYSTEM INFORMATION =====
Press 0 to exit.
Press 1 to show Current Username and Hostname.
Press 2 to show System Uptime.
Press 3 to show System Date.
Press 4 to show Disk Usage.
Press 5 to show Memory Usage.
Press 6 to show Ip Address.
_EOF_
}

support(){
        local error_type="$1" 
        if (( error_type == 1 )); then # Value 1 for Incorrect Option 
        echo -e "Correct Options are 0 1 2 3 4 5 6"
        elif (( error_type == 2 )); then # Value 2 for Invalid Format
        cat <<- _EOF_ 
        Invalid Format Given.
        Correct Format is a single digit.
_EOF_
        fi
}

sys_usage(){
      case "$REPLY" in      
0)      echo "Exiting."
        exit 1
        ;;
1)
        echo -e "\nHostname: $(hostname)\tCurrent User: ${USER}\n"
        ;;
2) 
        echo -e "Uptime: $(uptime)\n"
        ;;

3) 
        echo -e "Current System Date:$(date)\n"
        ;;
4)
        echo -e "====\t Current Disk Usage \t===="
        echo -e "\n$(df -h / --output=size,used,avail,pcent)\n"
        ;;

5)
        echo "==== Current Memory Usage ===="
        echo -e "$(free -h | tr -s '[:blank:]' '\t' | cut -f 1-4,7)\n"
        ;;

6)
        echo -e "IP Address  $(ip -br a show label 'ens33' | cut -d '/' -f 1)"
        ;;
esac
}



while true; do
clear
menu
read -p "Pls Enter Your Choice > "
if [[ -z "$REPLY" ]]; then
echo "No Option given. Pls Provide an Option." >&2
sleep 2
continue
elif [[ ! "$REPLY" =~ ^[[:digit:]]+$ ]]; then
support 2
sleep 3
continue
elif [[ ! "$REPLY" =~ ^[0123456]{1}$ ]]; then
support 1
sleep 3
continue
else
sys_usage
if [[ "$REPLY" == [1-6] ]]; then
sleep 3
fi
fi
done