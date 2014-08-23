## setwd("C:\\Users\\dell\\Desktop\\coursera\\5_Reproducible Research\\exercise\\Peer Assessment 1")

## download and unzip the file 
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", destfile="repdata_data_activity.zip")
unzip("repdata_data_activity.zip")

# Loading and preprocessing the data
activity <- read.csv("activity.csv", header = TRUE)
activity <- transform(activity, date=as.character(date))
activity_rm_na <- na.omit(activity)

# What is mean total number of steps taken per day?
## 1.Make a histogram of the total number of steps taken each day
total.activity <- aggregate(activity_rm_na$steps, list(activity_rm_na$date), sum)
hist(total.activity$x, col="red", xlab="number of steps", ylab="total number of steps")

## 2.Calculate and report the mean and median total number of steps taken per day
Mean <- mea(activity_rm_na$steps);Mean
Median <- (activity_rm_na$steps);Median

# What is the average daily activity pattern?
## 1.Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) 
## and the average number of steps taken, averaged across all days (y-axis)
mean.activity <- aggregate(activity_rm_na$steps, list(activity_rm_na$interval), mean)
colnames(mean.activity) <- c("interval", "mean_steps")
library(ggplot2)
ggplot(mean.activity, aes(interval, mean_steps)) + geom_line(col="red", lwd=2) + xlab("5-minute interval") + 
    ylab("average number of steps taken")

## 2.Which 5-minute interval, on average across all the days in the dataset,
## contains the maximum number of steps?
Interval <- mean.activity[which.max(mean.activity$mean_steps),1]

## Imputing missing values
## 1.Calculate and report the total number of missing values in the dataset
na_nrow <- nrow(activity) - nrow(activity_rm_na)

## 2.Devise a strategy for filling in all of the missing values in the dataset. 
## The strategy does not need to be sophisticated. For example, you could use 
## the mean/median for that day, or the mean for that 5-minute interval, etc.
## 3.Create a new dataset that is equal to the original dataset but with the missing data filled in.
new.activity <- activity
for(i in 1 : nrow(new.activity)){
    if(is.na(new.activity[i,1])){
        new.activity[i,1] <- mean.activity[which(mean.activity$interval==new.activity[i,"interval"]),2]
    }
}


## 4.Make a histogram of the total number of steps taken each day and Calculate and report
## the mean and median total number of steps taken per day. Do these values differ from the 
## estimates from the first part of the assignment? What is the impact of imputing missing 
## data on the estimates of the total daily number of steps?
total.new.activity <- aggregate(new.activity$steps, list(new.activity$date), sum)
hist(total.new.activity$x, col="red", xlab="number of steps", ylab="total number of steps")

mean(new.activity$steps)
median(new.activity$steps)


## Are there differences in activity patterns between weekdays and weekends?
## 1.Create a new factor variable in the dataset with two levels – “weekday” and
## “weekend” indicating whether a given date is a weekday or weekend day.
new.activity <- transform(new.activity, date = as.Date(date))
new.activity$weekdays <- weekdays(new.activity$date)
new.activity$week <- character(nrow(new.activity))
for(i in 1: length(new.activity$weekdays)){
    if(new.activity$weekdays[i] %in% c("Saturday","Sunday")) {
        new.activity$week[i] <- "weekend"
    } else {
        new.activity$week[i] <- "weekday"
    }
}
new.activity$week <- as.factor(new.activity$week)

## 2.Make a panel plot containing a time series plot (i.e. type = "l") of
## the 5-minute interval (x-axis) and the average number of steps taken, 
## averaged across all weekday days or weekend days (y-axis). The plot should 
## look something like the following, which was creating using simulated data
library(plyr)
options(digits=4)
plotdata <- ddply(new.activity, .(interval, week), function(x) {mean(x$steps)})
ggplot(plotdata, aes(interval, V1)) + geom_line(col="blue", lwd=0.5) + 
    xlab("interval") + ylab("Number of steps") + facet_grid(week~.)

setwd("C:/Users/dell/Desktop/coursera/5_Reproducible Research/exercise/Peer Assessment 1")
library(knitr)
knit2html("PA1_template.Rmd")
