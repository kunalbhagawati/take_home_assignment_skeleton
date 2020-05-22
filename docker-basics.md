If you are already familiar with docker and compose, please feel free to skip to [Docker design in this assignment](#Docker-design-in-this-assignment) section below.

# A small primer on Docker use here
If you have not worked with docker before, think of it as a way for you to run your code isolated inside a lightweight Virtual Machine (although in reality it is quite different from that). Your OS is the `host machine` here.

Docker builds `containers` from `images`, analogous to how instances are built from classes.  
Maybe a better analogy would be how you would write to a CD/DVD from an image (.iso) file. The .iso file is the image here and the CD with the data is the container.

This means each container runs like its own Linux machine, so it is easier to think of it here in this assignment as a production AWS instance.  
The container exposes ports to communicate with the outside world.  

Since the container is basically an empty linux machine that is built from scratch, it does not have anything other than what a fresh install would have, plus some additional dependencies that your selected image gives.
For example the `python:3.8.3` image is basically like installing a fresh linux install + the python 3 ecosystem installed also.
Likewise, the `postgres:12.3-alpine` image is like an empty Alpine linux install + postgres 12.

The only tricky new concept might be `volumes`. Volumes basically say what data from the host machine (your OS) should also go into the container.  

You will need to tell the container about your data somehow: 
- You could copy the required directories/files from your host machine when the container/image is being built.
- You can tell docker that "this folder and these files should be mounted (pointed) to by the container in this location", similar to a network shared folder (just an analogy, not in reality).  
Docker handles the rest. This is what we do here.

Some beginner friendly introductions:
- https://medium.com/codingthesmartway-com-blog/docker-beginners-guide-part-1-images-containers-6f3507fffc98
- https://www.freecodecamp.org/news/docker-simplified-96639a35ff36/ 
 
#### Docker-compose
Docker compose is a tool on top of docker that makes it easier to work with images and containers. 
Without it you'd have to configure and run a lot of commands yourself! 

For example, if you run the `postgres` container and the `backend` container without compose, you'd somehow have to make them understand they are on the same network.  
Which would mean you'd have to ask docker to create a network for these containers. You'd then ask these containers on startup to connect to this network.  
Whew! Compose does all of this for you. :)

A simpler introduction:
- https://docs.docker.com/compose/gettingstarted/ 
- https://docker-curriculum.com/#docker-compose

**Compose comes with the docker system and you normally won't have to install it.**

## Connecting to you containers
Let's take this configuration to explain by example:
```yaml
services:
  redis:
    # ...
    expose:
      - 6379
  backend:
    # ...
    ports:
      - "3000:3000"
```

#### Network
- If you wanted to connect to the container **as an external service i.e say through Google Chrome, redis-cli, mysql or such**, it would be basically like connecting to another server, just on localhost.
This is similar to how redis server, mysql server, etc operate. They run a server locally in your machine.  
Thus you'd connect to `localhost:port_the_container_exposes`.
- If you wanted to connect to a container **from inside another container**, it would take the host name as the container name.  
So from inside the `backend` container, connection to the redis container would be `redis:6379`.

#### Ports
- The docker container will not expose it's ports by default.
- `expose`: You can expose them **to other containers, but not the host machine**, with the `expose` setting in the `docker-compose.yml`  
The `redis` container would not expose its `6379` port to the host machine. So `redis-cli -p 6379` from outside docker will fail. But the `backend` container would be able to connect.
- `ports`: You can also **expose them to your host machine** with the `ports` setting in the `docker-compose.yml` file.  
Hitting `localhost:3000` from Postman or Chrome hit your backend API server.

# Docker design in this assignment
We have 2 directories: `backend` and `client`.
Both of them have 3 main files:
- `Dockerfile`  
Pulls in a base docker image of your choosing and adds the ability to execute `docker.bootstrap.sh` and `docker.start.sh` on top of it.  
Also creates a `/code` directory and sets it as the default path in your container.  
Volumes are not mounted yet, so any file you want to access, should be copied to the build process using `ADD` or `COPY` directives.

- `docker.bootstrap.sh`
Empty shell script left to you to fill up. This should reflect what you would do when you spin up an empty linux based server the first time.
**It ideally should not contain those commands which you want to execute every time you'd deploy.**
Everything you do here is part of the final state of the image after the build process. Think of this as adding another layer of commands and artifacts to the final image.

- `docker.start.sh`
Runs every time the container is created or spins up. Note the word "container" here and not "image". 
This is basically you `pip install` or `npm install` etc.
The last command should be a **continuously running command**.  
Docker containers will die if it does not run a continuously running process. Usually this will be something like `rails server` or `npm start`. 
