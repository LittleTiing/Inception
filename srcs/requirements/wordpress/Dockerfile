FROM	alpine:3.15

RUN     apk update && apk upgrade && \
        apk add php7 \
            php7-fpm \
            php7-json \
            php7-zlib \
            php7-xml \
            php7-pdo \
            php7-phar \
            php7-iconv \
            php7-openssl \
            php7-pdo_mysql \
            php7-mysqli \
            php7-mysqlnd \
            php7-gd \
            php7-mcrypt \
            php7-curl \
            php7-opcache \
            php7-ctype \
            php7-intl \
            php7-bcmath \
            php7-dom \
            php7-xmlreader \
            curl \
            mariadb-client

# Download wp-cli
RUN     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp

COPY	conf/www.conf /etc/php7/php-fpm.d/www.conf

COPY    ./tools/run.sh /tmp/run.sh

EXPOSE  9000

CMD	["sh", "/tmp/run.sh"]
