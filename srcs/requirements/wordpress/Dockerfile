FROM debian:buster

RUN apt update && apt upgrade -y
RUN apt install -y wget curl php php-cgi php-mysql php-fpm \
     php-pdo php-gd php-cli php-mbstring \
     && rm -rf /var/lib/apt/lists/*

RUN  mkdir -p /run/php /var/www/ /var/www/html/

RUN  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
     && chmod +x wp-cli.phar \
     && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

COPY ./tools/create-wp.sh /usr/local/bin/

RUN  chmod +x /usr/local/bin/create-wp.sh

ENTRYPOINT ["/usr/local/bin/create-wp.sh"]
WORKDIR   /var/www/html/
EXPOSE    9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]