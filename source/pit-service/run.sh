#!/bin/bash
set -e

SERVICE_NAME=pit-service

cd /kitdm20/$SERVICE_NAME/release
java -cp ".:./config:./$SERVICE_NAME.jar" -Dloader.path=file://`pwd`/$SERVICE_NAME.jar,./lib/,. -jar $SERVICE_NAME.jar

