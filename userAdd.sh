#!/bin/bash
if [ -z $1 ]; then
	echo "Using: $0 username"
	exit 1
fi

cd /etc/openvpn/easy-rsa/
./easyrsa gen-req $1 nopass
./easyrsa sign-req client $1

mkdir -p /root/vpn/users/$1

cp /root/vpn/tpl/client.ovpn.tpl /root/vpn/users/$1/$1.ovpn
cp /etc/openvpn/easy-rsa/pki/ca.crt /root/vpn/users/$1/
cp /etc/openvpn/easy-rsa/pki/issued/$1.crt  /root/vpn/users/$1/
cp /etc/openvpn/easy-rsa/pki/private/$1.key /root/vpn/users/$1/
