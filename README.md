# Resistance Gene Database Analysis Resistance Mechanism

RG database (Resistance Gene database): is a database that can provide resistance gene comparison function. It contains resistance gene sequences, resistance mechanism index, and resistance gene annotation scripts.

This scripts (annmech.sh) is based on BLAST and HMMER, written in Bash. It can screen similar resistance genes and annotate resistance mechanisms. To run this script, you must install BLAST 2.11.0+ and HMMER 3.3.2. 

## 1.Annotate resistance mechanism with script 

Place yourself at the current directory. Only one sequence can be processed at a time.

$ annmech.sh -s <Your sequence> 

## 2.Read your results

Query,Target,E-value: Your sequence ID, The most similar sequence compared from the RG database, Similarity value (from BLAST and HMMER).

Function,Mechanism: Indicates the possible resistance function and mechanism of your resistance gene sequence.


