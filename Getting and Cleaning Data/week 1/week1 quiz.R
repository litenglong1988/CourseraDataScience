##Quiz 1
setwd("C:/Users/ltl/Desktop/R_workspace")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile="./Q1.csv")
Q1<-read.csv("Q1.csv",header=TRUE)
table(Q1$VAL)
table(Q1$FES)

##Quiz 3
install.packages("xlsx")
library(xlsx)
COL<-7:15
ROW<-18:23
dat<-read.xlsx("getdata_data_DATA.gov_NGAP.xlsx",sheetIndex=1,colIndex=COL,rowIndex=ROW)
sum(dat$Zip*dat$Ext,na.rm=T) 

##Quiz 4
install.packages("XML")
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse( fileUrl, useInternal=TRUE )
rootNode<-xmlRoot(doc)
zipcode<-xpathSApply(rootNode,"//zipcode",xmlValue)
table(zipcode)["21231"]

##Quiz 5
install.packages("data.table")
library(data.table)
DT<-fread("getdata_data_ss06pid.csv")
system.time(DT[,mean(pwgtp15),by=SEX])
system.time( {
    mean(DT[DT$SEX==1,]$pwgtp15);  mean(DT[DT$SEX==2,]$pwgtp15)
} )
system.time({
    mean(DT$pwgtp15,by=DT$SEX)
    })
system.time( {
    sapply(split(DT$pwgtp15,DT$SEX),mean)
})
