#!/bin/bash
USAGE(){
    local err="$1"
    if (( err == 1 )); then
    cat <<- _EOF_
Usage: ./${0##*/} PATH
Example 
./${0##*/} logs/
Exiting!
_EOF_
fi
}
valid_ArgC(){
    local args="$1"
    if (( args == 0)); then
    echo "No Argument Provided." >&2
    USAGE 1
    return 1
    elif (( args > 1)); then
    echo "More than one Argument Provided." >&2
    USAGE 1
    return 1
    else
    return 0
    fi
}
valid_Dir(){
    local dir="$1"
    if [[ ! -e "$dir" ]]; then
    echo -e "Given Path does not exit!\n" >&2
    USAGE 1
    return 1
    elif [[ ! -d "$dir" ]]; then
    echo -e "Given Path is not a directory!\n" >&2
    USAGE 1
    return 1
    elif [[ ! -r "$dir" ]]; then
    echo -e "Given Directory not readable for ${USER}!.Exiting.\n" >&2
    return 1
    else
    return 0
    fi
}
TotalSize(){
    local dir="$1"
    local TSize=0
    TSize="$(du -sh "$dir" 2> /dev/null | cut -f 1)"
cat <<- _EOF_
Total Size:
$TSize
_EOF_
    return 0
}
LargestDir(){
    local dir="$1"
cat <<- _EOF_
Largest Directories
$(find "$dir" -mindepth 1 -maxdepth 1 -type d -exec du -h --max-depth=0 '{}' '+' 2> /dev/null | sort -hr | head)

_EOF_
    return 0
}

LargestFile(){
    local dir="$1"
cat <<- _EOF_
Largest Files
$(find "$dir" -type f -exec du -h '{}' '+' 2> /dev/null | sort -hr | head )

_EOF_
    return 0
}


if valid_ArgC "$#"; then
if valid_Dir "$@"; then
TotalSize "$@"
LargestDir "$@"
LargestFile "$@"
fi
fi