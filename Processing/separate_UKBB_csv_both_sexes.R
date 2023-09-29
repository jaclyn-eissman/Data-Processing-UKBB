###By Jaclyn Eissman, 2021

#Packages
library(data.table)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#Read UKB excel doc
csv <- read.csv(paste0(dir,"UKBB GWAS Imputed v3 - File Manifest Release 20180731 - Manifest 201807.csv")) #N=11934

#Pull both sexes traits and write out
both_sexes <- csv[csv$Sex=="both_sexes",] #4953
both_sexes <- both_sexes[,c("Phenotype.Code","File","wget.command")]
write.table(both_sexes,paste0(dir,"UKBB_Manifest_201807_both_sexes.csv"),row.names=F,quote=F,col.names=F,sep=",") 

#Separate out into three sections and write out
both_sexes_one <- both_sexes[1:1500,] #1500
write.table(both_sexes_one,paste0(dir,"UKBB_Manifest_201807_both_sexes_one.csv"),row.names=F,quote=F,col.names=F,sep=",")

both_sexes_two <- both_sexes[1501:3000,] #1500
write.table(both_sexes_two,paste0(dir,"UKBB_Manifest_201807_both_sexes_two.csv"),row.names=F,quote=F,col.names=F,sep=",")

both_sexes_three <- both_sexes[3001:dim(both_sexes)[1],] #1593
write.table(both_sexes_three,paste0(dir,"UKBB_Manifest_201807_both_sexes_three.csv"),row.names=F,quote=F,col.names=F,sep=",")
