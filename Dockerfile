FROM nginx:stable

RUN apt-get update \
    && apt-get install -y gnupg lsb-release ca-certificates curl apt-transport-https software-properties-common \
    && curl -sSLo /usr/share/keyrings/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y \
        php8.1-fpm \
        php8.1-mysql \
        php8.1-gd \
        php8.1-curl \
        php8.1-xml \
        php8.1-mbstring

WORKDIR /var/www/html/

COPY ./config/default.conf /etc/nginx/conf.d/default.conf
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./src/wordpress/. .

RUN chown -R www-data:www-data /var/www/html

CMD ["sh", "-c", "php-fpm8.1 & exec nginx -g 'daemon off;'"]






