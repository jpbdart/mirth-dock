#!/bin/bash
#
# Build the mirth connect system in Docker
#
# 03-Feb-25  jpb  Creation
#

# build the mc system
docker build -t mirth-connect:latest .

# Create named volumes
#docker volume create mirth-config
#docker volume create mirth-database
#docker volume create mirth-log

docker run mirth-connect:latest

echo "Done"
