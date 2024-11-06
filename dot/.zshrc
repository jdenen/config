export EDITOR=hx
export FZF_DEFAULT_OPTS="--walker-skip=.git,_build,assets --bind 'enter:become(hx {}),ctrl-t:become(mix test {})'"
export PATH="$PATH:/Users/johnson/Code/config/bin"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(asdf direnv fzf macos mix z)
source $ZSH/oh-my-zsh.sh

alias da='direnv allow .'
alias f='fzf'
alias g='lazygit'
alias ls='ls -alF'
alias pose='docker compose'
alias sp='spotify'
