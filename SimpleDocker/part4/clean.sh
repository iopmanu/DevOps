#!/bin/bash

docker stop web_server
docker rm web_server
docker rmi -f server
