#!/bin/sh

# This is your start script.
# This should contain the same set of commands that you would use every time you deploy the app to production.
# You should replace all the commands below with your commands.

echo "Hello World"
echo "Node: $(python --version)"
tail -f /dev/null

# Setup your dependencies.

# Add your `rails s` or `./manage.py runserver` or such command here.
