FROM debian:buster

RUN apt update -y 2> /dev/null
RUN apt upgrade -y 2> /dev/null

RUN apt-get install mariadb-server -y
 
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tool/script.sh /root/script.sh

ENTRYPOINT [ "bash", "/root/script.sh" ]

CMD [ "mysqld_safe" ]
