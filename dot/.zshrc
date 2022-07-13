source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle asdf
antigen bundle docker
antigen bundle osx
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-completions

antigen theme bureau

antigen apply

eval "$(direnv hook zsh)"

alias da='direnv allow'
alias g=lazygit
alias logn='git log -n "$1"'
alias ls='ls -aFG'
alias pose='docker compose'
alias rgenv='env | sort | rg -i'
alias s=ddgr
alias vi=lvim
alias vim=lvim

export EDITOR=lvim
export PATH="${PATH}:${HOME}/Code/config/bin:${HOME}/.local/bin"
