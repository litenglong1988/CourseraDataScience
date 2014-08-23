setwd("C:/Users/ltl/Desktop/R_workspace")
##Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile="Q1.csv")
Q1<-read.csv("Q1.csv",header=TRUE)
agricultureLogical<- Q1$ACR == 3 & Q1$AGS == 6
which(agricultureLogical)[1:3]

##Q2
install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile="Q2.jpg",mode="wb")
Q2<-readJPEG("Q2.jpg", native = TRUE)
quantile(Q2,probs=c(0.3,0.8))

##Q3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "GDP.csv")
download.file(url, f)
Q3gdp<-read.csv(f, skip = 4, nrows = 215)
Q3gdp <- Q3gdp[Q3gdp$X != "",]
colnames(Q3gdp)<-c("CountryCode", "rankingGDP", "X.2", "Long.Name", "gdp","X.5","X.6","X.7","X.8","X.9")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
Q3ed <- read.csv(f)
Q3 <- merge(Q3gdp, Q3ed, all = TRUE, by = c("CountryCode"))
sum(!is.na(unique(Q3$rankingGDP)))
Q3_sort<-Q3[order(Q3$rankingGDP,decreasing=TRUE),]
Q3_sort[13,]


##Q4
tapply(Q3$rankingGDP,Q3$Income.Group,mean,na.rm=TRUE)

##Q5
breaks <- quantile(Q3$rankingGDP, probs = seq(0, 1, 0.2), na.rm = TRUE)
table(cut(Q3$rankingGDP,breaks=breaks),Q3$Income.Group)[,"Lower middle income"]
