#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    deploy.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wbertoni <wbertoni@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/09 17:09:39 by wbertoni          #+#    #+#              #
#    Updated: 2020/04/19 18:09:06 by wbertoni         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Update & Upgrade APT-GET
apt-get update \
&& apt-get upgrade

# NGINX MARIADB PHP OPENSSL install
apt-get install nginx -y \
&& apt-get install mariadb-server -y \
&& apt-get install php7.3 php7.3-fpm php7.3-mysql php7.3-mbstring php7.3-zip \
php7.3-gd -y \
&& apt-get install openssl

# NGINX
mkdir /var/www/localhost
mv nginx.conf /etc/nginx/sites-available/default

# PHPMYADMIN INSTALL
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages /var/www/localhost/phpmyadmin
mv ./config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
rm -rf phpMyAdmin-5.0.2-all-languages.tar.gz

# PHPMYADMIN SUPERUSER
service mysql start
echo "CREATE USER 'wbertoni'@'localhost' IDENTIFIED BY '1234';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'wbertoni'@'localhost' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# WORDPRESS DATABASE AND USER
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '1234';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# WORDPRESS INSTALL
tar -xf wordpress-5.4.tar.gz
mv wordpress /var/www/localhost/wordpress
mv wp-config.php /var/www/localhost/wordpress
rm -rf wordpress-5.4.tar.gz

# SSL CONFIG
openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=localhost/OU=Development/CN=localhost/emailAddress=wbertoni@student.42sp.org" \
    -keyout localhost.dev.key \
    -out localhost.dev.crt  2>> /dev/null
mv localhost.dev.crt /etc/ssl/certs/
mv localhost.dev.key /etc/ssl/private/
chmod 600 /etc/ssl/certs/localhost.dev.crt /etc/ssl/private/localhost.dev.key

# Development
apt-get install vim -y

# CLEAN CACHE
apt-get clean -y
apt-get autoclean -y

# DELETE SRCS FILES
rm -f deploy.sh
