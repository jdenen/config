#!/usr/bin/env bash

export ASDF_PLUGINS=(
    direnv
    elixir
    erlang
    neovim
    nodejs
    python
    rust
)

export BREW_CASKS=(
    homebrew/cask-fonts
)

export BREW_PKGS=(
    asdf
    autoconf
    cmake
    ddgr
    docker
    fd
    font-hasklig
    font-source-code-pro
    git
    gnutls
    gpg
    iterm2
    make
    pinentry-mac
    pre-commit
    ripgrep
    sd
    wxmac
)

/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

for cask in ${BREW_CASKS[@]}; do
    brew tap $cask
done

brew install $BREW_PKGS

for plugin in ${ASDF_PLUGINS[@]}; do
    asdf plugin add $plugin
done

curl -L git.io/antigen > ~/antigen.zsh
cp dot/* ~
cp -r bin ~/Code
cp -r iex ~/Code
chmod u+x ~/Code/bin/*

asdf install

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
mkdir -p ~/.config/lvim/
cp config.lua ~/.config/lvim/

# TODO
# key=$(gpg --list-secret-keys --keyid-format LONG | grep -e "^sec" | cut -d'/' -f2 | cut -d' ' -f1)
# git config --global user.signingkey $key
