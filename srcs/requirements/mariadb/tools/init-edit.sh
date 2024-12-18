#!/bin/bash

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    mysqld_safe --skip-networking &
    # MariaDB'nin hazır olmasını bekle
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASS}';"
    mysql -uroot -p"${DB_ROOTPASS}" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -uroot -p"${DB_ROOTPASS}" -e "CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_USERPASS}';"
    mysql -uroot -p"${DB_ROOTPASS}" -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USERNAME}'@'%';"
    mysql -uroot -p"${DB_ROOTPASS}" -e "FLUSH PRIVILEGES;"

    mysqladmin -uroot -p"${DB_ROOTPASS}" shutdown
fi
exec mysqld