## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 2.Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
## to make a plot answering this question.
total.PM2.5.emission<-vector()
Year<-as.integer(c(1999,2002,2005,2008))
for(i in 1:4){
        total.PM2.5.emission[i]<-sum(subset(NEI,fips == 24510 & year==Year[i],select=Emissions))
}
png("plot2.png")
plot(Year,total.PM2.5.emission,type="l",ylab="total PM2.5 emission",main="Baltimore City")
dev.off()
