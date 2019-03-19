#!/bin/sh
ip route del table 10 0.0.0.0 via 81.0.137.6
ip rule del fwmark 0x10 table 10
iptables -t nat -F
iptables -t mangle -F
