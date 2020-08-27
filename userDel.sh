#!/bin/bash
if [ -z $1 ]; then
	echo "Using: $0 username"
	exit 1
fi

. functions.sh

log "Removing user $1"

if [ ! -f "/etc/openvpn/easy-rsa/pki/issued/${1}.crt" ]; then
        error "Not found certificate for user '$1'"
        exit 1
fi

cd /etc/openvpn/easy-rsa/
./easyrsa revoke $1
./easyrsa gen-crl
/usr/bin/systemctl reload openvpn@server

echo
log "User $1 was removed"
log ""
