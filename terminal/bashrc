#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias ll='ls -alh --color=auto'
alias vi='nvim'
alias vim='nvim'
function git_branch {
	branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
	if [ "${branch}" != "" ];then
		if [ "${branch}" = "(no branch)" ];then
			branch="(`git rev-parse --short HEAD`...)"
		fi
		echo " ($branch)"
	fi
}
PS1='\[\e[35m\]\u \[\e[33m\]\h \[\e[34m\]\w\[\e[31m\]$(git_branch) \[\e[36m\]\$ \[\e[0m\]'
