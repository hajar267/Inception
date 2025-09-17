
COMPOSE_FILE = srcs/docker-compose.yml

setup : 
	@mkdir -p /home/hfiqar/data/mariadb
	@mkdir -p /home/hfiqar/data/wordpress

all : setup build up

build :
	docker compose -f $(COMPOSE_FILE) build

up :
	docker compose -f $(COMPOSE_FILE) up -d --build

down :
	docker compose -f $(COMPOSE_FILE) down

clean :
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	docker system prune -f

fclean : clean
	docker image prune -a -f
	docker volume prune -f

re : clean all
