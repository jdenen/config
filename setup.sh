#!/usr/bin/env bash

export ASDF_PLUGINS=(
    direnv
    elixir
    erlang
    nodejs
)

export BREW_CASKS=(
    d12frosted/emacs-plus
    homebrew/cask-fonts
)

export BREW_PKGS=(
    asdf
    autoconf
    cmake
    docker
    editorconfig
    emacs-plus@28 --with-no-titlebar --with-modern-sexy-v2-icon
    fd
    font-hasklig
    font-source-code-pro
    git
    gnutls
    gpg
    iterm2
    pinentry-mac
    pre-commit
    ripgrep
    sd
    wxmac
)

# PACKAGE INSTALLATION
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

for cask in ${BREW_CASKS[@]}; do
    brew tap $cask
done

brew install $BREW_PKGS

for plugin in ${ASDF_PLUGINS[@]}; do
    asdf plugin add $plugin
done

git clone https://github.com/jdenen/config ~/Code
cd ~/Code

# EMACS
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/org-tangle emacs.org
~/.emacs.d/bin/doom sync

# GIT
~/.emacs.d/bin/org-tangle git.org
# TODO
# key=$(gpg --list-secret-keys --keyid-format LONG | grep -e "^sec" | cut -d'/' -f2 | cut -d' ' -f1)
# git config --global user.signingkey $key

# ELIXIR
~/.emacs.d/bin/org-tangle elixir.org

git clone https://github.com/elixir-lsp/elixir-ls ~/.elixir_ls
(
    cd ~/.elixir_ls
    git checkout $(git tag --sort=committerdate | head -1)
    cp .release-tool-versions .tool-versions
    asdf install
    mix do local.hex --force, local.rebar --force, deps.get, compile, elixir_ls.release -o release
)

# ZSH
curl -L git.io/antigen > ~/antigen.zsh
~/.emacs.d/bin/org-tangle zsh.org
chmod u+x ~/Code/bin/*
