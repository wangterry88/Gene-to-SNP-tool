setwd("./")

cat('################# Input query information: #################')
cat('\n')
cat(prompt="\n Input your Gene name : ")
Gene_name<-readLines(con="stdin",1)

cat(prompt="\nOutput file name (Short Name): ")
Output_name<-readLines(con="stdin",1)

library(data.table)
library(dplyr)

# read file

SNP_list<-fread("./SNP-data/TPMI17W_MAF0.01_Genelist.txt",sep="\t",header=T)
#head(SNP_list)


# User input gene name

Gene_selected_stp1<-SNP_list[with(SNP_list, grepl(Gene_name, paste(SNP, ANNOT))),]
Gene_selected_stp1_list<-unique(Gene_selected_stp1$ANNOT)

cat('################# Gene Family information: #################')

cat('\n')
cat('\n The Gene Family of your query is:\n\n', Gene_selected_stp1_list)
cat('\n')
cat('\n')
cat('\n')
cat('############ Gene Query (Specific Gene Name): #################')
cat('\n')
cat(prompt="\nPlease input the specific Gene name: ")

sp_gene_name<-readLines(con="stdin",1)
Gene_selected_stp2<-subset(Gene_selected_stp1,Gene_selected_stp1$ANNOT==sp_gene_name)

cat('######## Your Specific Gene Query information: #############\n')
cat('\n')
print(Gene_selected_stp2)

cat('\n ############# Output SNP information:  #############\n')

SNP_output<-as.data.frame(Gene_selected_stp2$SNP)

cat('\n The Num. of SNPs in the Specific Gene is:' ,nrow(SNP_output))

cat('\n')

# Output plot data

tmp_output=paste0('./output/',Output_name,'.snplist.txt',collapse = '')
fwrite(SNP_output,tmp_output,sep="\t",col.names = F)


cat('\n ################# Output:  #################\n')

cat('\n The out of SNPs in the Gene is in the following directory:\n',tmp_output)


cat('\n')
cat('\n ################# Done  #################\n\n')

cat('\n')