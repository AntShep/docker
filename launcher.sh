#!/bin/bash
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
docker run -it -d --name app -p 80:80 --net local --env-file ./app/app.env --mount type=bind,source=/Users/ashepotko/Netsertive/Repo,destination=/var/www app

docker build --rm -t devsql ./mysql/
docker run -it -d --name devsql -p 3306:3306 --net local --env-file ./mysql/mysql.env --mount type=bind,source=/Users/ashepotko/Projects/data,destination=/home/data devsql