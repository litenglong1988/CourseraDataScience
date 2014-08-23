## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
## plot answer this question.


library(ggplot2)
library(plyr)
NEI<-subset(NEI,year %in% c(1999,2002,2005,2008) & fips == "24510")
BaltimoreCity.Emission<-ddply(.data=NEI,.variables=.(year,type),.fun=function(x) sum(x$Emissions))
BaltimoreCity.Emission<-transform(BaltimoreCity.Emission,type=factor(type))


png(file="plot3.png",width = 480*4, height = 480)
qplot(year,V1,data=BaltimoreCity.Emission,facets=.~type,col=type,geom=c("point","line"))+
ggtitle("Baltimore City's total Emissions by type")+
xlab("Year")+
ylab("Baltimore City's total Emissions")
dev.off()
