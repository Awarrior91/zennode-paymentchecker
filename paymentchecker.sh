#!/bin/bash
while getopts i: option
do
 case "${option}"
 in
 i) ID=${OPTARG};;
 esac
done
wget -q -O pay https://securenodes.eu.zensystem.io/api/grid/$ID/pmts && cat pay | grep -o -P '"zen":".{0,10}' | sed 's/\"zen\"\:\"//g' | sed 's/null//g' | perl -nle '$sum += $_ } END { print $sum'
