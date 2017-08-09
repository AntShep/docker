#!/bin/bash
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
LBLUE='\033[1;34m'


function inArray () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 1; done
  return 0
}

function inArrayEcho() {
    inArray $@
    local res=$?
    echo $res
}

function coloredEcho() {
local content=$1
local color=${BLUE}
if [[ ! -z $2 ]]; then
    color=$2
fi

echo -e "${color}$content${NC}"
}

function evalCommand() {
    local command=$1

    echo -e "Command: ${GREEN}$command${NC}"
    eval $command
}