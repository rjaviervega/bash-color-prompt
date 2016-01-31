PATH="/opt/local/bin:/Users/javiervega/.apportable/SDK/bin:$PATH"

alias p="pwd"
alias l="ls -a"
alias ll="ls -l"
alias c="cd ..; pwd"
alias cls="clear"

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -lGFh'

PURPLE='\e[0;35m'


function parse_git_dirty {
[[ $(/usr/bin/git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

############################################
# Modified from emilis bash prompt script
# from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
#
# Modified for Mac OS X by
# @corndogcomputer
###########################################
# Fill with minuses
# (this is recalculated every time the prompt is shown in function prompt_command):
fill="--- "
reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
prompt_style=$reset_style
command_style=$reset_style'\[\033[1;29m\]' # bold black
# Prompt variable:
#PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u@\h:\w\$'"$command_style "
# 
#PS1='\[\033[33;1m\]\w\[\033[m\] $fill \t\n'"\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
#
# moved path to fill line
PS1='\[\033[33;1m\]$(pwd)\[\e[0;35m\]$(parse_git_branch)\[\033[m\] $fill \t\n'"\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\033[m\]\$ "
# Reset color for command output
S1='$fill \t\n'"\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\033[00m"' DEBUG
function prompt_command {

git_len=$(parse_git_branch)

# create a $fill of all screen width minus the time string and a space:
let pLen=${#PWD}
let fillsize=${COLUMNS}-9-pLen-2-${#git_len}
fill=""
while [ "$fillsize" -gt "0" ]
do
	fill="-${fill}" # fill with underscores to work on
	let fillsize=${fillsize}-1
done
# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		bname=`basename "${PWD/$HOME/~}"`
		echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
		;;
	*)
		;;
esac
}
PROMPT_COMMAND=prompt_command


