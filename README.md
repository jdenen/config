# MacOS <> Elixir with LunarVim

Configuration for my MacOS development environment:
+ [Oh My Zsh](https://ohmyz.sh)
+ Git with GPG signing
+ [Elixir](https://elixir-lang.org), Erlang, NodeJS managed by `asdf`
+ [LunarVim](https://lunarvim.org)

## Setup

Run these commands to setup the environment:

```bash
# Install Homebrew and Git
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install git

# Clone this repo and run ./setup.sh
git clone https://github.com/jdenen/config
( cd config && chmod u+x setup.sh && ./setup.sh )
```
