
#connect to internet 

options(download.file.method="wget")

#install.packages("e1071")
#install.packages("mlbench")
#install.packages("class")
#install.packages("RANN")
library(e1071)
library(class)
library(RANN)
#library(mlbench)

#set file path
setwd("/Users/naru/Documents/R_workshop/UTRClassify/data")

# training data
traningData <- read.csv("traningData5UTR.csv")
head(trainingData)

# teasting data 

#testingData <- read.csv("OC5UTRWithoutDupliacates.csv")[401:450,]
testingData <- read.csv("HK5UTRWithoutDupliacates.csv")[401:1000,]
testingData
#testingData["CLASS"] <- "OncoGene"
# removing UTR IDs from dataFrame
testingData <- testingData[,!(names(testingData) %in% c("X","UTR_ID"))]

model <- naiveBayes(CLASS ~ ., data = trainingData)
model
predict(model, testingData)
predict(model, testingData, type = "raw")



pred <- predict(model, testingData)
table(pred, testingData$CLASS)

## using laplace smoothing:
model <- naiveBayes(CLASS ~ ., data = testingData, laplace = 3)
pred <- predict(model, testingData[,-1])
table(pred, testingData$CLASS)


