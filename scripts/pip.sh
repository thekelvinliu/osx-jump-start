#!/usr/bin/env bash
# pip.sh - script to install python libraries via pip

# Installs a library via pip
function pip_install {
    if pip_installed $1; then
        echo "$GREEN$1$RESET is already installed."
    else
        pip install $1
    fi
}

# Checks whether given library is already installed
function pip_installed {
    pip freeze --local | fgrep -q $1
}

# Installs a library via pip3
function pip3_install {
    if pip3_installed $1; then
        echo "$GREEN$1$RESET is already installed."
    else
        pip3 install $1
    fi
}

# Checks whether given library is already installed
function pip3_installed {
    pip3 freeze --local | fgrep -q $1
}

#ipython
if pip_installed ipython; then
    echo "$GREEN"ipython"$RESET" is already installed.
else
    pip install ipython[zmq,qtconsole,notebook,test]
fi
if pip_installed ipython; then
    echo "$GREEN"ipython"$RESET" is already installed.
else
    pip install ipython[zmq,qtconsole,notebook,test]
fi
pip_install requests && pip3_install requests
pip_install beautifulsoup4 && pip3_install beautifulsoup4
pip_install Flask

