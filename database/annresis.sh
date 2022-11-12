#!/bin/bash

# 对抗性基因数据库筛选
# 使用软件：BLAST HMMER
# 初始序列是 FASTA 格式

############################################# 

#seq=${1}

blastp -query $seq -db ./RG_database/cardresis -evalue 1e-30 -outfmt 6 -out blast_cardresis_out

blastp -query $seq -db ./RG_database/mibigresis -evalue 1e-30 -outfmt 6 -out blast_mibigresis_out

hmmscan --noali -E 1e-10 --tblout hmmscout.tbl ./RG_database/ncbiRG.HMM $seq > hmmscout

rm hmmscout 

#############################################

c_out=$(cat blast_cardresis_out | head -n 1|awk '{print $1","$2","$11}')
m_out=$(cat blast_mibigresis_out | head -n 1 |awk '{print $1","$2","$11}')
n_out=$(cat hmmscout.tbl | awk 'NR==4 {print; exit}'|awk '{print $3","$1","$5}')

c=$(cat blast_cardresis_out | head -n 1 |awk '{printf $12}' )
m=$(cat blast_mibigresis_out | head -n 1 |awk '{printf $12}') 
n=$(cat hmmscout.tbl | awk 'NR==4 {print; exit}' |awk '{printf $6}')

#echo $c,$m,$n

############### 判断空值 ###################

#[ ! $c ] && echo "cardresis no result"
#[ ! $m ] && echo "mibigresis no result"
#[ ! $n ] && echo "ncbiRG no result"

best=$(if [ -n "$c" ] && [ -n "$m" ] && [ -n "$n" ]; then echo out1
  elif [ -n "$c" ] && [ ! "$m" ] && [ -n "$n" ]; then echo out2
  elif [ -n "$c" ] && [ -n "$m" ] && [ ! "$n" ]; then echo out3
  elif [ ! "$c" ] && [ -n "$m" ] && [ -n "$n" ]; then echo out4
  elif [ -n "$c" ] && [ ! "$m" ] && [ ! "$n" ]; then echo out5
  elif [ ! "$c" ] && [ -n "$m" ] && [ ! "$n" ]; then echo out6
  elif [ ! "$c" ] && [ ! "$m" ] && [ -n "$n" ]; then echo out7
  elif [ ! "$c" ] && [ ! "$m" ] && [ ! "$n" ]; then echo out8
  fi)

############## 输出最佳结果 ################

case $best in
  out1)
    if [ `echo "$c > $m"|bc` = 1 ]; then
      max=$c
      min=$m
    else 
      max=$m
      min=$c
    fi

    if [ `echo "$n > $max"|bc` -eq 1 ]; then
      max=$n
    elif [ `echo "$n < $min"|bc` -eq 1 ]; then
      min=$n
    fi
      out=$(if [ $max == $c ]; then echo $c_out 
          elif [ $max == $m ]; then echo $m_out 
          elif [ $max == $n ]; then echo $n_out 
          fi)
      echo $out ;;
  out2)
    if [ `echo "$c > $n"|bc` = 1 ]; then
      echo $c_out
    else echo $n_out
    fi ;;
  out3)
    if [ `echo "$c > $m"|bc` = 1 ]; then
      echo $c_out
    else echo $m_out
    fi ;;
  ou4)
    if [ `echo "$m > $n"|bc` = 1 ]; then
      echo $m_out
    else echo $n_out
    fi ;;
  out5)
    echo $c_out ;;
  out6)
    echo $m_out ;;
  out7)
    echo $n_out ;;
  out8)
    echo "NO RESULT" ;;
esac
 
