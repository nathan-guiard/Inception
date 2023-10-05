#!/bin/bash

if [ -f /var/www/wordpress/wp-config.php ]
then
	echo wp-config.php already exists
else
	echo -n "wp config create:"
	cd /var/www/wordpress
	sleep 5
	#
	# wp-config.php
	# 
	wp config create --allow-root --path='/var/www/wordpress' --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost=mariadb && echo "wp config create ok"
	#
	# installation 
	#
	wp core install --allow-root --path='/var/www/wordpress' --url=nguiard.42.fr --title=nguiard --admin_user=${WP_SUDO_USER} --admin_password=${WP_SUDO_PASS} --admin_email=${WP_SUDO_EMAIL} && echo "core install ok"
	#
	# create normal user
	#
	wp user create --allow-root --path='/var/www/wordpress' ${WP_NORMAL_USER} ${WP_NORMAL_EMAIL} --role=author --user_pass=${WP_NORMAL_PASS}
fi

exec php-fpm7.3 -F
