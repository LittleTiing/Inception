YML=./srcs/docker-compose.yml

all: up

up:
	@mkdir -p /home/ypan/data/db/
	@mkdir -p /home/ypan/data/html/
	@docker-compose -f $(YML) up -d --build

run:
	@mkdir -p /home/ypan/data/db/
	@mkdir -p /home/ypan/data/html/
	@docker-compose -f $(YML) up -d

stop:
	@docker-compose -f $(YML) stop

down:
	@docker-compose -f $(YML) down

clean: down
	@docker rmi -f nginx:ypan mariadb:ypan wordpress:ypan

fclean: clean
	@docker volume rm -f srcs_db srcs_html

re: fclean all

cleandata:
	@sudo rm -rf /home/ypan/data/db/
	@sudo rm -rf /home/ypan/data/html/

.PHONY: all up run stop down re clean fclean cleandata
