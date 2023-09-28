library(data.table)

#directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/files/"

#read in job fail lists
F1 <- fread(paste0(dir,"failed_joblist_28674390.txt"),header=F)
F2 <- fread(paste0(dir,"failed_joblist_28677495.txt"),header=F) 
F3 <- fread(paste0(dir,"failed_joblist_28682475.txt"),header=F)

M1 <- fread(paste0(dir,"failed_joblist_28674391.txt"),header=F)
M2 <- fread(paste0(dir,"failed_joblist_28680316.txt"),header=F)
M3 <- fread(paste0(dir,"failed_joblist_28696109.txt"),header=F)

#pull subjob numbers only
F1$V1 <- sapply(strsplit(F1$V1, "_"), "[", 2)
F2$V1 <- sapply(strsplit(F2$V1, "_"), "[", 2)
F3$V1 <- sapply(strsplit(F3$V1, "_"), "[", 2)

M1$V1 <- sapply(strsplit(M1$V1, "_"), "[", 2)
M2$V1 <- sapply(strsplit(M2$V1, "_"), "[", 2)
M3$V1 <- sapply(strsplit(M3$V1, "_"), "[", 2)

#read in lists used for processing
F1_list <- fread(paste0(dir,"Female_success_list_one.txt"),header=F)
F2_list <- fread(paste0(dir,"Female_success_list_two.txt"),header=F)
F3_list <- fread(paste0(dir,"Female_success_list_three.txt"),header=F)

M1_list <- fread(paste0(dir,"Male_success_list_one.txt"),header=F)
M2_list <- fread(paste0(dir,"Male_success_list_two.txt"),header=F)
M3_list <- fread(paste0(dir,"Male_success_list_three.txt"),header=F)

#pull out the failed files from the lists
F1_list <- F1_list[!seq_len(nrow(F1_list)) %in% F1$V1,]
F2_list <- F2_list[!seq_len(nrow(F2_list)) %in% F2$V1,]
F3_list <- F3_list[!seq_len(nrow(F3_list)) %in% F3$V1,]

M1_list <- M1_list[!seq_len(nrow(M1_list)) %in% M1$V1,]
M2_list <- M2_list[!seq_len(nrow(M2_list)) %in% M2$V1,]
M3_list <- M3_list[!seq_len(nrow(M3_list)) %in% M3$V1,]

#combine
F_list <- rbind(F1_list,F2_list,F3_list)
length(unique(F_list$V1))
nrow(F1_list) + nrow(F2_list) + nrow(F3_list) 
F_list <- F_list[!duplicated(F_list$V1),]

M_list <- rbind(M1_list,M2_list,M3_list)
length(unique(M_list$V1))
nrow(M1_list) + nrow(M2_list) + nrow(M3_list) 
M_list <- M_list[!duplicated(M_list$V1),]

#write out lists for gnova
write.table(F_list,paste0(dir,"female_trait_list.txt"),quote=F,row.names=F,col.names=F)
write.table(M_list,paste0(dir,"male_trait_list.txt"),quote=F,row.names=F,col.names=F)


