#!/bin/bash
ID=0
RG=""
usage=$"Run script like this: ./paymentchecker.sh -i nodeid -r regioncode.\nRegion codes are: eu for Europe. na for North America. sea for Southeast Asia."
while getopts i:r: option
do
 case "${option}"
 in
 i) ID=${OPTARG};;
 r) RG=${OPTARG};;
 esac
done
if [ $ID -gt 1 ]
  then
    if [ "$RG" == "eu" ] || [ "$RG" == "na" ] || [ "$RG" == "sea" ]
      then
      wget -q -O zenpay$ID https://securenodes.$RG.zensystem.io/api/grid/$ID/pmts && cat zenpay$ID | grep -o -P '"zen":".{0,10}' | sed 's/\"zen\"\:\"//g' | sed 's/null//g' | perl -nle '$sum += $_ } END { print $sum'
      rm zenpay$ID
    fi
  else
     echo -e $usage
     exit 2
fi
