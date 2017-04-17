source "$HOME/.bashrc"

export PATH="$HOME/.nix-profile/bin:$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:$PATH"
eval "$(rbenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
