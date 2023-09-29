###By Jaclyn Eissman, 2021

#Packages
library(data.table)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#Read UKB excel doc
csv <- read.csv(paste0(dir,"UKBB GWAS Imputed v3 - File Manifest Release 20180731 - Manifest 201807.csv")) #N=11934

#Pull males wget and write out
males <- csv[csv$Sex=="male",]
males <- males[,c("Phenotype.Code","File","wget.command")]
write.table(males,paste0(dir,"UKBB_Manifest_201807_males.csv"),row.names=F,quote=F,col.names=F,sep=",") #N=3589

males_one <- males[1:1100,]
write.table(males_one,paste0(dir,"UKBB_Manifest_201807_males_one.csv"),row.names=F,quote=F,col.names=F,sep=",") 
males_two <- males[1100:2300,]
write.table(males_two,paste0(dir,"UKBB_Manifest_201807_males_two.csv"),row.names=F,quote=F,col.names=F,sep=",") 
males_three <- males[2300:dim(males)[1],]
write.table(males_three,paste0(dir,"UKBB_Manifest_201807_males_three.csv"),row.names=F,quote=F,col.names=F,sep=",") 

#Pull femlaes wget and write out
females <- csv[csv$Sex=="female",]
females <- females[,c("Phenotype.Code","File","wget.command")]
write.table(females,paste0(dir,"UKBB_Manifest_201807_females.csv"),row.names=F,quote=F,col.names=F,sep=",") #N=3748

females_one <- females[1:1200,]
write.table(females_one,paste0(dir,"UKBB_Manifest_201807_females_one.csv"),row.names=F,quote=F,col.names=F,sep=",")
females_two <- females[1200:2400,]
write.table(females_two,paste0(dir,"UKBB_Manifest_201807_females_two.csv"),row.names=F,quote=F,col.names=F,sep=",")
females_three <- females[2400:dim(females)[1],]
write.table(females_three,paste0(dir,"UKBB_Manifest_201807_females_three.csv"),row.names=F,quote=F,col.names=F,sep=",")
