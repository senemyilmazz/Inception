FROM debian:buster

EXPOSE 443

RUN apt update && apt upgrade -y
RUN apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/html
RUN openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=TR/L=ISTANBUL/O=42Istanbul/OU=SARIYER/CN=senyilma.42.fr/UID=senyilma"


COPY conf/default /etc/nginx/sites-available/

CMD ["nginx", "-g", "daemon off;"]
