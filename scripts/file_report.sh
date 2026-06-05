#!/bin/bash
HELP() {
    echo "Usage = ./${0##*/} FILE..."
}
Summary() {
if (( total_count > 0 )); then
cat <<- _EOF_
Total Directories Provided as Arguments = $total_count
Total Sub Directories traversed = $max_Sdir  
Total Sub Directory Files traversed = $max_Sfile
_EOF_
fi
if (( total_count[2] > 0 )); then
    echo "Total Invalid Paths = ${total_count[2]}"
fi
if (( total_count[1] > 0 )); then
    echo "Total Files provided as arguments = ${total_count[1]}"
fi
}

DirCount() {
    local dir="$1"
    ((++total_count))
    dir_SDirCount="$(find "$dir" -type d | wc -l)"
    if ((dir_SDirCount > 0)); then
        ((--dir_SDirCount)) # to exclude the directory itself from the count
    fi
}
FileCount() { # for counting number of files in directory
    local file="$1"
    dir_fcount="$(find "$file" -type f | wc -l)"
}
Report() { #  print the report for individual directories
    local dir="$1"
    local fname="$2"
    cat <<- _EOF_
Directory Name = $fname
Total Number of Sub Directories = $dir_SDirCount
Total Number of Files = $dir_fcount

_EOF_
    return
}
total_count=(0 0 0) # index 0 -> directory , 1 -> file , 2 -> invalid path.
max_Sdir=0
max_Sfile=0
dir_fcount=
dir_SDirCount=

if (("$#" < 1)); then
echo "No Arguments Provided. Exiting." >&2
HELP
exit 1
else
for file in "$@"; do 
fname="$(basename "$file")"
if [[ -e "$file" ]]; then
if [[ -d "$file" ]]; then # if its directory
DirCount "$file" # funcion counting sub directories
FileCount "$file" # function counting files in the directory
elif [[ -f "$file" ]]; then
((++total_count[1])) 
fi # end of file check
else 
((++total_count[2]))
continue;
fi # end of file existence check
if [[ -d "$file" ]]; then
Report "$file" "$fname" # function to print the report for individual directories
else 
echo -e "${fname%.*} is a regular File.\n"
fi
max_Sdir=$((max_Sdir+dir_SDirCount))
max_Sfile=$((max_Sfile+dir_fcount))
dir_SDirCount=0
dir_fcount=0
done
Summary 
sleep 3
fi