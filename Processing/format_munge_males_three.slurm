#!/bin/bash
#SBATCH--mail-user=jaclyn.m.eissman@vanderbilt.edu
#SBATCH--mail-type=ALL
#SBATCH--ntasks=1
#SBATCH--cpus-per-task=1
#SBATCH--constraint=skylake
#SBATCH--time=9:00:00
#SBATCH--mem=23GB
#SBATCH--array=1-1176%200
#SBATCH--job-name=prep_UKBB_males_three
#SBATCH--output=/data/h_vmac/eissmajm/UKBB/logfiles/males/M3_%A_%a.out

male_file_list=$(cat /data/h_vmac/eissmajm/UKBB/Male_success_list_three.txt | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}')
sh /data/h_vmac/eissmajm/UKBB/format_munge_males.sh $male_file_list

