#!/bin/bash
if [ -z $1 ]; then
	echo "Using: $0 username"
	exit 1
fi

. functions.sh

log "Creating user $1"

if [ -f "/etc/openvpn/easy-rsa/pki/issued/${1}.crt" ]; then
	error "User with name '$1' already exist"
	exit 1
fi
if [ -d "/root/vpn/users/${1}" ]; then
	error "User directory /root/vpn/users/${1} already exist"
	exit 1
fi

#issue random ip
IP=`ifconfig | grep inet | awk '{print $2}' | grep -oP '\d+(\.\d+){3}' | grep -v '127.0.0.1' | shuf -n 1`

cd /etc/openvpn/easy-rsa/
export EASYRSA_REQ_CN=$1
./easyrsa gen-req $1 nopass
./easyrsa sign-req client $1

mkdir -p /root/vpn/users/$1

cp /root/vpn/tpl/client.ovpn.tpl /root/vpn/users/$1/$1.ovpn
sed -i "s#{IP}#$IP#g" /root/vpn/users/$1/$1.ovpn
sed -i "s#{CLIENT}#$1#g" /root/vpn/users/$1/$1.ovpn
cp /etc/openvpn/easy-rsa/pki/ca.crt /root/vpn/users/$1/
cp /etc/openvpn/easy-rsa/pki/issued/$1.crt  /root/vpn/users/$1/
cp /etc/openvpn/easy-rsa/pki/private/$1.key /root/vpn/users/$1/

log "User $1 created. User config and certs stored to /root/vpn/users/$1"
