#!/bin/bash
usage_msg="Usage: $0 source_dir backup_dir"
if [ "$#" -ne 2 ]; then
echo "$usage_msg"
exit
else
if [ -d "$1" ] && [ -d "$2" ]; then
timestamp=$(date +%Y-%m-%d-%H-%M)
tarname="backup_$timestamp.tar.gz"
tar -czf "$2/$tarname" "$1" &> /dev/null
if [ "$?" -eq 0 ]; then
echo "Backup created: in directory $2 named $tarname"
else
echo  "Backup Not Created. Exiting"
fi
elif [ ! -d "$1"  ]; then
echo "Source directory path is  incorrect. $usage_msg"
exit
else
echo "Destination directory path is incorrect. $usage_msg"
exit
fi
fi

