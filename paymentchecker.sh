#!/bin/bash
ID=0
RG=""

while getopts i:r: option
do
 case "${option}"
 in
 i) ID=${OPTARG};;
 r) RG=${OPTARG};;
 esac
done
if [ $ID -eq 0 ] || [ $RG == "" ]
  then
  echo "Run script like this: ./paymentchecker.sh -i nodeid -r regioncode"
  exit 2
fi
if [ $ID -eq 0 ]
 then
 echo "No nodeid specified."
 exit 2
fi
if [ $RG == "" ]
  then
  echo "No region code specified. Region codes are: eu for Europe. na for North America. sea for Souteast Asia."
  exit 2
fi
wget -q -O pay https://securenodes.$RG.zensystem.io/api/grid/$ID/pmts && cat pay | grep -o -P '"zen":".{0,10}' | sed 's/\"zen\"\:\"//g' | sed 's/null//g' | perl -nle '$sum += $_ } END { print $sum'
rm pay
