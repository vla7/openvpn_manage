#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install openvpn -y

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

/usr/sbin/sysctl -p

cp -r /usr/share/easy-rsa /etc/openvpn/
cp /root/vpn/tpl/vars.tpl /etc/openvpn/easy-rsa/vars

cd /etc/openvpn/easy-rsa
./easyrsa init-pki
./easyrsa build-ca nopass

./easyrsa gen-req server nopass
./easyrsa sign-req server server
./easyrsa gen-dh
./easyrsa gen-crl

cp pki/ca.crt /etc/openvpn/server/
cp pki/dh.pem /etc/openvpn/server/
cp pki/private/server.key /etc/openvpn/server/
cp pki/issued/server.crt /etc/openvpn/server/

cp /root/vpn/tpl/server.conf.tpl /etc/openvpn/server.conf 
cp /root/vpn/tpl/client-connect.sh /etc/openvpn/client-connect.sh
cp /root/vpn/tpl/client-disconnect.sh /etc/openvpn/client-disconnect.sh

chmod +x /etc/openvpn/client-connect.sh
chmod +x /etc/openvpn/client-disconnect.sh

/usr/bin/systemctl start openvpn@server

