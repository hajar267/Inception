COMPOSE_FILE = srcs/docker-compose.yml

all : build up

build :
	docker-compose -f $(COMPOSE_FILE) build --no-cache

up :
	docker-compose -f $(COMPOSE_FILE) up -d

down :
	docker-compose -f $(COMPOSE_FILE) down

clean :
	docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans
	docker system prune -f

fclean : clean
	docker image prune -a -f
	docker volume prune -f

re : clean all