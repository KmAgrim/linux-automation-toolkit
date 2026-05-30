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
cat <<- _EOF_
Correct Options are 0 1 2 3 4 5 6
Only A single digit for example -> 0 Not 01
_EOF_
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
echo "Invalid format given." >&2
support
sleep 3
continue
elif [[ ! "$REPLY" =~ ^[0123456]{1}$ ]]; then
echo "Given Option is Not Valid." >&2
support
sleep 5
continue
else
if ((REPLY == 0)); then
echo "Exiting."
break
elif ((REPLY == 1)); then
echo -e "\nHostname: $(hostname)\tCurrent User: ${USER}\n"
elif ((REPLY == 2)); then
echo -e "Uptime: $(uptime)\n"
elif ((REPLY == 3)); then
echo -e "Current System Date:$(date)\n"
elif ((REPLY == 4)); then
echo -e "====\tCurrent Disk Usage\t===="
echo -e "\n$(df -h / --output=size,used,avail,pcent)\n"

elif ((REPLY == 5)); then
echo "==== Current Memory Usage ===="
echo -e "$(free -h | tr -s '[:blank:]' '\t' | cut -f 1-4,7)\n"

elif ((REPLY == 6)); then
echo -e "IP Address  $(ip -br a)"
fi
if [[ "$REPLY" == [1-5] ]]; then
sleep 5
fi
fi
done