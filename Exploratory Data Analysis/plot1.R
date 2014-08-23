setwd("C:/Users/dell/Desktop/coursera/4_Exploratory Data Analysis/exercise")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="./project2.zip")
unzip("./project2.zip")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all 
## sources for each of the years 1999, 2002, 2005, and 2008.
total.PM2.5.emission<-vector()
Year<-as.integer(c(1999,2002,2005,2008))
for(i in 1:4){
        total.PM2.5.emission[i]<-sum(subset(NEI,year==Year[i],select=Emissions))
}
png("plot1.png")
plot(Year,total.PM2.5.emission,type="l",ylab="total PM2.5 emission")
dev.off()
