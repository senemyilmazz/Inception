#DC := docker-compose -f srcs/docker-compose.yml
#DB_PATH = /home/senyilma/data
#
#all: remove_old_container remove_old_volume set_path
#	@mkdir -p $(DB_PATH)
#	@mkdir -p $(DB_PATH)/wordpress
#	@mkdir -p $(DB_PATH)/mariadb
#	@$(DC) up -d --build
#
#remove_old_container:
#	@docker ps -a -q --filter volume=srcs_mariadb_data | xargs -I {} docker stop {} || true
#	@docker ps -a -q --filter volume=srcs_mariadb_data | xargs -I {} docker rm {} || true
#
#remove_old_volume:
#	@docker volume rm srcs_mariadb_data || true
#
#down:
#	@$(DC) down
#
#clean: down
#	@docker volume rm $(shell docker volume ls -q) || true
#	@docker network prune --force || true
#
#fclean: clean
#	@sudo rm -rf $(DB_PATH)
#	
#set_path:
#	@sed -i '/^DB_PATH=/c\DB_PATH=$(DB_PATH)' ./srcs/.env
#
#re: down all
#
#.PHONY: all down re

DC := docker-compose -f srcs/docker-compose.yml
DB_PATH = /home/senyilma/data

all: prune set_path 
	@mkdir -p $(DB_PATH)
	@mkdir -p $(DB_PATH)/wordpress
	@mkdir -p $(DB_PATH)/mariadb
	@$(DC) up -d --build

prune: 
	@docker container prune --force
	@docker image prune --all --force
	@docker volume prune --force
	@docker network prune --force

set_path:
	@sed -i '/^DB_PATH=/c\DB_PATH=$(DB_PATH)' ./srcs/.env

clean: prune
	@if [ -f srcs/docker-compose.yml ] && [ "$(shell docker ps -q)" ]; then $(DC) down --volumes --rmi all --remove-orphans; else echo "No containers or docker-compose.yml found."; fi

#	@$(DC) down --volumes --rmi all --remove-orphans

fclean: clean
	@sudo rm -rf $(DB_PATH) 
	@echo "Removed $(DB_PATH)"

re: clean all

.PHONY: all prune set_path clean fclean re