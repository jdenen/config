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

alias g='lazygit'
alias s='ddgr'
alias da='direnv allow'
alias ef='e -f'
alias es='e -s'
alias ls='ls -aFG'
alias vi='lvim'
alias doc='docker'
alias rge='env | rg -i'
alias vim='lvim'
alias pose='docker compose'

eval "$(direnv hook zsh)"
[ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"

export KERL_CONFIGURE_OPTIONS="--with-ssl=$(brew --prefix openssl@1.1) --without-javac --without-wx"
export POSTGRES_EXTRA_CONFIGURE_OPTIONS="--with-openssl -with-libraries=/usr/local/lib:$(brew --prefix openssl@1.1)/lib --with-includes=/usr/local/include:$(brew --prefix openssl@1.1)/include"
export CPPFLAGS="-I$(brew --prefix unixodbc)/include"
export LDFLAGS="-L$(brew --prefix unixodbc)/lib"
export EDITOR=lvim
export PATH="${PATH}:${HOME}/Code/config/bin:${HOME}/.local/bin"
