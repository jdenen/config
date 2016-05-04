PS1="\[\033[0;31m\]\u \[\033[0;37m\]\w \[\033[1;33m\]\d \[\033[1;36m\]\T\n\[\033[32m\]->\[\033[0m\] "

alias freq='history | cut -c8- | sort | uniq -c | sort -rn | head'
alias be='bundle exec'
alias ls='ls -F'
alias t='task'
alias root='cd $(git rev-parse --show-toplevel)'
