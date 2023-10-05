#!/bin/bash

echo -e "\033[1;33m------------\033[0m"

service mysql start

if [ -d /var/lib/mysql/${SQL_DATABASE} ]
then
	echo "--- database existing ---"
else
	echo "CREATING DATABASE"
	mysql_secure_installation >/dev/null << EOF && echo -e "mysql_secure_instalation [\033[32mOK\033[0m]"
${SQL_ROOT_PASSWORD}
y
${SQL_ROOT_PASSWORD}
${SQL_ROOT_PASSWORD}
y
n
y
y
EOF
	echo avant mysql
	mariadb << EOF && echo -e "mariadb queries [\033[32mOK\033[0m]" || echo -e "\033[1;31mMariaDB queries not OK\033[0m"
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO ${SQL_USER}@'%' IDENTIFIED BY '${SQL_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
fi

echo -n "mysqladmin: "
mysqladmin -uroot -p$SQL_ROOT_PASSWORD shutdown && echo -e "shutdown [\033[32mOK\033[0m]"

exec mysqld_safe
