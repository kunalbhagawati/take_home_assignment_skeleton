# !!! Change this to the language/image of your choice. Avoid alpine containers unless you are confident.
# They often have less dependancies bundled and you might find out something essential is missing at the last moment.
FROM python:3.8.3

# Volumes are not mounted yet. Your files in this folder are not available yet. We copy these 2 manually.
ADD docker.bootstrap.sh /
ADD docker.start.sh /

# This is where your app code stays inside the container
RUN mkdir /code

RUN chmod +x /docker.bootstrap.sh
RUN chmod +x /docker.start.sh

# Run any additional steps right now. This is like if you had to configure a blank linux based server for the first time.
# Check the image above to see what extra it does, so you may not have to.
# For example, the `python:3.8.3` image installs python 3.8 for you.
RUN /docker.bootstrap.sh

WORKDIR /code
