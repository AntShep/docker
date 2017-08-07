#!/bin/bash

images=$(docker ps -aq)
echo "Existing containers:"
if [[ ! -z "$images" ]]; then
    echo "$images"
    echo "Stop running containers ..."
    docker stop ${images}
    echo "Removing ..."
    docker rm ${images}
else
    echo "Empty list. Nothing to remove"
fi
