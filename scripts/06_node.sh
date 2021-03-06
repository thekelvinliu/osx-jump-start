#!/usr/bin/env bash
# install nvm, some global packages, and yarn

# get a common execution environment
[[ ! $MJS_COMMON_ENV ]] && . "${MJS_BASE:-"$HOME/macos-jump-start"}/common.sh"

# ensure homebrew is installed before continuing
if ! has_brew; then
  echo "homebrew is not installed -- exiting."
  exit 1
fi

# default globals
NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
cat <<EOF > "$NVM_DIR/default-packages"
npm-check-updates
prettier
serve
typescript
typescript-language-server
yarn
EOF

# nvm and setup
formula=nvm
if brew_installed "$formula"; then
  echo -e "$BLUE$formula$RESET is already installed."
else
  brew install "$formula"
  . "$(brew --prefix nvm)/nvm.sh"

  # install latest lts and version
  nvm install --lts --latest-npm
  nvm install node --latest-npm
  nvm alias default node
fi
