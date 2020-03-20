FROM php:7.3-apache

LABEL Organization="docimg" Author="hdxw <909712710@qq.com>"

LABEL maintainer="909712710@qq.com"

COPY _files /tmp/
COPY src /var/www/html

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-client \
    # mysql ext
    && docker-php-source extract \
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-source delete \
    # init mysql
    && mysql_install_db --user=mysql --datadir=/var/lib/mysql \
    && sh -c 'mysqld_safe &' \
    && sleep 5s \
    && mysqladmin -uroot password 'root' \
    # configure file
    && mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && chmod +x /usr/local/bin/docker-php-entrypoint \
    && chown -R www-data:www-data /var/www/html \    
    && mv /tmp/docker-php-ext-mysqli.ini /usr/local/etc/php/conf.d \
    && mv /tmp/docker-php-ext-pdo_mysql.ini /usr/local/etc/php/conf.d \
    && echo 'ServerName 0.0.0.0:80' >> /etc/apache2/apache2.conf \
    # clear
    && rm -rf /tmp/*

WORKDIR /var/www/html

EXPOSE 80

CMD ["/bin/bash", "-c", "docker-php-entrypoint"]