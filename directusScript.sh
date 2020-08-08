#!/bin/bash
apt-get install -y apache2 mariadb-server php php-gd php-curl php-mbstring php-mysql php-mysql nano wget zip unzip compose
systemctl enable apache2
systemctl enable mariadb
systemctl start apache2
systemctl start mariadb
a2dissite 000-default.conf
cd /etc/apache2/sites-available/
wget https://github.com/MAXPOL/directus/blob/master/directus.conf
a2ensite directus.conf
cd /var/www
rm -rf *
wget https://github.com/MAXPOL/directus/blob/master/directus.zip
unzip directus.zip
a2enmod rewrite
cd directus
composer install
cd migrations\install
sed -i 's/'"'limit'"' => 255,/'"'limit'"' => 190,/g' 20180220023152_create_collections_presets_table.php
cd /
mysql_secure_installation
mysql -u root -p -e "use mysql; update user set plugin='' where user='root';"
mysql -u root -p -e "create database sdb;"
