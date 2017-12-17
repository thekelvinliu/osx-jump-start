# installs nvm, node, and some global packages

# get a common execution environment
MJS_BASE=${MJS_BASE:-"$HOME/macos-jump-start"}
. "$MJS_BASE/common.sh"
. "$MJS_BASE/dotfiles/.aliases"

# ensure homebrew is installed before continuing
if ! has_brew; then
  echo "homebrew is not installed -- exiting."
  return
fi

# update formulae
brew update

# node
brew_install nvm

# set up nvm now
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
. $(brew --prefix nvm)/nvm.sh

# default globals
tee "$NVM_DIR/default-packages" <<EOF > /dev/null
npm-check-updates
serverless
yarn
EOF

# install latest version of node
nvm install node

# install/upgrade npm if it is outdated
local_version=$(npm -v)
[[ "$local_version" != $(npm v npm version) ]] && npm i -g npm
# install/upgrade globals if yarn is outdated
local_version=$(npm list -g --depth=0 | fgrep yarn | cut -d'@' -f2)
[[ "$local_version" != $(npm v yarn version) ]] && install-npm-globals
unset local_version

# clean things up
brew cleanup
