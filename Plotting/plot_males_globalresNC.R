###By Jaclyn Eissman, 2021

#Packages
library(data.table)
library(openxlsx)
library(ggplot2)
library(ggrepel)

#Directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/"

#Read in excel file with groups
  #unique(excel$Phenotype.Group) -- looks like all groups are filled in for all phenotypes
excel <- read.xlsx(paste0(dir,"UKBB_all_with_pheno_groups_v2.xlsx"))

#Subset to males
males <- excel[excel$Sex=="male",]

#Remove the extensions from file name
males$File <- gsub(".tsv.bgz","",males$File)

#Read in example data
globalresNC <- read.table(paste0(dir,"results/MALES.GLOBALRES_NC.ALL.txt"),header=T)
globalresNC$trait <- gsub(".globalresNC.txt","",globalresNC$trait)
globalresNC$trait <- gsub("[[:space:]]+$", "",globalresNC$trait)

#Merge 
globalresNC <- merge(globalresNC,males,by.x="trait",by.y="File")
globalresNC <- globalresNC[order(globalresNC$pvalue_corrected),]
globalresNC$P.Fdr <- p.adjust(globalresNC$pvalue_corrected,method="fdr")

#Pull traits that survive FDR...and see which ones I want to label
sig <- globalresNC[globalresNC$P.Fdr<0.05,]
sig <- sig[,c("Phenotype.Group","Phenotype.Description","pvalue_corrected","P.Fdr")]
sig <- sig[order(sig$Phenotype.Group,sig$P.Fdr),]
write.table(sig,paste0(dir,"results/MALES_GLOBALRES_NC_FDR_survive.txt"),quote=F,col.names=T,row.names=F)
to_label <- c()

#Add binary variable for pos or neg assoc
globalresNC$direction <- ifelse(globalresNC$rho_corrected>0,1,2)

#Plotting 
png(paste0(dir,"plots/MALES_GLOBALRES_NC.png"),width=13,height=7.5,units="in",res=1000)
ggplot(globalresNC, aes(x=Phenotype.Group, y=-log10(pvalue_corrected), color=Phenotype.Group, shape=as.factor(direction))) + 
  geom_jitter() + theme_bw() + geom_hline(yintercept=-log10(2.861710e-03), linetype="dashed") + 
  theme(axis.text.x=element_text(angle=45, hjust=1)) + theme(legend.position="none") +
  xlab("Phenotype") + ylab("-log(P)") + ggtitle("Male Associations between Resilience and UK Biobank Traits") +
  geom_text_repel(aes(label=ifelse(Phenotype.Description %in% to_label,Phenotype.Description,"")),max.overlaps=Inf) +
  scale_shape_manual(values=c(2,6)) 
dev.off()
