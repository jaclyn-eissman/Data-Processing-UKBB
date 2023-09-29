###By Jaclyn Eissman, 2021

#!/bin/bash

#Set up array 
male_file_list=$1

#Change directory 
cd /data/h_vmac/eissmajm/UKBB/males

#Unzip file and remove zipped file
gunzip -c ${male_file_list}.tsv.bgz > ${male_file_list}.tsv
rm ${male_file_list}.tsv.bgz

#Run Rscript to format
Rscript /data/h_vmac/eissmajm/UKBB/Organize_Clean_UKBB.R ${male_file_list}

#Check if a text file was made from Rscript, if not exit script
if [[ ! -f ${male_file_list}.txt ]]; then exit 1 ; fi

#Remove unformatted file 
rm ${male_file_list}.tsv

###MUNGE

#Load modules and source virtual environment
module restore gnova_python2
source /data/h_vmac/eissmajm/python2/bin/activate

#Munge trait
/data/h_vmac/eissmajm/GNOVA/munge_sumstats.py \
--signed-sumstats EFFECT,0 \
--out ${male_file_list} \
--a1 A1 \
--a2 A2 \
--N-col N \
--snp SNP \
--sumstats ${male_file_list}.txt \
--p p-value

#Check if a munge file was successfully made, if not exit script
if [[ ! -f ${male_file_list}.sumstats.gz ]]; then exit 1 ; fi

#Remove formatted text file 
rm ${male_file_list}.txt
