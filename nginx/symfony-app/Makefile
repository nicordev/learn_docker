DOCKER_COMPOSE = docker-compose

DEFAULT: help

ARGS = -f docker-compose-3.yml

ifdef args
	ARGS = ${args}
endif

help:
	@echo -e '\n\e[1mStart using a specific docker-compose.yml file:\e[0m\nmake start args="-f docker-compose-1.yml"'
	@echo -e '\n\e[1mStop using a specific docker-compose.yml file:\e[0m\nmake stop args="-f docker-compose-1.yml"\n'

start:
	$(DOCKER_COMPOSE) ${ARGS} up --detach --remove-orphans --force-recreate

stop:
	$(DOCKER_COMPOSE) ${ARGS} down --remove-orphans

browse:
	firefox 127.0.0.1:8003

bash-php:
	$(DOCKER_COMPOSE) ${ARGS} exec php bash

bash-nginx:
	$(DOCKER_COMPOSE) ${ARGS} exec nginx bash

composer-install:
	$(DOCKER_COMPOSE) -f docker-compose-4.yml exec php composer install

.PHONY: start stop browse
