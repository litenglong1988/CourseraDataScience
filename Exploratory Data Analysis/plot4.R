## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 4.Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

library(ggplot2)
library(plyr)




SCC.coal<-SCC[grepl("comb", SCC$EI.Sector, ignore.case=TRUE) & 
                      grepl("coal", SCC$EI.Sector, ignore.case=TRUE),] 

NEI.coal<-subset(NEI,NEI$SCC %in% SCC.coal$SCC)
Emission<-tapply(NEI.coal$Emission,NEI.coal$year,sum)

qplot(unique(NEI.coal$year),Emission)+geom_point(col=unique(NEI.coal$year),size=4)+
        geom_line(col=unique(NEI.coal$year),size=1.5)+xlab("Year")+
        ylab("Emissions from coal combustion-related sources")+ggtitle("United States")

dev.copy(png, file = "plot4.png") 
dev.off()
