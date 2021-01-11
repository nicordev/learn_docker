DOCKER_COMPOSE = docker-compose

DEFAULT: help

help:
	@echo -e '\e[1mStart using a specific docker-compose.yml file:\e[0m\nmake start args="-f docker-compose-1.yml"'

start:
	$(DOCKER_COMPOSE) $(args) up --detach --remove-orphans --force-recreate

stop:
	$(DOCKER_COMPOSE) down --remove-orphans

browse:
	firefox 127.0.0.1:8003

.PHONY: start stop browse
