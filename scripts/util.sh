manopt() { man $1 | sed -n "/^\s\+-\+$2\b/,/^\s*$/p"|sed '$d;'; } 

bold_print()
{
    echo -e "\033[1m$1\033[0m $2"
}

bold_print_no_newline()
{
    echo -ne "\033[1m$1\033[0m $2"
}


### Below here is for PROMPT_COMMAND and PS1 fun ###
# example usage:
# source ~/school/and_such_as/dot_rands/dot_ansicolor
# MYPS1FRONT="$C_BROWN(\w)\n$C_LIGHT_RED\u$C_BLUE@$C_LIGHT_RED\H$C_GREEN[$C_RED"
# MYPS1BACK="$C_GREEN]$C_LIGHT_RED\$ $C_RESET"
# source ~/school/and_such_as/scripts/util.sh
# PROMPT_COMMAND=myps1messages


appendMessage()
{
	#if $MESS has non-zero length:
	if [ -n "$MESS" ]
		then
			MESS="${MESS},$1"
		else
			MESS="$1"
	fi
}

myps1messages()
{
    MESS=""
    #append the command history
    #appendMessage "!\!"
    #append the load average over the past 1 minute
    #appendMessage `uptime | sed 's/\(.*load\ average:\ \)//g' | sed 's/,.*$//g'`

    #svn status
    # [ `svn status -N 2>/dev/null | awk 'BEGIN {i=0} {i++} END {print i}'` -gt 0 ] && appendMessage "svn changes"

    git_stuff=$(__git_ps1 "(%s)")
    [ `echo $git_stuff | wc -c` -gt 2 ] && appendMessage $git_stuff

    # chroot status
    root_inode=$(stat -c %i /)
    [[ $root_inode != 2 && $root_inode != 128 ]] && appendMessage "CHROOT"

    PS1="${MYPS1FRONT}${MESS}${MYPS1BACK}"
}

