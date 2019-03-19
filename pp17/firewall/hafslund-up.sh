#!/bin/sh

ip route add default via 77.88.97.201
ip route add 10.20.40.10 via 10.20.30.10

#restore iptables
iptables-restore < /usr/local/bin/iprules
