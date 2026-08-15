#!/usr/bin/env bash

###
# convienience methods for requiring installed software
###

# source ./echos.sh

function sourceNVM(){
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
}

function require_nvm() {
    mkdir -p ~/.nvm
    cp $(brew --prefix nvm)/nvm-exec ~/.nvm/
    sourceNVM
    nvm install $1
    ok
}
