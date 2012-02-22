#!/bin/bash

. ~/scripts/util.sh

for i in $(ls -1 /sys/class/net/ | sort); do
    bold_print_no_newline "$i"
    paddinglen=${#i}
    (( paddinglen++ ))
    padding=""
    while read myline; do
        echo "${padding}${myline}"
        # we don't want the padding on the first iteration
        padding=$( head -c $paddinglen < /dev/zero | tr '\0' ' ' )
    done < <(ip addr show dev $i | grep --color=no 'inet ')
    # if we didn't output anything put in a newline
    [[ $padding == "" ]] && echo
done
