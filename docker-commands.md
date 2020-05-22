- `docker-compose up <service_1> <service_2> ...`  
`docker-compose up postgres redis mongo`  
Spins up postgres, redis and mongo if you need them. Ports are exposed to other containers but not to the host machine.

- `docker-compose up backend client`
Spins up the backend and the client. Exposes ports to the host machine

- `docker-compose build <service_name>`
Builds the container for <service_name> from the image, but does not run it. Handled automatically by `docker-compose up`.

- `docker-compose run --rm <service_name> <command>`  
`docker-compose run --rm backend bash`
Runs the <command> inside **a** container for <service_name> from the image. **This does not run on your existing container, but creates a new one**.  
`--rm` removes this newly created container after you exit it. If you do not pass this flag, the container will still be available for use later. 

- `docker-compose stop <service_name>`
Stops all containers for <service_name> from the image (`SIGTERM` failing which `SIGKILL`).

- `docker-compose kill <service_name>`
Similar to `stop`, but hard kills the containers (`SIGKILL` directly).

- `docker-compose rm <service_name>`
Removes all containers for <service_name>. This means on doing an `up`, all containers for this service are going to be recreated, and any state or information you might have stored **after the build process** will now be gone.

!!! Here be dragons !!!

- `docker system prune`
Removes all containers, images, everything from your host.  
THIS IS INSANELY DANGEROUS **IF YOU ARE HAVE BEEN USING DOCKER SINCE BEFORE**.  
**This is just meant to help those candidates that have never worked with or installed docker before, and do not want artifacts dangling behind**.
If you are not sure what this does, or how it affects you, please read this carefully.
https://docs.docker.com/engine/reference/commandline/system_prune/
