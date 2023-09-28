#!/bin/bash

#set up array 
female_file_list=$1

#change directory 
cd /data/h_vmac/eissmajm/UKBB/females

#unzip file and remove zipped file
gunzip -c ${female_file_list}.tsv.bgz > ${female_file_list}.tsv
rm ${female_file_list}.tsv.bgz

#run Rscript to format
Rscript /data/h_vmac/eissmajm/UKBB/Organize_Clean_UKBB.R ${female_file_list}

#check if a text file was made from Rscript, if not exit script
if [[ ! -f ${female_file_list}.txt ]]; then exit 1 ; fi

#remove unformatted file 
rm ${female_file_list}.tsv

###MUNGE

#load modules and source virtual environment
module restore gnova_python2
source /data/h_vmac/eissmajm/python2/bin/activate

#munge trait
/data/h_vmac/eissmajm/GNOVA/munge_sumstats.py \
--signed-sumstats EFFECT,0 \
--out ${female_file_list} \
--a1 A1 \
--a2 A2 \
--N-col N \
--snp SNP \
--sumstats ${female_file_list}.txt \
--p p-value

#check if a munge file was successfully made, if not exit script
if [[ ! -f ${female_file_list}.sumstats.gz ]]; then exit 1 ; fi

#remove formatted text file 
rm ${female_file_list}.txt
