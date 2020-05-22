# Container system

Please read these instructions below thoroughly.  
They explain the problem, it's functional requirements, and notes/constraints to keep in mind while designing the system.

Please explain your design choices in the given `design-choices.md` document.

**You can 100% ignore the docker stuff here, and just run your code in your local environment. This is just to help you isolate your project's dependencies and environment.**  
If you are unfamiliar with docker, see the file `docker-basics.md`. The docker commands relevant to this assignment are in `docker-commands.md`.  
It gives a basic idea of docker, how we structured the folders in this assignment and a few commands, should you use docker. 

More details in "Things to keep in mind" section below. Please go through it to help us evaluate your code faster. :)   

---

## Problem
You would have seen containers in warehouses.  
You can put items inside a container, and that container can itself be put inside another container and so on.

Let's build one of those. :)

### Entities and definitions
To understand the entities better, let's assume a simple warehouse for clothes. There are two broad types of clothes (amongst others),  
jeans and shirt.

**Container**
Think of two squares, one inside the other. That's basically it. The outer square is a container than can hold another container (the inner square).
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

**Inventory**
For now, we can go with a very simple definition of inventory. It as an object in your data store that has:
  - a way to identify what kind of item it is a part of.  
  Here "jeans" and "shirt" are two different kinds of things
  - Some way to identify characteristics unique to all items of a particular kind.  
  You might have different materials for jeans. Or you might have different styles and colours for shirts.
  
  - a way to say how this item is **linked to a `container`.**
  - a way to say how many copies of the same inventory exist i.e the factory would have created a bunch of these and shipped them together to your warehouse. 

### Requirements:
##### Backend
- We should be able to add new "containers".  
- Containers can hold other containers.
- If a container can hold other containers, it should not be able to hold inventory i.e. **at any given moment, a container can either hold other containers inside or it can hold inventory**.
- We can delete a container **if it does not hold any inventory or containers** i.e it is empty.
- We can move a container to another container **if the other container is empty, or is holding another container only (it does not hold inventory).**.
- We can move move inventory to another container **if the other container is empty, or it's holding other inventory only**.

##### UI
- Allow adding a new container.
- Move container from parent to another container.
- Delete a container.
- Show inventory information: **only the label and the container it is under**.
- Move inventory from one container to another.
- Show the top level parent for the inventory. Let's say the hierarchy is: \[Warehouse_1] -> \[Rack_1] -> \[Box_1] -> (Inventory_1).  
You should show "Warehouse_1" somewhere next to the information for Inventory_1.

---

## Notes, constraints and assumptions
- You can leave aside the CRUD APIs (and thus the UI) **for inventory**. For now, after you have designed how your data looks, you can just hard-code some seed data for the inventory.

#### Priorities
**Backend > Frontend**  
We can understand if you didn't have time left for the frontend, but we definitely expect the APIs to be complete.

#### Design
- You can leave aside performance for now. The priority of your design should be: 
    1. `extensibility` (new features or changing old features is easy)
    2. `maintainability` (code is easy to read and easy to change if there are issues)
    3. `performance` (how fast it executes)
That said, you code should not be performing at 0(n^2) or above. If asked to scale this, you should not have to rewrite everything.

---

## Tests
- We expect you to write tests from your side.
  - Tests for the backend that check the state of your data are strongly expected.
  - If there is no time left, _skipping unit tests **for the client** is completely fine_.  
  Nonetheless, they do give you an edge if you write them. 

**We do not expect 100% coverage. We just expect the requirements to be tested.**
You are free to choose any testing style and paradigm: BDD, TDD, unit tests, integration tests, etc.

---

# Things to keep in mind.
- **You can 100% disregard the docker stuff here, and just assume your code will run in a local environment.**
    - Put your code in the respective directories.  
    If your framework does not allow you to create a new project on a non-empty directory (e.g create-react-app), create a new folder `app` inside the respective directory and use that. 

- If for whatever reasons you absolutely cannot use these ports, feel free to change them on our `.env` file at the top level.  
Docker picks up from there.

- Please don't add files you would not want to bundle with the assignment.  
We have added `.gitignore` files in both the `backend` and `client` directories but you should add to them if required.

- You can use any admin panel such as https://marmelab.com/react-admin/ or roll your own. All we expect is a basic UI to hit the APIs and present the information.
