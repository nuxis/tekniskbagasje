#!/bin/bash 
COUNTER=1
while [  $COUNTER -lt 255 ]; do
echo iptables -t -nat -A PREROUTING -d 91.90.71.$COUNTER -j DNAT --to-destination 195.1.95.$COUNTER
echo iptables -t -nat -A PREROUTING -s 195.1.95.$COUNTER -j SNAT --to-source 91.90.71.$COUNTER
let COUNTER=COUNTER+1 
done
