#!/bin/sh

set -e

brew update && brew upgrade && brew cleanup ;
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U ;
pip install --upgrade pip
npm i -g npm
npm outdated -g ;
npm update -g ;
