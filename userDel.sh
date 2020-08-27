#!/bin/bash
if [ -z $1 ]; then
	echo "Using: $0 username"
	exit 1
fi

cd /etc/openvpn/easy-rsa/
./easyrsa revoke $1
./easyrsa gen-crl
/usr/bin/systemctl reload openvpn@server
