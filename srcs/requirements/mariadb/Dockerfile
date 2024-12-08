FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/www/

RUN apt-get update && apt-get install -y gettext
RUN envsubst < /var/www/initial_db_temp.sql > /var/www/initial_db.sql
CMD ["sh", "-c", "mysqld_safe --skip-networking & sleep 5 && mysql < /var/www/initial_db.sql && rm -f /var/www/initial_db.sql && mysqladmin shutdown && mysqld"]
