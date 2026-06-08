#!/bin/bash
USAGE(){
    local msg="$1"
    case "$msg" in
1)  
cat <<- _EOF_
Usage: ./${0##*/} process_name
Example 
./${0##*/} bash
_EOF_
    ;;
2)
cat <<- _EOF_ 
More than one Argument Provided!
Number Of Argument must be 1.
Exiting...

_EOF_
;;
esac
}

valid_ArgC(){
    local arg="$1"
    if ((arg == 0)); then
    echo "No Argument Provided!" >&2
    USAGE 1
    return 1
    elif ((arg > 1)); then    
    USAGE 2
    return 1
    else
    return 0
    fi
}
find_process(){
    local name="$1"
    if [[ ! "$name" =~ ^[[:alnum:]\]+[[:alnum:]]+$ ]]; then
    echo "Process Name is not in Valid Format!" >&2
    return 1
    else
    if ps -p "$(pgrep -d ',' "$name")" -o pid,user,%cpu,%mem; then
    echo "Processes Found: $"
    return 0
    else
    echo -e "Process Not Found! Exitng...\n" >&2
    return 1
    fi
    fi
}

if valid_ArgC "$#"; then
if find_process "$@"; then
echo "Success!"
fi
fi