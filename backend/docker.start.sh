#!/bin/sh

# This is your start script.
# This should contain the same set of commands that you would use every time you deploy the app to production.
# You should replace all the commands below with your commands.

# Setup your dependencies.
pip install -r requirements.txt

# Add your `rails s` or `./manage.py runserver` or such command here.
FLASK_ENV=development FLASK_DEBUG=1 flask run
