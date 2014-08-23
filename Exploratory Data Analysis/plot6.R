## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 6.Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(plyr)

NEI.twocitys <- subset(NEI, fips %in%c("06037","24510") & year %in% c( 1999, 2002, 2005, 2008))
vehicles<-as.data.frame(SCC[grep("vehicles", SCC$SCC.Level.Two, ignore.case = T), 1])
colnames(vehicles)<-"SCC"

twocitys.vehicles<-merge(vehicles, NEI.twocitys,by="SCC")


plotdata<-ddply(twocitys.vehicles, .(fips,year), function(x) sum(x$Emission))
colnames(plotdata)<-c("fips","year","Emission")

for(i in 1:length(plotdata$fips)){
        if(plotdata$fips[i] == "06037") plotdata$city[i] <- "California" 
        else if(plotdata$fips[i] == "24510") plotdata$city[i] <- "Baltimore" 
}
plotdata<-transform(plotdata, city=factor(city))



qplot(year,Emission,data=plotdata,facets=.~city,col=city,geom=c("point","line")) +
        xlab("Year") + ylab("Total Emissions") +  ggtitle("Compare Emissions of vehicles from two citys")

dev.copy(png, file = "plot6.png") 
dev.off()
