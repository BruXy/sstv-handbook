#!/bin/sh
INPUT=stations.ctex
cat $INPUT | sed -e 's/\\bTR\\bTD//' -e 's/\\eTD\\eTR//' -e 's/\\eTD\\bTD/\&/g' | awk -f list2freq  | sort -n  | cut -d '=' -f 2- | \
sed -e 's/%FREQ//' > stan_freq.ctex


