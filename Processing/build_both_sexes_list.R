###By Jaclyn Eissman, 2020

#Packages
library(data.table)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#Read in csv files that contain stats info
csv1 <- read.csv(paste0(dir,"UKBB_Manifest_201807_both_sexes_one_updated.csv"),header=F,sep=",") #1500
csv1 <- csv1[9:1500,] #don't need these rows in this txt file bc only descriptive files, #1492
csv2 <- read.csv(paste0(dir,"UKBB_Manifest_201807_both_sexes_two_updated.csv"),header=F,sep=",") #1500
csv3 <- read.csv(paste0(dir,"UKBB_Manifest_201807_both_sexes_three_updated.csv"),header=F,sep=",") #1593

#Rename cols
names(csv1) <- c("Phenotype","File_Name","wget_command","Download_Status")
names(csv2) <- c("Phenotype","File_Name","wget_command","Download_Status")
names(csv3) <- c("Phenotype","File_Name","wget_command","Download_Status")

#Separate out by successful and unsuccessful downloads 
csv1_success <- csv1[csv1$Download_Status=="Success",] #1492
csv1_error <- csv1[csv1$Download_Status=="Error",] #0

csv2_success <- csv2[csv2$Download_Status=="Success",] #1500
csv2_error <- csv2[csv2$Download_Status=="Error",] #0

csv3_success <- csv3[csv3$Download_Status=="Success",] #1531
csv3_error <- csv3[csv3$Download_Status=="Error",] #62

#Write out text file of Successful downloaded files
csv1_success$File_Name <- gsub(".tsv.bgz","",csv1_success$File_Name)
csv2_success$File_Name <- gsub(".tsv.bgz","",csv2_success$File_Name)
csv3_success$File_Name <- gsub(".tsv.bgz","",csv3_success$File_Name)

file1 <- csv1_success[,c("File_Name")]
file2 <- csv2_success[,c("File_Name")]
file3 <- csv3_success[,c("File_Name")]

write.table(file1,paste0(dir,"Both_sexes_success_list_one.txt"),quote=F,row.names=F,col.names=F)
write.table(file2,paste0(dir,"Both_sexes_success_list_two.txt"),quote=F,row.names=F,col.names=F)
write.table(file3,paste0(dir,"Both_sexes_success_list_three.txt"),quote=F,row.names=F,col.names=F)
