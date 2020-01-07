# My first docker project

A simple php application to test docker using [the php:7.4-apache image from Docker hub](https://hub.docker.com/_/php).

## Installation

1. Run `docker build . -t first_docker_project` to build the image.
2. Run `docker run -p 8000:80 first_docker_project` to create and start a container from the image.

## Usage

* To reach the application:
    * Go to [http://127.0.0.1:8000/public/index.php](http://127.0.0.1:8000/public/index.php) from a browser.
* To stop and delete the container:
    1. Run `docker ps` and copy the container id.
    2. Run `docker stop pasteContainerIdHere` to stop the container.
    3. Run `docker container rm pasteContainerIdHere` to delete the container.
