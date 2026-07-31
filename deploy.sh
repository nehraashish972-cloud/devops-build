#!/bin/bash
set -e
IMAGE_NAME=$1
TAG=$2
docker pull $IMAGE_NAME:$TAG
docker stop devops-app || true
docker rm devops-app || true
docker run -d --name devops-app -p 80:80 --restart unless-stopped $IMAGE_NAME:$TAG
