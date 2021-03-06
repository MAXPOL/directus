#!/bin/bash
apt-get install -y apache2 mariadb-server php php-gd php-curl php-mbstring php-mysql php-xml php-pdo php-fileinfo php-mysql nano wget zip unzip composer
systemctl enable apache2
#systemctl enable mariadb #Uncomment if you want use internal database
systemctl start apache2
#systemctl start mariadb #Uncomment if you want use internal database
a2dissite 000-default.conf
cp /directus/directus.conf /etc/apache2/sites-available/
echo "Include "/etc/apache2/sites-available/directus.conf"" >> /etc/apache2/apache2.conf
a2ensite directus.conf
rm -rf /var/www/*
cp /directus/directus.zip /var/www/
cd /var/www/
unzip directus.zip
a2enmod rewrite
a2enmod ssl
cd directus
composer install
cd /var/www/directus/migrations/install
sed -i 's/'"'limit'"' => 255,/'"'limit'"' => 190,/g' 20180220023152_create_collections_presets_table.php
cd /
#mysql_secure_installation #Uncomment if you want use internal database
#mysql -u root -p -e "use mysql; update user set plugin='' where user='root';" #Uncomment if you want use internal database
#mysql -u root -p -e "create database sdb;" #Uncomment if you want use internal database
chmod -R 0777 /var/www/directus
chown -R www-data:www-data /var/www/directus
#systemctl restart mariadb #Uncomment if you want use internal database
#reboot
