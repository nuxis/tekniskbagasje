#!/bin/bash

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables-restore < /etc/iptables
ip rule add fwmark 0x50 table 256
ip route add default via 81.0.137.6 table 256
