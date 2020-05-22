#!/bin/sh

# This is your start script.
# This should contain the same set of commands that you would use every time you deploy the app to production.
# You should replace all the commands below with your commands.

# You are in /code inside the container

cd app || exit
yarn start --watch
