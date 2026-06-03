FROM php:8.2-fpm-alpine

RUN apk add --no-cache nginx supervisor

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/supervisord.conf /etc/supervisord.conf

COPY index.html /usr/share/nginx/html/index.html
COPY style.css /usr/share/nginx/html/style.css
COPY save.php /usr/share/nginx/html/save.php
COPY results.json /usr/share/nginx/html/results.json

RUN chown -R www-data:www-data /usr/share/nginx/html \
    && mkdir -p /run/nginx

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
