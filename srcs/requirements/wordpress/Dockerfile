FROM debian:buster

RUN apt update 2> /dev/null
RUN apt upgrade -y 
# On a besoin de wget pour telecharger WP
RUN apt install wget -y 2> /dev/null

RUN apt install php7.3 php-fpm php-mysql mariadb-client -y 

RUN wget https://wordpress.org/latest.tar.gz -P /var/www
RUN cd /var/www && tar -xzf latest.tar.gz && rm latest.tar.gz

COPY conf/php.ini /etc/php/7.3/cli/php.ini
COPY tool/script.sh /root/script.sh

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php

RUN sed -i 's/listen = /listen = wordpress:9000\;/' /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT [ "bash", "/root/script.sh" ]

