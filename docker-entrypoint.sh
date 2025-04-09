#!/bin/bash
set -e

echo "Starting Mirth Connect..."

# If MIRTH_PROPERTIES is set, apply it to Mirth's configuration
echo "Checking for custom mirth.properties..."
if [ -f "/config/mirth.properties" ]; then
    echo "Using custom mirth.properties..."
    cp /config/mirth.properties $MIRTH_HOME/conf/mirth.properties
fi

#server ID
if ! [ -z "${SERVER_ID+x}" ]; then
  echo -e "server.id = ${SERVER_ID//\//\\/}" > /opt/connect/appdata/server.id
fi

# Start Mirth Connect
exec $MIRTH_HOME/mcserver
