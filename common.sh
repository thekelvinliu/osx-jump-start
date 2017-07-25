#!/usr/bin/env bash
# bootstraps a common and minimal environment for scripts

# get colors
. "./dotfiles/.colors"

# checks whether homebrew is installed
function has_brew {
  [[ -n $(which brew) ]]
}

# checks whether a given cask is already installed
function brew_cask_installed {
  fgrep -qsx "$1" <(brew cask list -1)
}

# installs a cask
function brew_cask_install {
  if brew_cask_installed "$1"; then
    echo "$BLUE$1$RESET is already installed."
  else
    brew cask install "$1"
  fi
}

# checks whether a given formula is already installed
function brew_installed {
  fgrep -qsx "$1" <(brew list -1)
}

# installs a homebrew formula
function brew_install {
  if brew_installed "$1"; then
    echo "$BLUE$1$RESET is already installed."
  else
    brew install "$1"
  fi
}

# checks whether a given tap is already tapped
function brew_tapped {
  fgrep -qsx "$1" <(brew tap)
}

# taps a homebrew tap
function brew_tap {
  if brew_tapped "$1"; then
    echo "$BLUE$1$RESET is already tapped."
  else
    brew tap "$1"
  fi
}