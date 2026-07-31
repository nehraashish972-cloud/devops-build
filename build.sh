#!/bin/bash
set -e
IMAGE_NAME=$1
TAG=$2
echo "Building image: $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG .
