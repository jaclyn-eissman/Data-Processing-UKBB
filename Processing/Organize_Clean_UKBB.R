#arguments
args <- commandArgs(TRUE)
file <- args[1] #name of summary stats file (without .tsv)

#packages
library(data.table)
setDTthreads(1)

#read in reference file with rs#s
snps <- fread("/home/clarklc/Programs/HRC_snps_nodups",header=F)

#read in and organize summary stats file
sumstat <- fread(paste0(file,".tsv"))
sumstat$SNP <- paste(sapply(strsplit(sumstat$variant, ":"), "[", 1), sapply(strsplit(sumstat$variant, ":"), "[", 2), sep=":")
sumstat <- merge(sumstat,snps,by.x="SNP",by.y="V1",all.x=T)
sumstat$V2<- ifelse(is.na(sumstat$V2),sumstat$SNP,sumstat$V2)
sumstat$A1 <- sapply(strsplit(sumstat$variant, ":"), "[", 3)
sumstat$A2 <- sapply(strsplit(sumstat$variant, ":"), "[", 4)

#subset to needed cols and remove any rows with NA
sumstat <- sumstat[,c("V2","A1","A2","beta","pval","n_complete_samples")]
sumstat <- na.omit(sumstat)
names(sumstat) <- c("SNP","A1","A2","EFFECT","P","N")

#write out file
write.table(sumstat,paste0(file,".txt"),quote=F,col.names=T,row.names=F)