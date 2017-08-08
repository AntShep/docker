#!/bin/bash

PATH_REPO="/Users/ashepotko/Netsertive/Repo"
PATH_SQL_DATA="/Users/ashepotko/Projects/data"
PATH_SQL_MIGR="/Users/ashepotko/Projects/liquibase-migrations"

OPTIONS=$@
if [[ $OPTIONS == *"-c"* || $OPTIONS == *"-r"* ]]; then
    echo "Clearing containers..."
    ./clear.sh
fi
if [[ $OPTIONS == *"-r"* ]]; then
    echo "Removing images..."
    docker rmi app devsql
fi

docker network rm local
docker network create local

docker build --rm -t app ./app/
docker run -it -d --name app -p 80:80 --net local --env-file ./app/app.env --mount type=bind,source=$PATH_REPO,destination=/var/www app

docker build --rm -t devsql ./mysql/
docker run -it -d --name devsql -p 3306:3306 --net local --env-file ./mysql/mysql.env --mount type=bind,source=$PATH_SQL_DATA,destination=/home/data devsql

sleep 10
cd $PATH_SQL_MIGR && ./gradlew update

docker exec devsql ./grants.sh