A simple test template for take home assignments.

This repo is not candidate ready yet and this Readme is for you (the interviewer) only.  
Please see the section [Making this candidate ready](#making-this-candidate-ready) below for more details.

**Please go through the `Readme.candidate.md` file to see what the candidate will see finally.**

# Files and directories

- `problem.md`: Explanation of the problem.
- `design-choices.md`: Explanation of the  design choices made by the candidate.
- `docker-basics.md`: Some basic understanding of docker, compose and how they are used here.
- `docker-commands.md`: Commands to help with the assignment.
- `.env`: Environment variables docker-compose picks up from.

- `backend`: Backend server code. Exposed as a service in docker-compose.yml
- `client`: UI. Exposed as a service in docker-compose.

# Making this candidate ready
- Run the 

# Docker design in this assignment
We have 2 directories: `backend` and `client`.

Both of them have 3 main files:
- `Dockerfile`  
Pulls in a base docker image and adds the ability to execute `docker.bootstrap.sh` and `docker.start.sh` on top of it.  
Also creates a `/code` directory and sets it as the default path in the container.  

- `docker.bootstrap.sh`
Empty shell script left for the candidate to fill up. This should reflect what happens when an empty linux based server spins up the first time.
**It ideally should not contain those commands which they would execute every time they'd deploy.**
Everything they do here is part of the final state of the image after the build process.

- `docker.start.sh`
Runs every time the container is created or spins up (`pip install`, `npm install`, `rails db:migrate`, etc).
The last command should be a **continuously running command**. Docker containers will die if it does not run a continuously running process. 
