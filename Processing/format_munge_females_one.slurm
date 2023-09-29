###By Jaclyn Eissman, 2021

#!/bin/bash
#SBATCH--mail-user=jaclyn.m.eissman@vanderbilt.edu
#SBATCH--mail-type=ALL
#SBATCH--ntasks=1
#SBATCH--cpus-per-task=1
#SBATCH--constraint=skylake
#SBATCH--time=9:00:00
#SBATCH--mem=23GB
#SBATCH--array=1-1193%200
#SBATCH--job-name=prep_UKBB_females_one
#SBATCH--output=/data/h_vmac/eissmajm/UKBB/logfiles/females/F1_%A_%a.out

#Run processing script for each line in text file
female_file_list=$(cat /data/h_vmac/eissmajm/UKBB/Female_success_list_one.txt | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}')
sh /data/h_vmac/eissmajm/UKBB/format_munge_females.sh $female_file_list

