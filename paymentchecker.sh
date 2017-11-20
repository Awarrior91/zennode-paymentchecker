#!/bin/bash
ID=0

while getopts i: option
do
 case "${option}"
 in
 i) ID=${OPTARG};;
 esac
done
if [ $ID -eq 0 ]
then
 echo "No nodeid specified. Run script like this:./paymentchecker.sh -i yournodeid"
 exit 2
fi
wget -q -O pay https://securenodes.eu.zensystem.io/api/grid/$ID/pmts && cat pay | grep -o -P '"zen":".{0,10}' | sed 's/\"zen\"\:\"//g' | sed 's/null//g' | perl -nle '$sum += $_ } END { print $sum'
rm pay
