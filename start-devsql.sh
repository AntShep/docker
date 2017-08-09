#!/bin/bash
. ./util.sh

coloredEcho "Started executing $(basename "$0")...." ${RED}

CONFIG="./config.cfg"
coloredEcho "Reading config '$CONFIG'...."
. ./config.cfg

ARGS=$@
if [[ $(inArrayEcho "-b" "$ARGS") -eq 1 || $(inArrayEcho "build" "$ARGS") -eq 1 ]]; then
    coloredEcho "Building image..."
    evalCommand "docker build --rm -t devsql ./mysql/"
fi

CONTAINER=$(docker ps -aq -f "name=devsql")
if [[ ! -z $CONTAINER ]]; then
    coloredEcho "Stopping container..."
    evalCommand "docker stop devsql && docker rm devsql"
fi

coloredEcho "Running container..."
evalCommand "docker run -it -d --name devsql -p 3306:3306 --net local --env-file ./mysql/mysql.env --mount type=bind,source=$PATH_SQL_DATA,destination=/home/data devsql"

sleep 10
cd $PATH_SQL_MIGR && ./gradlew update

docker exec devsql ./grants.sh

if [[ $(inArrayEcho "-at" "$ARGS") -eq 1 || $(inArrayEcho "attach" "$ARGS") -eq 1 ]]; then
    coloredEcho "Attaching container..."
    evalCommand "docker attach devsql"
fi
