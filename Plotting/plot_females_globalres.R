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

#Subset to females
females <- excel[excel$Sex=="female",]

#Remove the extensions from file name
females$File <- gsub(".tsv.bgz","",females$File)

#Read in example data
globalres <- read.table(paste0(dir,"results/FEMALES.GLOBALRES.ALL.txt"),header=T)
globalres$trait <- gsub(".globalres.txt","",globalres$trait)
globalres$trait <- gsub("[[:space:]]+$", "",globalres$trait)

#Merge 
globalres <- merge(globalres,females,by.x="trait",by.y="File")
globalres <- globalres[order(globalres$pvalue_corrected),]
globalres$P.Fdr <- p.adjust(globalres$pvalue_corrected,method="fdr")

#Pull traits that survive FDR...and see which ones I want to label
sig <- globalres[globalres$P.Fdr<0.05,]
sig <- sig[,c("Phenotype.Group","Phenotype.Description","pvalue_corrected","P.Fdr")]
sig <- sig[order(sig$Phenotype.Group,sig$P.Fdr),]
write.table(sig,paste0(dir,"results/FEMALES_GLOBALRES_FDR_survive.txt"),quote=F,col.names=T,row.names=F)
to_label <- c()

#Add binary variable for pos or neg assoc
globalres$direction <- ifelse(globalres$rho_corrected>0,1,2)

#Plotting 
png(paste0(dir,"plots/FEMALES_GLOBALRES.png"),width=13,height=7.5,units="in",res=1000)
ggplot(globalres, aes(x=Phenotype.Group, y=-log10(pvalue_corrected), color=Phenotype.Group, shape=as.factor(direction))) + 
  geom_jitter() + theme_bw() + geom_hline(yintercept=-log10(2.861710e-03), linetype="dashed") + 
  theme(axis.text.x=element_text(angle=45, hjust=1)) + theme(legend.position="none") +
  xlab("Phenotype") + ylab("-log(P)") + ggtitle("Female Associations between Resilience and UK Biobank Traits") +
  geom_text_repel(aes(label=ifelse(Phenotype.Description %in% to_label,Phenotype.Description,"")),max.overlaps=Inf) +
  scale_shape_manual(values=c(2,6)) 
dev.off()
