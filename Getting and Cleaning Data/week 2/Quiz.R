setwd("C:\\Users\\ltl\\Desktop\\R_workspace")


install.packages("httr")
install.packages("jsonlite")
library(httr)
require(httpuv)
require(jsonlite)


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")


# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("quiz2", "ddb0d599de51ccd02f4b", secret="6af1109f6ecf442d292425087d49bb13d9bbe9c8")


# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)


# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
output <- content(req)
list(output[[4]]$name, output[[4]]$created_at)






acs<-read.csv("getdata_data_ss06pid.csv",header=TRUE)
install.packages("sqldf")
library(sqldf)
sqldf("select pwgtp1 from acs where AGEP < 50") 
sqldf("select * from acs where AGEP < 50 and pwgtp1") 
sqldf("select distinct AGEP from acs")== unique(acs$AGEP)
unique(acs$AGEP)


con<-url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode<-readLines(con)
close(con)
nchar(htmlCode)[c(10,20,30,100)]



url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url, n=10)
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header=FALSE, skip=4, col.names=colNames)
d <- d[, grep("^[^filler]", names(d))]
sum(d[, 4])
