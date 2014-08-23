## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 5.How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)
library(plyr)

NEI.Baltimore<-subset(NEI, fips =="24510" & year %in% c( 1999, 2002, 2005, 2008))
vehicles<-as.data.frame(SCC[grep("vehicles", SCC$SCC.Level.Two, ignore.case = T), 1])
colnames(vehicles)<-"SCC"

Baltimore.vehicles<-merge(vehicles, NEI.Baltimore,by="SCC")
Baltimore.vehicles<-transform(Baltimore.vehicles, year=factor(year))

plotdata<-ddply(Baltimore.vehicles, .(year), function(x) sum(x$Emission))
colnames(plotdata)<-c("year","Emission")


ggplot(data = plotdata,aes(x=year , y=Emission, group=1)) + geom_point(size=2) + geom_line(size=1,col=1)+
        xlab("Year") + ylab("Total Emissions")+ggtitle("Baltimore Emissions of vehicles")


dev.copy(png, file = "plot5.png") 
dev.off()
