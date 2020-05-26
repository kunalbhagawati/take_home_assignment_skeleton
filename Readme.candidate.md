A simple test harness for take home assignments.

Please go through `problem.md` to understand the problem.

Please explain your design choices in the given `design-choices.md` document.

**You can 100% ignore the docker stuff here, and just run your code in your local environment. This is just to help you isolate your project's dependencies and environment.**  
If you are unfamiliar with docker, see the file `docker-basics.md`. The docker commands relevant to this assignment are in `docker-commands.md`.  
It gives a basic idea of docker, how the folders in this assignment are structured and a few commands, should you use docker. 

# Things to keep in mind.
- Put your code in the respective directories.  
If your framework does not allow you to create a new project on a non-empty directory (e.g create-react-app), create a new folder `app` inside the respective directory and use that. 

- If for whatever reasons you absolutely cannot use these ports, feel free to change them on our `.env` file at the top level.  
Docker picks up from there.

- Please don't add files you would not want to bundle with the assignment.  
We have added `.gitignore` files in both the `backend` and `client` directories but you should add to them if required.

- You can use any admin panel such as https://marmelab.com/react-admin/ or roll your own. All we expect is a basic UI to hit the APIs and present the information.
