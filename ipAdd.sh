#!/bin/bash
file=ip.list

. functions.sh

if [ ! -f "$file" ]; then
	error "IP list file not found"
	exit 1
fi

IFACE=`ifconfig -s | awk '{print $1}' | egrep -v '^(Iface|lo|tun)' | grep -v ':'`

NUM=`grep iface /etc/network/interfaces | awk '{print $2}' | grep $IFACE | awk -F: '{print $2}' | grep -v '^$' | sort -rn | head -1`
if [ -z $NUM ]; then
	NUM=0;
else
	NUM=$(expr $NUM + 1)
fi

cat $file | while read IP; do
log "Adding IP '$IP'..."
if ! echo $IP | grep -qP '^\d+(\.\d+){3}$'; then
	error "IP '$IP' not looks like valid IPv4 address"
	continue
fi

if grep -qP "address $IP$" /etc/network/interfaces; then
	error "IP '$IP' already present in config"
else
	tpl=`cat /root/vpn/tpl/interface.tpl`
	tpl=`echo "$tpl" | sed "s#{IFACE}#$IFACE#g"`
	tpl=`echo "$tpl" | sed "s#{NUM}#$NUM#g"`
	tpl=`echo "$tpl" | sed "s#{IP}#$IP#g"`

	echo "$tpl" >> /etc/network/interfaces
	echo >> /etc/network/interfaces	


	if ifconfig | grep -qP "inet\s$IP\s"; then
		error "IP '$IP' already is already UP"
	else
		ifup $IFACE:$NUM
		[ $? -ne 0 ] && error "while ifup $IFACE:$NUM"
	fi
	NUM=$(expr $NUM + 1)
fi
echo 
done
