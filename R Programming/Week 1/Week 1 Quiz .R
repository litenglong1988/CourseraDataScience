setwd("D:\\Ñ§Ï°\\coursera-ÍøÂç¿Î³Ì\\R Programming\\Week 1\\exercise")
x<-read.csv("hw1_data.csv");
names(x)
y<-read.csv("hw1_data.csv",nrows=2);y
print(y)
str(x)
attributes(x)
print(x[152:153,])
x[47,"Ozone"]
table(is.na(x$Ozone))
table(complete.cases(x$Ozone))
mean(x$Ozone,na.rm=TRUE)
good<-complete.cases(x$Ozone, x$Temp);good
y<-x[good,];y
z<-y[y$Ozone>31 & y$Temp>90,];z
mean(z$Solar.R)

z<-x[x$Month==6,];z
mean(z$Temp)
z<-x[x$Month==5,]
max(z$Ozone,na.rm=TRUE)

colnames(x)







