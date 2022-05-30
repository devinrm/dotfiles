#!/bin/sh

set -e

brew update && brew upgrade && brew cleanup ;
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U ;
pip install --upgrade pip
asdf update
asdf plugin-update --all
gem update
gem update --system
npm i --location=global npm
npm outdated --location=global ;
npm update --location=global ;
