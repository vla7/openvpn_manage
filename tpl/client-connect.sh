#!/bin/bash
input_ip=`grep "Peer Connection Initiated with \[AF_INET\]$trusted_ip" /var/log/openvpn.log | tail -1 | awk -F'via' '{print $2}' | grep -Eo "([0-9]{1,3}[\.]){3}[0-9]{1,3}"`
/usr/sbin/iptables -t nat -A POSTROUTING -s $ifconfig_pool_remote_ip -j SNAT --to $input_ip
