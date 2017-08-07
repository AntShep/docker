#!/bin/bash
echo "Start launch process... (use '-h' flag to see available options)"

OPTIONS=$@
if [[ $OPTIONS == *"-h"* ]]; then
  echo "List of available options:"
  echo "-b              Run docker-compose command with the '--build' flag"
  echo "-c              Clear all related containers"
  echo "-a              Activate all options"
  exit
fi

OPTIONS=$@
if [[ $OPTIONS == *"-a"* ]]; then
    OPTIONS='-b -c'
fi

if [[ $OPTIONS == *"-c"* ]]; then
    echo "Clear all related containers..."
    echo "docker-compose down"
    docker-compose down
fi

if [[ $OPTIONS == *"-b"* ]]; then
    echo "Start build process..."
    echo "docker-compose up --build -d --force-recreate"
    docker-compose up --build -d --force-recreate
else
    echo "docker-compose up -d --force-recreate"
    docker-compose up -d --force-recreate
fi

echo "Start build process..."
docker attach app


#
#
#echo "Start launch process... (use '-h' flag to see available options)"
#
#OPTIONS=$@
#if [[ $OPTIONS == *"-h"* ]]; then
#  echo "List of available options:"
#  echo "-c              Clear/Remove all existing containers"
#  echo "-b              Build existing images"
#  echo "-a              Activate all options"
#  exit
#fi
#
#if [[ $OPTIONS == *"-a"* ]]; then
#    OPTIONS='-c -b'
#fi
#
#if [[ $OPTIONS == *"-c"* ]]; then
#    echo "Clearing of existing containers ..."
#    ./clear.sh
#fi
#
#if [[ $OPTIONS == *"-b"* ]]; then
#    echo "Build the 'app' image..."
#    docker build -t app ./app/
#fi
#
#echo "Run the 'app' container"
#docker run -it -d --name app -p 80:80 --env-file ./app/app.env --mount type=bind,source=/Users/ashepotko/Netsertive/Repo,destination=/var/www app
#
#docker build --rm -t devsql ./mysql/
#docker run -it --rm --name devsql -p 3306:3306 --env-file ./mysql/mysql.env devsql

#
#echo "Run the 'mysql' container"
#docker run -it -d --name mysql -p 3306:3306 --env-file ./mysql/mysql.env mysql