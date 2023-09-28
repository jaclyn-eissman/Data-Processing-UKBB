#packages
library(data.table)
library(openxlsx)
library(ggplot2)
library(ggrepel)

#directory
dir <- "/Users/jackieeissman/Box Sync/Hohman_Lab/Students/Jaclyn Eissman/UKBB/"

#read in excel file with groups
  #unique(excel$Phenotype.Group) -- looks like all groups are filled in for all phenotypes
excel <- read.xlsx(paste0(dir,"UKBB_all_with_pheno_groups_v2.xlsx"))

#subset to females
females <- excel[excel$Sex=="female",]

#remove the extensions from file name
females$File <- gsub(".tsv.bgz","",females$File)

#read in example data
cogres <- read.table(paste0(dir,"results/FEMALES.COGRES.ALL.txt"),header=T)
cogres$trait <- gsub(".cogres.txt","",cogres$trait)
cogres$trait <- gsub("[[:space:]]+$", "",cogres$trait)

#merge 
cogres <- merge(cogres,females,by.x="trait",by.y="File")
cogres <- cogres[order(cogres$pvalue_corrected),]
cogres$P.Fdr <- p.adjust(cogres$pvalue_corrected,method="fdr")

#pull traits that survive FDR...and see which ones I want to label
sig <- cogres[cogres$P.Fdr<0.05,]
sig <- sig[,c("Phenotype.Group","Phenotype.Description","pvalue_corrected","P.Fdr")]
sig <- sig[order(sig$Phenotype.Group,sig$P.Fdr),]
write.table(sig,paste0(dir,"results/FEMALES_COGRES_FDR_survive.txt"),quote=F,col.names=T,row.names=F)
to_label <- c("Diseases of liver","Illnesses of mother: Stroke")

#add binary variable for pos or neg assoc
cogres$direction <- ifelse(cogres$rho_corrected>0,1,2)

#plotting 
png(paste0(dir,"plots/FEMALES_COGRES.png"),width=13,height=7.5,units="in",res=1000)
ggplot(cogres, aes(x=Phenotype.Group, y=-log10(pvalue_corrected),color=Phenotype.Group,group=direction)) + 
  geom_point(position="jitter",aes(color=Phenotype.Group,shape=as.factor(direction))) + theme_bw() + 
  scale_shape_manual(values=c(2,6)) + geom_hline(yintercept=-log10(2.861710e-03), linetype="dashed") + 
  theme(axis.text.x=element_text(angle=45, hjust=1)) + theme(legend.position="none") +
  xlab("Phenotype") + ylab("-log(P)") + ggtitle("Female Associations between Resilience and UK Biobank Traits") +
  geom_text_repel(aes(label=ifelse(Phenotype.Description %in% to_label,Phenotype.Description,"")),max.overlaps=Inf)
dev.off()




