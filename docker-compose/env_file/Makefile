APP_CONTAINER_NAME = fruit_list_app_php_1
APP_CONTAINER_IP = $(shell docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${APP_CONTAINER_NAME})

start:
	docker-compose up --remove-orphans

start-detach:
	docker-compose up --remove-orphans --detach

stop:
	docker-compose down

get-app-container-ip:
	@echo ${APP_CONTAINER_IP}

browse:
	@echo http://${APP_CONTAINER_IP}

bash:
	docker-compose exec php bash