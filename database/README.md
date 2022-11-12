# RG database (https://github.com/mingdengming/rga)

RG database (Resistance Gene database): is a database that can provide resistance gene comparison function. It contains resistance gene sequences, resistance mechanism index, and resistance gene annotation scripts.

This scripts (annmech.sh) is based on BLAST and HMMER software, written in Bash. It can screen similar resistance genes and annotate resistance mechanisms. To run this script, you must install BLAST 2.11.0+ and HMMER 3.3.2. 

### You should run scripts in the current directory. Only one sequence can be processed at a time.

1.The scripts Usage: 
 
./annmech.sh -h;                     Show basic usage
./annmech.sh -s <Your sequence> ;    Run scripts           

2.Interpretation of results：

Query,Target,E-value: Your sequence ID, The most similar sequence compared from the RG database, Similarity value (from BLAST and HMMER).

Function,Mechanism: Indicates the possible resistance function and mechanism of your resistance gene sequence.


