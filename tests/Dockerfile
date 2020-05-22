FROM python:3.8

# Volumes are not mounted yet.
ADD docker.bootstrap.sh /
ADD docker.start.sh /

RUN chmod +x /docker.bootstrap.sh
RUN chmod +x /docker.start.sh

RUN /docker.bootstrap.sh

WORKDIR /code
