#!/bin/bash
ifconfig eth15 | grep "RX p" | awk -F':' '{print $2}' | awk -F' ' '{print $1}'
