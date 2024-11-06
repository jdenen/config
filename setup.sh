#!/usr/bin/env bash

BREW_PACKAGES=(
  asdf
  cmake
  curl
  docker
  fd
  font-hasklig
  fop
  fzf
  git
  gnutls
  gnupg
  gum
  helix
  lazygit
  make
  openssl@3
  ripgrep
  sd
  tmux
  tree
  watch
  wxmac
)

function _install_homebrew {
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/johnsondenen/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

function _tap_brew_casks {
  brew tap homebrew/cask-fonts
}

function _install_asdf_plugins {
  for plugin in direnv elixir erlang rust; do
    asdf plugin add $plugin
  done
}

function _install_brew_packages {
  brew install $BREW_PACKAGES
}

function _setup_zsh {
  echo "source $PWD/dot/.zshrc" >> ~/.zshrc
}

function _move_dot_files {
  for f in .gitattributes .gitconfig .gitignore .tmux.conf; do
    cp $f ~
  done
}

_install_homebrew
_tap_brew_casks
_install_brew_packages
_install_asdf_plugins
_setup_zshrc
_move_dot_files

# TODO: Setup GPG
# key=$(gpg --list-secret-keys --keyid-format LONG | grep -e "^sec" | cut -d'/' -f2 | cut -d' ' -f1)
# git config --global user.signingkey $key
