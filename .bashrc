function changelog() {
    git changelog ${1} ${2} | grep -vE 'Bump|Squashed'
}

function dmenv() {
    docker-machine start default
    docker-machine regenerate-certs default
    eval "$(docker-machine env default)"
}

alias ls='ls -lF'
alias freq='history | cut -c8- | sort | uniq -c | sort -rn | head'
alias root='cd $(git rev-parse --show-toplevel)'
alias be='bundle exec'
alias dm='docker-machine'
alias src='source ~/.bashrc'

PS1_DATE="\[\033[32m\]\d"
PS1_TIME="\[\033[1;36m\]\T"
PS1_PWD="\[\033[0;37m\]\W"
export PS1="$PS1_DATE $PS1_TIME\n$PS1_PWD\[\033[0m\] $ "

export SDKMAN_DIR="~/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"
