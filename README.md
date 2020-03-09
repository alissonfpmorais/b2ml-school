# B2ml
Example project to manage a working school.


### Technologies
The project was completely build using Phoenix Framework (built on top of Elixir language). You can get more information about those technologies at:
  * https://www.phoenixframework.org/
  * https://elixir-lang.org/


### Features
Some features implemented in this project:
  * SQL Database (PostgreSQL)
  * MVC architecture model
  * CRUD of resources (Teacher, Class, Student)
  * Unit test (models and controllers)
  * Frontend with Webpack build and internationalization


### Execute
First, `Docker` and `Docker Compose` are required to run this project, so you need to have both installed in your machine.

If you don't know how to install, here are some useful links:
  * https://docs.docker.com/install/
  * https://docs.docker.com/compose/install/

To run the project is simple, just run the commands below:
```shell
git clone https://github.com/alissonfpmorais/b2ml-school.git
cd b2ml-school
docker-compose up -d
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


### Tests
To run the tests, first you need to run the project (make sure by navigating to http://localhost:4000).

After that, just run the command bellow:
```shell
docker exec -it b2ml_app_1 bash -c "mix test"
```


### Notes
If you encounter any PORT issues when running the project, thats because it uses port 4000 for the frontend and 5432 for the database.