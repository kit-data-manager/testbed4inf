#!/bin/bash
set -e

SERVICE_FOLDER=collection-api
BINARY_NAME=collection-registry

cd /kitdm20/$SERVICE_FOLDER/release
java -cp ".:./config:./$BINARY_NAME.jar" -Dloader.path=file://`pwd`/$BINARY_NAME.jar,./lib/,. -jar $BINARY_NAME.jar

