#!/bin/bash

sudo yum install -y httpd 
sudo yum install wget -y 
sudo yum install unzip -y

sudo systemctl enable --now httpd
sudo rm -rf /etc/named.conf
sudo cp /tmp/named.conf /etc/named.conf
sudo chown root:root /etc/named.conf
sudo chmod 644 /etc/named.conf
sudo yum install bind -y
sudo cp -p /tmp/vaibhav_dns /var/named/vaibhav_dns
public_ip=$(curl -s https://ipinfo.io/ip)
sudo sed -i "s/ns_ip/$public_ip/g" /var/named/vaibhav_dns
sudo mkdir /tmp/zip
sudo wget -P /tmp/zip/ https://www.free-css.com/assets/files/free-css-templates/download/page296/listrace.zip
cd /tmp/zip/
sudo unzip *.zip
sudo rm -rf *.zip
sudo mv * html
sudo rm -rf /var/www/html 
sudo mv * /var/www/html
sudo systemctl start named
sudo systemctl restart httpd