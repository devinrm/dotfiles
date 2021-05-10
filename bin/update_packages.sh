#!/bin/sh

set -e

brew update && brew upgrade && brew cleanup ;
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U ;
npm outdated -g ;
npm update -g ;
