library(data.table)

#directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#read in csv files
csv1 <- read.csv(paste0(dir,"UKBB_Manifest_201807_males_one_updated.csv"),header=F,sep=",")
csv1 <- csv1[8:1100,] #don't need 1st 7 rows in this txt file bc only descriptive files
csv2 <- read.csv(paste0(dir,"UKBB_Manifest_201807_males_two_updated.csv"),header=F,sep=",")
csv3 <- read.csv(paste0(dir,"UKBB_Manifest_201807_males_three_updated.csv"),header=F,sep=",")

#rename cols
names(csv1) <- c("Phenotype","File_Name","wget_command","Download_Status")
names(csv2) <- c("Phenotype","File_Name","wget_command","Download_Status")
names(csv3) <- c("Phenotype","File_Name","wget_command","Download_Status")

#separate out by success and error 
csv1_success <- csv1[csv1$Download_Status=="Success",]
csv1_error <- csv1[csv1$Download_Status=="Error",]

csv2_success <- csv2[csv2$Download_Status=="Success",]
csv2_error <- csv2[csv2$Download_Status=="Error",]

csv3_success <- csv3[csv3$Download_Status=="Success",]
csv3_error <- csv3[csv3$Download_Status=="Error",]

#write out text file of Successful downloaded files
csv1_success$File_Name <- gsub(".tsv.bgz","",csv1_success$File_Name)
csv2_success$File_Name <- gsub(".tsv.bgz","",csv2_success$File_Name)
csv3_success$File_Name <- gsub(".tsv.bgz","",csv3_success$File_Name)

file1 <- csv1_success[,c("File_Name")]
file2 <- csv2_success[,c("File_Name")]
file3 <- csv3_success[,c("File_Name")]

write.table(file1,paste0(dir,"Male_success_list_one.txt"),quote=F,row.names=F,col.names=F)
write.table(file2,paste0(dir,"Male_success_list_two.txt"),quote=F,row.names=F,col.names=F)
write.table(file3,paste0(dir,"Male_success_list_three.txt"),quote=F,row.names=F,col.names=F)



