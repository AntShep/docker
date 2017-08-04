#!/bin/bash
#if [[ $# -ne 0 && ($1 == '-b' || $1 == 'build') ]]; then
#    echo "docker-compose up --build -d --force-recreate"
#    docker-compose up --build -d --force-recreate
#else
#    echo "docker-compose up -d --force-recreate"
#    docker-compose up -d --force-recreate
#fi

## build the mysql container
#docker build -t mysql ./mysql/
#
## build the app container
#docker build -t app .
#
## create the network
#docker network create local-net
#
## start the mysql container
#docker run -d --net local-net -p 3306:3306 --name mysql.local mysql
#
## start the app container


echo "Clearing of existing containers ..."
./clear.sh

echo "Build the 'app' image..."
docker build -t app ./app/

echo "Run the 'app' container"
docker run --rm -it --name app.local -p 80:80 -e ./app/app.env --mount type=bind,source=/Users/ashepotko/Netsertive/Repo,destination=/var/www app

