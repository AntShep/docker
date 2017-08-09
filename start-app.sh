#!/bin/bash
. ./util.sh

coloredEcho "Started executing $(basename "$0")...." ${RED}

CONFIG="./config.cfg"
coloredEcho "Reading config '$CONFIG'...."
. ./config.cfg

ARGS=$@
if [[ $(inArrayEcho "-b" "$ARGS") -eq 1 || $(inArrayEcho "build" "$ARGS") -eq 1 ]]; then
    coloredEcho "Building image..."
    evalCommand "docker build --rm -t app ./app/"
fi

CONTAINER=$(docker ps -aq -f "name=app")
if [[ ! -z $CONTAINER ]]; then
    coloredEcho "Stopping container..."
    evalCommand "docker stop app && docker rm app"
fi

coloredEcho "Running container..."
evalCommand "docker run -it -d --name app -p 80:80 --net local --env-file ./app/app.env --mount type=bind,source=$PATH_REPO,destination=/var/www app"

if [[ $(inArrayEcho "-at" "$ARGS") -eq 1 || $(inArrayEcho "attach" "$ARGS") -eq 1 ]]; then
    coloredEcho "Attaching container..."
    evalCommand "docker attach app"
fi
