## Code to generate the figures to the Bgee Call paper
##  libraries used
library(ggplot2)

pathToFIles <- "/Users/sfonseca1/Desktop/Data_paper/"
Threshold_2 <- read.table(paste0(pathToFIles, "/", "presence_absence_all_samples_TPM-treshold.txt"), header=TRUE, sep="\t", comment.char="")
bgee_withoutDecov <- read.table(paste0(pathToFIles, "/", "presence_absence_all_samples_without_decov.txt"), header=TRUE, sep="\t", comment.char="")
bgeeThreshold <- read.table(paste0(pathToFIles, "/", "presence_absence_all_samples_14.txt"), header=TRUE, sep="\t", comment.char="")

infoFile <- read.table(paste0(pathToFIles, "/", "info_rnaSeq.tsv"), header=TRUE, sep="\t", comment.char="")

## Threshold = 2
gg_Threshold_2 <- ggplot(data = Threshold_2, mapping = aes(x = Threshold_2$organism, y = Threshold_2$proportionCodingPresent, label=Threshold_2$organism)) +
  geom_boxplot(alpha = 1) + 
  labs(x = "", y = "% Protein Coding Genes") +
  scale_y_continuous(limits=c(0,100)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
gg_Threshold_2


## Bgee without deconvolution
gg_bgeeWithDec <- ggplot(data = bgee_withoutDecov, mapping = aes(x = bgee_withoutDecov$organism, y = bgee_withoutDecov$proportionCodingPresent, label=bgee_withoutDecov$organism)) +
  geom_boxplot(alpha = 1) + 
  labs(x = "", y = "% Protein Coding Genes") +
  scale_y_continuous(limits=c(0,100)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
gg_bgeeWithDec

## Bgee Intergenic cut-off
gg_bgee <- ggplot(data = bgeeThreshold, mapping = aes(x = bgeeThreshold$organism, y = bgeeThreshold$proportionCodingPresent, label=bgeeThreshold$organism)) +
  geom_boxplot(alpha = 1) + 
  labs(x = "", y = "% Protein Coding Genes") +
  scale_y_continuous(limits=c(0,100)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 
gg_bgee


## Collect just GTEx data
gtexData <- dplyr::filter(infoFile, experimentId == "SRP012682")

## Gtex with Threshold = 2
gtexThreshold <- merge(Threshold_2, gtexData, by="X.libraryId")

gtexThreshold_cutoff <- ggplot(data = gtexThreshold, mapping = aes(x = gtexThreshold$uberonName, y = gtexThreshold$proportionCodingPresent, label=gtexThreshold$uberonName)) +
  geom_boxplot(alpha = 1) + 
  labs(x = "", y = "% Protein Coding Genes") +
  scale_y_continuous(limits=c(0,100)) +
  theme(axis.text.x = element_text(angle = 55, hjust = 1))
gtexThreshold_cutoff


## Gtex with Bgee cut-off
gtexBgee <- merge(bgeeThreshold, gtexData, by="X.libraryId")

gtexBgee_cutoff <- ggplot(data = gtexBgee, mapping = aes(x = gtexBgee$uberonName, y = gtexBgee$proportionCodingPresent, label=gtexBgee$uberonName)) +
  geom_boxplot(alpha = 1) + 
  labs(x = "", y = "% Protein Coding Genes") +
  scale_y_continuous(limits=c(0,100)) +
  theme(axis.text.x = element_text(angle = 55, hjust = 1))
gtexBgee_cutoff

