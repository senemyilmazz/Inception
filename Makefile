DC := docker-compose -f srcs/docker-compose.yml
DB_PATH = /home/senyilma/data

all: prune set_path 
	@mkdir -p $(DB_PATH)
	@mkdir -p $(DB_PATH)/wordpress
	@mkdir -p $(DB_PATH)/mariadb
	@$(DC) up -d 

prune: 
	@docker container prune --force
	@docker image prune --all --force
	@docker volume prune --force
	@docker network prune --force

set_path:
	@sed -i '/^DB_PATH=/c\DB_PATH=$(DB_PATH)' ./srcs/.env

clean: prune
	@if [ -f srcs/docker-compose.yml ] && [ "$(shell docker ps -q)" ]; \
	then $(DC) down --volumes --rmi all --remove-orphans; \
	else echo "No containers or docker-compose.yml found."; fi

fclean: clean
	@sudo rm -rf $(DB_PATH) 
	@echo "Removed $(DB_PATH)"

re: clean all

.PHONY: all prune set_path clean fclean re