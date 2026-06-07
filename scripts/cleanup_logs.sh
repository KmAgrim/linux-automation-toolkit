#!/bin/bash
USAGE(){
    local err="$1"
    if (( err == 1 )); then
    cat <<- _EOF_
Usage: /${0##*/} log_directory days
Example 
./${0##*/} logs/ 30
Exiting!
_EOF_
elif (( err == 2 )); then
cat <<- _EOF_
Correct Format For Days
Digits Example - 1 2 3 15
Exiting!
_EOF_
fi
}
valid_ArgCount(){
    local arg="$1"
    if (( arg == 0 )); then
    echo "No Argument Provided!" >&2
    USAGE 1
    return 1
    elif (( arg > 2 )); then
    echo "Number Of Argument more than 2!" >&2
    USAGE 1
    return 1
    elif (( arg < 2)); then
    echo "Number Of Argument less than 2!" >&2
    USAGE 1
    return 1
    else
    return 0
    fi
}

valid_Arg(){
    local dir="$1"
    local days="$2"
    if  [[ ! -d "$dir" ]]; then
    echo "Given Directory Does not exist!." >&2
    USAGE 1
    return 1
    elif [[ ! "$days" =~ ^[[:digit:]]{1,2}$ ]]; then
    echo "Incorrect Format For Days!" >&2
    USAGE 2
    return 1
    else
    return 0
    fi
}


operate_files(){
    local dir="$1"
    local t="$2"
    local fcheck=0
    fcheck="$(wc -l < <(find "$dir" -type f -name "*.log" -mtime +"$t"))"
    if (( fcheck == 0)); then
    echo "Given Directory Does not Contain any matching Files. Exiting." >&2
    return 1
    else
    find "$dir" -type f -name "*.log" -mtime +"$t"
    read -rp "Do you want to delete these files? [Yy/Nn] " -n 1
    echo ""
    case "$REPLY" in
    y|Y)
        
        if find "$dir" -type f -name "*.log" -mtime +"$t" -exec rm -v '{}' ';'; then
        echo "Files Succesfully Deleted."
        return 0
        fi
        ;;
    n|N)
        echo "Files won't be deleted."
        return 0
        ;;
    *)
        echo "Given Option is not valid. Exiting." >&2
        return 1
        ;;
    esac
    fi
}




if valid_ArgCount "$#"; then
if valid_Arg "$@"; then
if operate_files "$@"; then
echo
fi # fi for show_file if
fi # fi for valid_Arg if
fi # fi for valid arg count if
