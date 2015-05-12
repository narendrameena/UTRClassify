# internet connection 

options(download.file.method="wget")
#install.packages("lsa")
# lloding cosine fucntion library in session 
library(lsa)
library(dplyr)


uniqeIds <-function(d){
  #local variables
  a = list() 
  b = list()
  # loop
  for (i in 1:length(d$Var1)) {
    var1 = as.character(d$Var1[i])
    var2 = as.character(d$Var2[i])
    # repitative Ids
    if(!is.element(var1, a) & !is.element(var1, b) & (var1!=var2)){
      a[length(a)+1] = var1
    }
    # all ids with repetative Ids
    if(!is.element(var2, b)){
      b[length(b)+1] = var2
      
    }
  }
  # return Ids without duplication 
  return( b[!(b %in% a)] )
}

library(xlsx)
# reading function
setwd("/Users/naru/Documents/R_workshop/UTRClassify/data")
houseKeepingGenes <- read.table("HK5UTR.xls", sep="\t",header=TRUE)
head(houseKeepingGenes)
#converting as matrix 
data = as.matrix(houseKeepingGenes)
data
#normlizing data 
normlizeData<- t(apply(houseKeepingGenes[,][3:length(file[1,])], 1, function(x)(x-min(x))/(max(x)-min(x))))

#name rows as UTRids
rownames(normlizeData) <-houseKeepingGenes[,1]
#transform row into columes for cosine calculation 
transform_matrix<-t(normlizeData)

#give columns name using UTR ids 
#colnames(transform_matrix) <- file[,1]
cosineData <- cosine(transform_matrix)

out <- data.frame(X1 = rownames(cosineData)[-1],X2 = head(colnames(cosineData), -1),Value = cosineData[row(cosineData) == col(cosineData) + 1])
out
# converting matrix into dataframe 
cosineData <-as.data.frame(as.table(cosineData))
cosineData



filterCosineDataSameId<-filter(cosineData, Var1 == Var2 & Freq == 1.0000000)
filterCosineDataSameId
filterCosineDataDiffrentId<-filter(cosineData, Var1 != Var2 & Freq == 1.0000000)
filterCosineDataDiffrentId
filterCosineDataWithSameFreq<-filter(cosineData,  Freq == 1.0000000)
d <-filterCosineDataWithSameFreq

result<-uniqeIds(d)
result




