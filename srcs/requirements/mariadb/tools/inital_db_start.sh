#!/bin/bash

envsubst < /var/www/initial_db_temp.sql > /var/www/initial_db.sql

mysql -u root -proot12345 < /var/www/initial_db.sql

rm -f /var/www/initial_db.sql