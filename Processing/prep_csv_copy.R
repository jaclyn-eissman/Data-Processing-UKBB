###By Jaclyn Eissman, 2021

#Packages
library(data.table)
library(openxlsx)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#Prep excel
csv <- read.csv(paste0(dir,"UKBB GWAS Imputed v3 - File Manifest Release 20180731 - Manifest 201807.csv")) #N=11934
csv <- csv[csv$Sex=="male" | csv$Sex=="female",]
csv <- csv[,c("File","Sex","Phenotype.Code","Phenotype.Description")]
write.xlsx(csv,paste0(dir,"UKBB_all_with_pheno_groups.xlsx"),row.names=F,quote=F,col.names=T) 
