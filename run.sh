#!/usr/bin/env bash
set -e


APP_PATH0="build/juce_app_artefacts/Debug/app"
APP_PATH1="build/juce_app_artefacts/app"

APP_PATH=$APP_PATH0

if [ ! -f "$APP_PATH" ]; then
    echo "Error: cannot find $APP_PATH"
    APP_PATH=$APP_PATH1
    echo "Trying $APP_PATH"
    if [ ! -f "$APP_PATH" ]; then
        echo "Error: cannot find $APP_PATH1"
        exit 1
    fi
fi

echo "Running app..."
"$APP_PATH"
