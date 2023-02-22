#!/bin/bash

#seq=${1}

blastp -query $seq -db ./RG_database/cardresis -evalue 1e-30 -outfmt 6 -out blast_cardresis_out

blastp -query $seq -db ./RG_database/mibigresis -evalue 1e-30 -outfmt 6 -out blast_mibigresis_out

hmmscan --noali -E 1e-10 --tblout hmmscout.tbl ./RG_database/ncbiRG.HMM $seq > hmmscout

rm hmmscout 

blastp -query $seq -db ./RG_database/uniprotresis -evalue 1e-30 -outfmt 6 -out blast_uniprotresis_out

############################################################################################################

c_out=$(cat blast_cardresis_out | head -n 1|awk '{print $1","$2","$11}')
m_out=$(cat blast_mibigresis_out | head -n 1 |awk '{print $1","$2","$11}')
n_out=$(cat hmmscout.tbl | awk 'NR==4 {print; exit}'|awk '{print $3","$1","$5}')
u_out=$(cat blast_uniprotresis_out | head -n 1 |awk '{print $1","$2","$11}')

c=$(cat blast_cardresis_out | head -n 1 |awk '{printf $12}' )
m=$(cat blast_mibigresis_out | head -n 1 |awk '{printf $12}') 
n=$(cat hmmscout.tbl | awk 'NR==4 {print; exit}' |awk '{printf $6}')
u=$(cat blast_uniprotresis_out | head -n 1 |awk '{printf $12}')

echo $c >> out.tmp
echo $m >> out.tmp
echo $n >> out.tmp
echo $u >> out.tmp
sed -i -e '/^$/d' out.tmp
rm out.tmp-e

MA=$(cat out.tmp | awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print max}')

case $MA in
  $c)
    echo $c_out ;;
  $m)
    echo $m_out ;;
  $n)
    echo $n_out ;;
  $u)
    echo $u_out ;;
  0)
    echo "NO RESULT" ;;
esac

rm out.tmp 
