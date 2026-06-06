#!/bin/bash
USAGE() {
echo "Usage: ./${0##*/} source_directory backup_directory."
}
tar_creation(){
timestamp=$(date +%Y-%m-%d-%H-%M)
tarname="backup_$timestamp.tar.gz"
if tar -czf "$2/${tarname}" "$1"; then
echo "Backup created named $tarname in directory $2"
else
echo  "Backup Not Created. Exiting" >&2
exit 1
fi # tar block closing fi
}
if [ "$#" -ne 2 ]; then
echo "Number of argument greater or less than 2!. Exiting." >&2
USAGE
exit 1
else
if [[ -d "$1" ]]; then # validate source directory
if [[ -d "$2"  ]]; then # validate destination directory
tar_creation "$@"
else
echo "Destination directory path is incorrect. Exiting." >&2
exit 1
fi
else
echo "Source directory path is incorrect. Exiting." >&2
USAGE
exit 1
fi # directory check block closing fi
fi

