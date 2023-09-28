#!/bin/bash
#SBATCH--mail-user=jaclyn.m.eissman@vanderbilt.edu
#SBATCH--mail-type=ALL
#SBATCH--ntasks=1
#SBATCH--cpus-per-task=1
#SBATCH--constraint=skylake
#SBATCH--time=9:00:00
#SBATCH--mem=23GB
#SBATCH--array=1-1201%200
#SBATCH--job-name=prep_UKBB_females_two
#SBATCH--output=/data/h_vmac/eissmajm/UKBB/logfiles/females/F2_%A_%a.out

female_file_list=$(cat /data/h_vmac/eissmajm/UKBB/Female_success_list_two.txt | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}')
sh /data/h_vmac/eissmajm/UKBB/format_munge_females.sh $female_file_list

