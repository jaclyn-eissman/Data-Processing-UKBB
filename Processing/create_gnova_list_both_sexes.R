library(data.table)

#directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#read in job fail lists
B1 <- fread(paste0(dir,"failed_joblist_32817092.txt"),header=F) #7
B2 <- fread(paste0(dir,"failed_joblist_32840957.txt"),header=F) #6
B3 <- fread(paste0(dir,"failed_joblist_32858843.txt"),header=F) #1

#pull subjob numbers only
B1$V1 <- sapply(strsplit(B1$V1, "_"), "[", 2)
B2$V1 <- sapply(strsplit(B2$V1, "_"), "[", 2)
B3$V1 <- sapply(strsplit(B3$V1, "_"), "[", 2)

#read in lists used for processing
B1_list <- fread(paste0(dir,"Both_sexes_success_list_one.txt"),header=F) #1492
B2_list <- fread(paste0(dir,"Both_sexes_success_list_two.txt"),header=F) #1500
B3_list <- fread(paste0(dir,"Both_sexes_success_list_three.txt"),header=F) #1531

#pull out the failed files from the lists
B1_list <- B1_list[!seq_len(nrow(B1_list)) %in% B1$V1,] #1485
B2_list <- B2_list[!seq_len(nrow(B2_list)) %in% B2$V1,] #1494 
B3_list <- B3_list[!seq_len(nrow(B3_list)) %in% B3$V1,] #1530

#combine
B_list <- rbind(B1_list,B2_list,B3_list) #4509
length(unique(B_list$V1))  #4509
nrow(B1_list) + nrow(B2_list) + nrow(B3_list) #4509
B_list <- B_list[!duplicated(B_list$V1),] #4509

#write out lists for gnova
write.table(B_list,paste0(dir,"both_sexes_trait_list.txt"),quote=F,row.names=F,col.names=F)


