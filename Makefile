name		=	inception

DOCKER_FILE	=	./srcs/docker-compose.yml
ENV_FILE	=	./srcs/.env

COMMAND		=	@docker-compose -f ${DOCKER_FILE} --env-file ${ENV_FILE}

all: up

build: mkdir
	@printf "===== BUILD ${name} =====\n"
	${COMMAND} up -d --build

up: mkdir
	@printf "===== UP ${name} =====\n"
	${COMMAND} up -d

down:
	@printf "===== DOWN ${name} =====\n"
	${COMMAND} down

re: down fclean up
	@printf "===== RE ${name} =====\n"

clean: down
	@printf "===== CLEAN ${name} =====\n"
	@if [ $(docker ps -qa | wc -l > 0) ]; then\
		docker stop $$(docker ps -qa);\
	fi
	@docker system prune --all --force --volumes
	@sudo rm -rf /home/pyago-ra/data/wordpress/*
	@sudo rm -rf /home/pyago-ra/data/mariadb/*

fclean: clean
	@printf "===== FCLEAN ${name} =====\n"
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf /home/pyago-ra/data

mkdir:
	@printf "===== MKDIR ${name} =====\n"
	@if [ ! -d "/home/pyago-ra" ]; then \
			mkdir /home/pyago-ra; \
	fi
	@if [ ! -d "/home/pyago-ra/data" ]; then \
			mkdir /home/pyago-ra/data; \
	fi
	@if [ ! -d "/home/pyago-ra/data/mariadb" ]; then \
			mkdir /home/pyago-ra/data/mariadb; \
	fi
	@if [ ! -d "/home/pyago-ra/data/wordpress" ]; then \
			mkdir /home/pyago-ra/data/wordpress; \
	fi

.PHONY	: all build down re clean fclean mkdir
