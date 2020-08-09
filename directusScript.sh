#!/bin/bash
apt-get install -y apache2 mariadb-server php php-gd php-curl php-mbstring php-mysql php-xml php-pdo php-fileinfo php-mysql nano wget zip unzip composer
systemctl enable apache2
systemctl enable mariadb
systemctl start apache2
systemctl start mariadb
a2dissite 000-default.conf
cp /directus/directus/directus.conf /etc/apache2/sites-available/
echo "Include "/etc/apache2/sites-available/directus.conf"" >> /etc/apache2/apache2.conf
a2ensite directus.conf
rm -rf /var/www/*
cp /directus/directus/directus.zip /var/www/
cd /var/www/
unzip directus.zip
a2enmod rewrite
cd directus
composer install
cd /var/www/directus/migrations/install
sed -i 's/'"'limit'"' => 255,/'"'limit'"' => 190,/g' 20180220023152_create_collections_presets_table.php
cd /
mysql_secure_installation
mysql -u root -p -e "use mysql; update user set plugin='' where user='root';"
mysql -u root -p -e "create database sdb;"
chmod -R 0777 /var/www/directus
chown -R www-data:www-data /var/www/directus
systemctl restart mariadb
reboot
