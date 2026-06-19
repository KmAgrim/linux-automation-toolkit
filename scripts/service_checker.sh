#!/bin/bash
USAGE() {
    local err_type="$1"
case "$err_type" in
1)   
cat <<- _EOF_
Usage: ${0##*/} service_name
_EOF_
;;
2)
cat <<- _EOF_
Number Of Argument more than 1!
_EOF_
;;
esac
if [[ ! -z "$err_type" ]]; then
echo "Exiting..."
fi
}
Service_Check(){
    return 0
}
if (( "$#" == 0)); then
echo "No Argument Provided!" >&2
USAGE 1
elif (( "$#" > 1)); then
USAGE 2
fi