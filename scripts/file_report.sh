#!/bin/bash
PROGNAME="$(basename "$0")"
HELP() {
    echo "Usage = ./${PROGNAME} FILE..."
}
Summary() {
if (( arg_Dir > 0 )); then
cat <<- _EOF_
Total Directories Provided as Arguments = $arg_Dir
Total Sub Directories traversed = $max_Sdir  
Total Sub Directory Files traversed = $max_Sfile
_EOF_
fi
if (( ivalid_path > 0 )); then
    echo "Total Invalid Paths = ${ivalid_path}"
fi
if (( arg_file > 0 )); then
    echo "Total Files provided as arguments = ${arg_file}"
fi
}

DirCount() {
    local dir="$1"
    arg_Dir=$((arg_Dir+1))
    dir_SDirCount="$(find "$dir" -type d | wc -l)"
    if ((dir_SDirCount > 0)); then
        dir_SDirCount=$((dir_SDirCount - 1)) # to exclude the directory itself from the count
    fi
}
FileCount() {
    local file="$1"
    dir_fcount="$(find "$file" -type f | wc -l)"
}
Report() { # this function will be used to print the report for individual directories
    local dir="$1"
    local fname="$2"
    cat <<- _EOF_
Directory Name = $fname
Total Number of Sub Directories = $dir_SDirCount
Total Number of Files = $dir_fcount

_EOF_
    return
}

ivalid_path=0
arg_Dir=0
arg_file=0
max_Sdir=0
max_Sfile=0
dir_fcount=0
dir_SDirCount=0

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
arg_file=$((arg_file+1)) 
fi # end of file check
else 
ivalid_path=$((ivalid_path+1))
continue;
fi # end of file existence check
if [[ -d "$file" ]]; then
Report "$file" "$fname" # function to print the report for individual directories
else 
echo -e "${fname} is a regular File.\n"
fi
max_Sdir=$((max_Sdir+dir_SDirCount))
max_Sfile=$((max_Sfile+dir_fcount))
dir_fcount=0 # reset the counter so max_Sdir and max_Sfile will be correct
dir_SDirCount=0
done
Summary 
sleep 3
fi