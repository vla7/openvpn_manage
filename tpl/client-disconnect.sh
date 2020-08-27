#!/bin/bash
#printenv > /etc/openvpn/disconnect.txt

iptables-save | grep "POSTROUTING -s $ifconfig_pool_remote_ip/32" | while read l; do `echo $l | sed 's#^-A #/usr/sbin/iptables -t nat -D #g'`; done
