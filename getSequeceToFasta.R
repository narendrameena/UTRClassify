
# connection to internet
options(download.file.method="wget")

# load bimart library 
library(biomaRt)

listMarts()

ensembl=useMart("ensembl") 

listDatasets(ensembl)

ensembl = useDataset("hsapiens_gene_ensembl",mart=ensembl) 
#mart <- useMart("ensembl",dataset="hsapiens_gene_ensembl",archive=TRUE)

dataTable <- read.csv("list_F03C99E4C58E1430741297004.txt",sep="\t")
oralCancerGeneList <- read.csv("VnmNMvT4.csv",sep=",")
head(oralCancerGeneList)
length(oralCancerGeneList$msonormal_links._text)
oralCancerGeneList$msonormal_links._text

#conversion of hgnc Ids to entraze ids 
#ensembl=useMart("ensembl_mart_51",dataset="hsapiens_gene_ensembl",)
entrez<-getBM(attributes=c("hgnc_symbol","entrezgene"),filters="hgnc_symbol",values=oralCancerGeneList$msonormal_links._text,mart=ensembl)
head(entrez)
length(entrez$hgnc_symbol)
# class(GeneList) = factor




#getting gens's seqnences 5 UTR in fasta
cancerGene5UTR = getSequence(id=entrez$entrezgene,type="entrezgene",seqType="5utr", mart=ensembl)

exportFASTA(cancerGene5UTR,file="OralCancerGenes5UTR.fasta")

# geeting genes's 3UTR in fasta

cancerGene3UTR = getSequence(id=entrez$entrezgene,type="entrezgene",seqType="3utr", mart=ensembl)

exportFASTA(cancerGene3UTR,file="OralCancerGenes3UTR.fasta")

# geeting genes's CDNA part in fasta

cancerGeneCDNA = getSequence(id=entrez$entrezgene,type="entrezgene",seqType="cdna", mart=ensembl)

exportFASTA(cancerGeneCDNA,file="OralCancerGenesCDNA.fasta")


# geeting genes's Coding part in fasta

cancerGeneCoding = getSequence(id=entrez$entrezgene,type="entrezgene",seqType="coding", mart=ensembl)

exportFASTA(cancerGeneCoding,file="OralCancerGenesCoding.fasta")



