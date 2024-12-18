#!/bin/sh

if [ ! -f ./wp-config.php ]; then
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz  wordpress

	cd /var/www/html

    wp cli update
    wp config create --dbname="${DB_NAME}" --dbuser="${DB_USERNAME}" --dbpass="${DB_USERPASS}" --dbhost="${DB_HOST}" --force --allow-root
    wp core install --allow-root --url="${DOMAIN}" --title="${WP_TITLE}" --admin_user="${WP_ADMINNAME}" --admin_password="${WP_ADMINPASS}" --admin_email="${WP_ADMINMAIL}"
    wp user create --allow-root "${WP_USERNAME}" "${WP_USERMAIL}" --role="${WP_USERROLE}" --user_pass="${WP_USERPASS}"
fi

wp plugin update --all --allow-root

exec "$@"

