#!/bin/bash

while getopts hs: opt; do
  case "$opt" in  
    h)
    echo "This scripts annotation the function and mechanism of resistance gene.
    "
    echo "Usage:
    
    ./annmech.sh -s <sequence> 
    "
    exit 0 ;;
    s) seq=$OPTARG 
    f_out=$(. ./annresis.sh $seq)
    echo;echo "Query,Target,E-value";echo $f_out;echo;echo "Function,Mechanism" ;;
    
  esac
done

##########################################################################################

#echo $c,$m,$n
#awk 'NR==1 {print; exit}' tmpout

echo $f_out > tmpout
sub=$(cat tmpout | awk -F ',' '{print $2}')

if [[ $sub == gb* ]]; then 
  c_key=$(echo $sub |awk -F '|' '{print $3}')
  grep $c_key index_card.csv |awk -F ',' '{print $3","$4}'
elif [[ $sub == *NCBIFAM ]]; then 
  grep $sub index_ncbiAMR.csv |awk -F ',' '{print $2","$3}'
elif [[ $sub == BGC* ]]; then
  m_key=$(echo $sub |awk -F '|' '{print $NF}')
  grep $m_key inde_mibigrg.csv |awk -F ',' '{print $4","$5}'
elif [[ $sub == sp* ]]; then 
  u_key=$(echo $sub |awk -F '|' '{print $2}')
  grep $u_key index_uniprotrg.csv |awk -F ',' '{print $2","$3}' 
elif [ ! $sub ]; then echo "NO RESULT"
fi

echo

rm tmpout;rm blast_cardresis_out;rm blast_mibigresis_out;rm hmmscout.tbl;rm blast_uniprotresis_out


