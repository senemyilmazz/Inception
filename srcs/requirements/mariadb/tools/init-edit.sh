#!/bin/bash

# MariaDB'yi güvenli bir şekilde başlat
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    mysqld_safe --skip-networking &
    sleep 5  # MariaDB'nin başlatılmasını bekle

    # Root kullanıcısını güncelle
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASS}';"
    mysql -uroot -p"${DB_ROOTPASS}" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -uroot -p"${DB_ROOTPASS}" -e "CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_USERPASS}';"
    mysql -uroot -p"${DB_ROOTPASS}" -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USERNAME}'@'%';"
    mysql -uroot -p"${DB_ROOTPASS}" -e "FLUSH PRIVILEGES;"

    # MariaDB'yi düzgün bir şekilde kapat
    mysqladmin -uroot -p"${DB_ROOTPASS}" shutdown
fi
exec mysqld