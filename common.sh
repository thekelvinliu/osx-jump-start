# bootstraps a common and minimal environment for scripts

# variables
MJS_BASE=${MJS_BASE:-"$HOME/macos-jump-start"}
. "$MJS_BASE/dotfiles/.colors"
DONE_MSG="$GREEN$BOLD d o n e$RESET"

# functions
# check whether first argument is a command
exists() {
  command -v $1 &> /dev/null
}

# check whether homebrew is installed
has_brew() {
  exists brew
}

# check whether a cask is installed
brew_cask_installed() {
  fgrep -qsx "$1" <(brew cask list -1)
}

# install a cask
brew_cask_install() {
  if brew_cask_installed "$1"; then
    echo "$BLUE$1$RESET is already installed."
  else
    brew cask install "$1"
  fi
}

# check whether a formula is installed
brew_installed() {
  fgrep -qsx "$1" <(brew list -1)
}

# install a homebrew formula
brew_install() {
  # get only the name of the formula
  formula=$(echo "$1" | cut -d' ' -f1)
  if brew_installed "$formula"; then
    echo "$BLUE$formula$RESET is already installed."
  else
    echo "$1" | xargs brew install
  fi
}

# check whether a tap is tapped
brew_tapped() {
  fgrep -qsx "$1" <(brew tap)
}

# tap a homebrew tap
brew_tap() {
  if brew_tapped "$1"; then
    echo "$BLUE$1$RESET is already tapped."
  else
    brew tap "$1"
  fi
}

# check whether a library is installed with pip2
pip2_installed() {
  pip2 show "$1" &> /dev/null
}

# install a python library with pip2
pip2_install() {
  if pip2_installed "$1"; then
    echo "$BLUE$1$RESET is already installed."
  else
    pip2 install "$1"
  fi
}

# check whether a library is installed with pip3
pip3_installed() {
  pip3 show "$1" &> /dev/null
}

# install a python library with pip3
pip3_install() {
  if pip3_installed "$1"; then
    echo "$BLUE$1$RESET is already installed."
  else
    pip3 install "$1"
  fi
}

# expand any path to an absolute
realpath() {
  /usr/bin/python -c "import os,sys; print os.path.realpath(sys.argv[1])" "$1"
}
