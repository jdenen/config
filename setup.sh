#!/usr/bin/env bash

function _install_homebrew {
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/johnsondenen/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

function _tap_brew_casks {
  brew tap homebrew/cask-fonts
}

function _install_asdf_plugins {
  for plugin in direnv elixir erlang neovim nodejs python rust; do
    asdf plugin add $plugin
  done
}

function _install_brew_packages {
  brew install \
    asdf autoconf cmake ddgr docker fd font-hasklig git gnutls gnupg k9s \
    lazygit make pinentry-mac pre-commit ripgrep sd wxmac
}

function _get_antigen {
  curl -L git.io/antigen > ~/antigen.zsh
}

function _clone_repo {
  git clone https://github.com/jdenen/config ~/Code/config
}

function _setup_zsh {
  chmod u+x ~/Code/config/bin
  for f in $(ls -a ~/Code/config/bin/dot/.*); do cp $f ~; done
}

function _install_nvm {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  nvm use system || nvm install --lts && nvm use --lts
}

function _asdf_install {
  (
    cd ~/Code/config/dot
    asdf install
  )
}

function _isntall_lvim {
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
  mkdir -p ~/.config/lvim/
  cp ~/Code/config/config.lua ~/.config/lvim/
}

_install_homebrew
_tap_brew_casks
_install_brew_packages
_install_asdf_plugins
_get_antigen
_clone_repo
_setup_zsh
_install_nvm
_asdf_install
_install_lvim

# TODO: Setup GPG
# key=$(gpg --list-secret-keys --keyid-format LONG | grep -e "^sec" | cut -d'/' -f2 | cut -d' ' -f1)
# git config --global user.signingkey $key
