#!/bin/bash
USAGE() {
echo "Usage: $(basename "$0") source_directory backup_directory."
}

if [ "$#" -ne 2 ]; then
echo "Number of argument greater or less than 2!. Exiting." >&2
USAGE
exit 1
else
if [[ -d "$1"  && -d "$2" ]]; then # validating whether if user given path are correct or not.
timestamp=$(date +%Y-%m-%d-%H-%M)
tarname="backup_$timestamp.tar.gz"
if tar -czf "$2/${tarname}" "$1"; then
echo "Backup created: in directory $2 named $tarname"
else
echo  "Backup Not Created. Exiting" >&2
exit 1
fi
else
echo "Source or Destination directory path is incorrect." >&2
USAGE
exit 1
fi
fi

