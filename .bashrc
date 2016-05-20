##################################################
# Fix cert issue and re-init docker machine ENV. #
##################################################
function docker_machine_env() {
    docker-machine start default
    docker-machine regenerate-certs default
    eval "$(docker-machine env default)"
}

#################################
# Print context with task list. #
#################################
function task_warrior_status() {
    if [[ $1 ]]; then
	task "$@"
    else
	echo ""
	echo "CONTEXT: $(task _get rc.context)"
	task
    fi
}

alias freq='history | cut -c8- | sort | uniq -c | sort -rn | head'
alias be='bundle exec'
alias ls='ls -lF'
alias t='task_warrior_status'
alias root='cd $(git rev-parse --show-toplevel)'
alias nix='nix-env'
alias src='source /Users/$USER/.bashrc'
alias dm='docker-machine'
alias dmenv='docker_machine_env'

PS1_DATE="\[\033[32m\]\d"
PS1_TIME="\[\033[1;36m\]\T"
PS1_PWD="\[\033[0;37m\]\W"
export PS1="$PS1_DATE $PS1_TIME\n$PS1_PWD\[\033[0m\] $ "
