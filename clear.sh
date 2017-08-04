#!/bin/bash

images=$(docker ps -aq)
echo "Existing containers:"
echo "$images"
if [[ ! -z "$images" ]]; then
    echo "Removing ..."
    docker rm ${images}
else
    echo "Nothing to remove"
fi
