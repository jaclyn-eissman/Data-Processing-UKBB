#!/bin/bash
#SBATCH--mail-user=jaclyn.m.eissman@vanderbilt.edu
#SBATCH--mail-type=ALL
#SBATCH--ntasks=1
#SBATCH--cpus-per-task=1
#SBATCH--constraint=skylake
#SBATCH--time=5:00:00
#SBATCH--mem=28GB
#SBATCH--array=1-
#SBATCH--begin=now+3hour
#SBATCH--job-name=prep_UKBB_both_sexes_two
#SBATCH--output=/data/h_vmac/eissmajm/UKBB/logfiles/both_sexes/B2_%A_%a.out

both_sexes_file_list=$(cat /data/h_vmac/eissmajm/UKBB/Both_sexes_success_list_two.txt | awk -v line=$SLURM_ARRAY_TASK_ID '{if (NR == line) print $0}')
sh /data/h_vmac/eissmajm/UKBB/format_munge_both_sexes.sh $both_sexes_file_list