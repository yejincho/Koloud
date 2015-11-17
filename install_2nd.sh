#!/bin/sh

# To install UBUNTU OS automatically

sudo cp preseed.cfg /var/lib/libvirt/images/preseed.cfg

# To install CentOS automatically

sudo cp centospreseed.cfg /var/lib/libvirt/images/centospreseed.cfg

# To install shell script module

sudo cp -r netsh /
chmod 777 /netsh
chmod 777 /netsh/*

# install haproxy 1.5 ver

sudo add-apt-repository -y ppa:vbernat/haproxy-1.5
sudo apt-get update
sudo apt-get install -y haproxy
sudo cp haproxy.cfg /etc/haproxy/haproxy.cfg

# Server Install : Apache2 for Net2FTP ( Not install vsftpd and Net2ftp yet )
# port change 80 -> 81

sudo apt-get install -y --force-yes apache2
sudo apt-get install -y --force-yes php5 php5-common
sudo apt-get install -y --force-yes libapache2-mod-php5
sudo cp ports.conf /etc/apache2/ports.conf
sudo cp default /etc/apache2/sites-available/default
sudo /etc/init.d/apache2 restart


# vsftpd install

sudo apt-get install -y --force-yes vsftpd
sudo cp vsftpd.conf /etc/vsftpd.conf

# Net2FTP install
sudo tar -xvf ftp.tar
sudo rm -r /var/www
sudo cp -r ftp /var/www
sudo chmod 777 /var/www/
sudo chmod 777 /var/www/temp
sudo service vsftpd restart

sudo sleep 3
# To find CPU Utilization 

apt-get install -y --force-yes sysstat

# SSH install
sudo apt-get install -y --force-yes openssh-server
sudo /etc/init.d/ssh restart

sudo sleep 3
# Gateone install
sudo apt-get install -y --force-yes python-imaging
sudo sleep 3
sudo apt-get install -y --force-yes dtach
sudo sleep 3
sudo apt-get install -y --force-yes python-pip debhelper python-support
sudo sleep 3
sudo dpkg -i gateone/*.deb
sudo cp server.conf /opt/gateone/server.conf
sudo mkdir /opt/gateone/logs

# Server Install : Tomcat7 for Dash Board ( Include deploy dashboard war file yet)
sudo sleep 3
sudo apt-get install -y --force-yes tomcat7 tomcat7-docs tomcat7-admin tomcat7-examples
sudo cp koloud.war /var/lib/tomcat7/webapps/koloud.war
sudo cp hostserver.xml /etc/tomcat7/server.xml
sudo mv /var/lib/tomcat7/webapps/ROOT /var/lib/tomcat7/webapps/ROOT_ORGIN
sudo tar -xvf xml.tar
sudo cp -r xml /
sudo chmod 777 /xml
sudo chmod 777 /xml/*
sudo echo -e "tomcat\ntomcat\n" | sudo passwd tomcat7
sed -r -i 's/privilege specification/privilege specification\ntomcat7\tALL=(ALL:ALL) ALL/' /etc/sudoers
sudo usermod -aG sudo tomcat7
sudo /etc/init.d/tomcat7 restart

# restart HAProxy

sudo /etc/init.d/haproxy restart 

# To minimize the terminal Window
# sudo apt-get install -y --force-yes xdotool


# start Gateone Daemon 

sudo service gateone start
sudo sleep 6

# Network Interface XML File

sudo cp -r netsh /netsh
sudo chmod 777 /netsh

# munin monitoring app

sudo apt-get install -y --force-yes munin munin-node
sudo tar -xvf munin.tar
sudo rm -rf /etc/munin
sudo cp -af munin /etc/munin
sudo chmod 777 /etc/munin
sudo /etc/init.d/munin-node restart
sudo /etc/init.d/apache2 restart
sudo sleep 6
sudo /etc/init.d/munin-node stop
sudo sleep 3
sudo /etc/init.d/munin-node start
sudo /etc/init.d/apache2 restart

# popup! 

sudo firefox localhost:81 localhost:8080 localhost:82 

# Execute Gateone Daemon and Minimize the Terminal Window
# sudo xdotool windowminimize $(xdotool getactivewindow)

