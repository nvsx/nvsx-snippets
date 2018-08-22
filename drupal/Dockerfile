FROM php:7.2.8-fpm-alpine AS thunder-builder

# ALPINE:
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&& apk update --update-cache \
    && apk add \
			bash \
			curl \
			wget \
			vim \
			git \
			zip \
			ca-certificates \
			shadow \
        	nginx \
    		nodejs-current-npm \
			nodejs-current-dev \
        	php7-gd \
			freetype-dev \
			libpng-dev \
			libjpeg-turbo-dev \
			libmcrypt-dev \
			freetype \
			libpng \
			libjpeg-turbo \
			libmcrypt

# NGINX:
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/fastcgi.conf /etc/nginx/fastcgi.conf
RUN mkdir /nginx
RUN mkdir /nginx/body
RUN mkdir /nginx/fastcgi_temp
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# PHP:
RUN docker-php-ext-install opcache 
RUN docker-php-ext-install gd
COPY php/php-fpm.conf /usr/local/etc/php/conf.d/php-fpm.conf
### COPY php/php-extensions.ini /usr/local/etc/php/conf.d/php-extensions.ini
COPY php/docker-php-ext-sodium.ini /usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

# COMPOSER:
WORKDIR /bin
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN mv composer.phar composer
RUN chmod +x composer

# USER
RUN groupadd -r drupal && useradd --no-log-init -r -g drupal drupal
RUN mkdir -p /home/drupal
RUN chown drupal:drupal /home/drupal
RUN chown drupal:drupal /var

# THUNDER:
# WORKDIR /var/drupal
# RUN COMPOSER_MEMORY_LIMIT=-1 /bin/composer create-project burdamagazinorg/thunder-project thunder
# RUN mkdir -p /var/drupal/thunder/docroot/config/sync

# HTDOCS TEST FILES:
# RUN mkdir -p /var/drupal/thunder/docroot
# COPY nginx/mytest.html /var/drupal/thunder/docroot/mytest.html
# COPY nginx/myinfo.php /var/drupal/thunder/docroot/myinfo.php

# DOCKER:
# CMD ["php-fpm"]
# CMD ["nginx"]
# CMD ["nginx", "-g", "daemon off;"]
# CMD ["/usr/bin/supervisord"]
# akp add supervisor
EXPOSE 80

# RUNNER: 
COPY docker/wrapper-script.sh /wrapper-script.sh
CMD ["/wrapper-script.sh"]

# ------------------------------------------------------------
# TEST:
# docker build -t drupal-test .
# docker  run -it --rm --name drupal-test -p 8888:80 -v $(pwd)/var-drupal:/var/drupal drupal-test
# docker exec -it drupal-test sh
# ------------------------------------------------------------
# eof

