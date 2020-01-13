# My first docker project

A simple php application to test docker using [the php:7.4-apache image from Docker hub](https://hub.docker.com/_/php).

## Installation

1. Run `docker build . -t first_docker_project` to build the image.
2. Run `docker run -p 8000:80 first_docker_project` to create and start a container from the image.

## Usage

* To reach the application:
    * Go to [http://127.0.0.1:8000/public](http://127.0.0.1:8000/public) from a browser.
* To stop and delete the container:
    1. Run `docker ps` and copy the container id.
    2. Run `docker stop pasteContainerIdHere` to stop the container.
    3. Run `docker container rm pasteContainerIdHere` to delete the container.

## Dockerfile explained

```
FROM php:7.4-apache

COPY . /var/www/html

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
```

* `FROM imageName:imageTag` select the base image, here `php:7.4-apache`.
* `COPY hostFolderPath containerFolderPath` copy the folder from the host computer to the container folder. Here we copy the current directory our shell is on (represented by `.`) into the `/var/www/html` folder of the container.
* `ENV ENVIRONMENT_VARIABLE_NAME=environmentVariableValue` set an environment variable in the container.
* `RUN command options parameters` run a command in the container. Here we use the `sed` command to modify the apache configuration in order to use the `/var/www/html/public` folder as the root directory of the server:
   * `sed` is a stream editor for filtering and transforming text (`man sed`).
   * `-r` to use regular expressions.
   * `-i` to edit files in place.
   * `-e` to add the script to the command.
