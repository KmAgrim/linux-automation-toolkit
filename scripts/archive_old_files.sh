#!/bin/bash
USAGE(){
    cat <<- _EOF_
    Usage: ./${0##*/} source_dir archive_dir days
    Usage Example 
    ./${0##*/} ~/dummy-src/ ~/dummy-backup/ 15
    Files Archived will be older than the given day.
_EOF_
    return
}
valid_days(){
    local days="$1"
    if [[ -z "$days" ]]; then
    echo "Days argument is empty. Exiting." >&2
    return 1
    elif ! [[ "$days" =~ ^[[:digit:]]{1,2}$ ]]; then 
    cat <<- _EOF_
    Correct Format For days Digits
    Example - 30 15 20
    Exiting.
_EOF_
    return 1
    else 
    return 0
    fi
}



validate(){ # for validating directory and days format
local err=0
for file in "$1" "$2"; do
if [[ ! -d "$file" ]]; then
echo -e "${file} Directory does not exist.\n"  >&2
err=1
fi
done
return ${err}
}

make_archive(){
    local timestamp=$(date +%Y-%m-%d-%H-%M)
    local tarname="archive_$timestamp.tar.gz"
    if tar -czf "$2/${tarname}" -T <(find "$1" -type f -ctime +"$3"); then
    Summary "${2}/${tarname}"
    return 0
    else
    return 1
    fi
}
Summary(){
    cat <<- _EOF_
    Name of the File = ${1##*/}
    total Number of Files Archived = $(wc -l < <(tar -tf "$1"))
    File Size = $(stat -c %s "$1")
    File Created on = $(stat -c %w "$1")
_EOF_

    return 0
}

if (( $# == 3)); then
if validate "$@"; then
if valid_days "$3"; then
if make_archive "$@"; then
echo "Archive Created Succesfully." 
else
echo "Failed To Create Archive. Exiting." >&2
exit 1
fi # fi for closing archive creating block
else
echo -e "Days in Invalid Format." >&2
fi # closing fi block of days validation
else 
echo "Directory Validation Failed. Exiting." >&2
exit 1
fi # fi for validating block
else
echo "Incorrect Number of Argument Provided."
USAGE
fi