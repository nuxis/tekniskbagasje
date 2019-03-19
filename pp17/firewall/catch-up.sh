#!/bin/sh

#Routing via cactch linja for alt merka med 0x10 i iptables mangel table
ip route add table 10 0.0.0.0 via 81.0.137.6
ip rule add fwmark 0x10 table 10

