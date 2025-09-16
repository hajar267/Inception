setup:
	@mkdir -p /home/hfiqar/data/mariadb
	@mkdir -p /home/hfiqar/data/wordpress

COMPOSE_FILE = srcs/docker-compose.yml

all : setup build up

build :
	docker compose -f $(COMPOSE_FILE) build

up :
	docker compose -f $(COMPOSE_FILE) up -d

down :
	docker compose -f $(COMPOSE_FILE) down

clean :
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	docker system prune -f

fclean : clean
	docker image prune -a -f
	docker volume prune -f

re : clean all
