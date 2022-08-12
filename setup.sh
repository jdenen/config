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
    git
    gnutls
    gnupg
    k9s
    lazygit
    make
    pinentry-mac
    pre-commit
    ripgrep
    sd
    wxmac
)

/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/johnsondenen/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

for cask in ${BREW_CASKS[@]}; do
    brew tap $cask
done

brew install $BREW_PKGS

for plugin in ${ASDF_PLUGINS[@]}; do
    asdf plugin add $plugin
done

mkdir -p ~/Code && cd ~/Code
git clone https://github.com/jdenen/config && cd config

chmod u+x bin
for f in $(ls -a dot/.*); do cp $f ~; done

curl -L git.io/antigen > ~/antigen.zsh

asdf install

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
mkdir -p ~/.config/lvim/
cp config.lua ~/.config/lvim/

# TODO
# key=$(gpg --list-secret-keys --keyid-format LONG | grep -e "^sec" | cut -d'/' -f2 | cut -d' ' -f1)
# git config --global user.signingkey $key
