#!/bin/bash



envsubst < /var/www/initial_db_temp.sql > /var/www/initial_db.sql

mysql -u ${DB_ROOT_USER} -p${DB_ROOT_PASSWORD} < /var/www/initial_db.sql

rm -f /var/www/initial_db.sql