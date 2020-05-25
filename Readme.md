# Container system

Please read these instructions below thoroughly.  
They explain the problem, it's functional requirements, and notes/constraints to keep in mind while designing the system.

Please explain your design choices in the given `design-choices.md` document.

If you are unfamiliar with docker, see the "A small primer on Docker use here" section below.
NOTE: **You can 100% ignore the docker stuff here, and just run your code in your local environment. This is just to help you isolate your project's dependencies and environment.**  
More details in "Things to keep in mind" section below. Please go through it to help us evaluate your code faster. :)   

---

## Problem
You would have seen containers in warehouses.  
You can put items inside a container, and that container can itself be put inside another container and so on.

Let's build one of those. :)

### Entities and definitions
To understand the entities better, let's assume a simple warehouse for clothes. There are two broad types of clothes (amongst others),  
jeans and shirt.

**Inventory**
For now, we can go with a very simple definition of inventory. It as an object in your data store that has:
  - a way to identify what kind of item it is a part of.  
  Here "jeans" and "shirt" are two different kinds of things
  - Some way to identify characteristics unique to all items of a particular kind.  
  You might have different materials for jeans. Or you might have different styles and colours for shirts.
  
  - a way to say how this item is **linked to a `container`.**
  - a way to say how many copies of the same inventory exist i.e the factory would have created a bunch of these and shipped them together to your warehouse. 

**Container**
Think of two squares, one inside the other. That is basically it. The outer square is a container than can hold another container (the inner square).
Each such square can hold either inventory (shirts, jeans, etc) or other containers.

Containers have:
- a way to identify what kind of container it is.  
- a way to say certain kinds of containers can store only other containers, and certain kinds can store only inventory.  
e.g 'racks' can store only other containers, but 'paper bags' can store inventory (chains).  
Yes, even a paper bag is a container. :)
- A container must have a **barcode** to help identify it.  
e.g. "rack" is be the type of the container, but "073500538500xx" is the barcode of that specific container.
- containers can have infinite depth in theory i.e container inside container inside container inside ...  You system should be able to handle this possibility.
But practically they will have a maximum depth of 10 in 99% of the cases.

### Requirements:
Backend:
- We should be able to add new "containers".  
- Containers can hold other containers.
- If a container can hold other containers, it should not be able to hold inventory i.e. **at any given moment, a container can either hold other containers inside or it can hold inventory**.
- We can delete a container **if it does not hold any inventory or containers** i.e it is empty.
- We can move a container to another container **if the other container is empty, or is holding another container only (it does not hold inventory).**.
- We can move move inventory to another container **if the other container is empty, or it's holding other inventory only**.

UI:
- Allow adding containers.
- Move container from parent to another container.
- Delete a container.

- Present inventory information. 
- Move inventory from one container to another.
- Show the top level parent for the inventory. Let's say the hierarchy is: \[Warehouse_1] -> \[Rack_1] -> \[Box_1] -> (Inventory_1).  
You should show "Warehouse_1" somewhere next to the information for Inventory_1.

---

## Notes, constraints and assumptions
- You can leave aside the CRUD APIs (and thus the UI) **for inventory**. For now, after you have designed how your data looks, you can just hard-code some seed data for the inventory.

#### Priorities
**Backend > Frontend**  
We can understand if you didn't have time left for the frontend, but we definitely expect the APIs (in fact, our own functional tests depend on them!).

#### Design
- You can leave aside performance for now. The priority of your design should be: 
    1. `extensibility` (new features or changing old features is easy)
    2. `maintainability` (code is easy to read and easy to change if there are issues)
    3. `performance` (how fast it executes)
That said, you code should not be performing at 0(n<sup>2</sup>) or above. If asked to scale this, you should not have to rewrite everything.

---

## Tests
- We expect you to write tests from your side.
  - Tests for the backend that check the state of your data are strongly expected.
  - If there is no time left, _skipping unit tests **for the client** is completely fine_.  
  Nonetheless, they do give you an edge if you write them. 

**We do not expect 100% coverage. We just expect the requirements to be tested.**
You are free to choose any testing style and paradigm: BDD, TDD, unit tests, integration tests, etc.

---

# A small primer on Docker use here
If you have not worked with docker before, think of it as a way for you to run your code isolated inside a lightweight Virtual Machine (although in reality it is quite different from that). Your OS is the `host machine` here.

Docker builds `containers` from `images`, analogous to how instances are built from classes.  
Maybe a better analogy would be how you would write to a CD/DVD from an image (.iso) file. The .iso file is the image here and the CD with the data is the container.

This means each container runs like its own Linux machine, so it is easier to think of it here in this assignment as a production AWS instance.  
The container exposes ports to communicate with the outside world.   

The only tricky new concept might be `volumes`. Volumes basically say what data from the host machine (your OS) should also go into the container.  
Since the container is basically an empty linux machine that is built from scratch, it does not have anything other than what a fresh install would have, plus some additional dependencies that your selected image gives.
For example the `python:3.8.3` image is basically like installing a fresh linux install + the python 3 ecosystem installed also.
Likewise, the `postgres:12.3-alpine` image is like an empty Alpine linux install + postgres 12.

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

Some useful commands here:
- `docker-compose up tests` Runs the functional test suite.
- `docker-compose up postgres redis mongo` Spins up postgres, redis and mongo if you need them. Ports are not exposed to the host machine.

---

# Things to keep in mind.
- **You can 100% disregard the docker stuff here, and just assume your code will run in a local environment.**
    - Put your code in the respective directories.  
    If your framework does not allow you to create a new project on a non-empty directory (e.g create-react-app), create a new folder `app` inside the respective directory and use that. 
    - **Your code must pass our functional tests though**, and they expect you to expose the `backend` and `client` on the ports defined in the top level `.env` file.  

- If for whatever reasons you absolutely cannot use these ports, feel free to change them on our `.env` file at the top level.  
Docker and our tests pick up from there.

- Please don't add files you would not want to bundle with the assignment.  
We have added `.gitignore` files in both the `backend` and `client` directories but you should add to them if required.

- You can use any admin panel such as https://marmelab.com/react-admin/ or roll your own. All we expect is a basic UI to hit the APIs and present the information.
