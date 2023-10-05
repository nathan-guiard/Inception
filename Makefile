YML_FILE = srcs/docker-compose.yml

run:
	mkdir -p /home/nguiard/data/wordpress
	mkdir -p /home/nguiard/data/mariadb
	docker-compose -f ${YML_FILE} up -d --build

stop:
	docker-compose -f ${YML_FILE} down -t 2

clean: stop
	docker system prune -af
	docker rm -f nginx mariadb wordpress

fclean: stop
	docker system prune -af
	sudo rm -rf /home/nguiard/data/wordpress/
	sudo rm -rf /home/nguiard/data/mariadb/

re: fclean run

.PHONY: run fclean stop re
