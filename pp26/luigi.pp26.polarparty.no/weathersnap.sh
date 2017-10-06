#!/bin/bash

DATE=`date '+%Y-%m-%d_%H-%M-%S'`
FILENAME=$DATE.png

wget http://peach.tech.pp26.polarparty.no/plugins/Weathermap/output/mymap.png -O /root/snaps/$FILENAME -q