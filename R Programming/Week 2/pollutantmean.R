pollutantmean<-function(directory, pollutant, id = 1:332){
    x<-data.frame()
    for(i in id){
        y<-read.csv(paste(getwd(),directory,dir(paste(getwd(),directory,sep="/"))[i],sep="/"))
        x<-rbind(x,y)
    }
    colnames(x)<-c("Date","sulfate", "nitrate", "ID")
    round(mean(x[,pollutant],na.rm=TRUE),digits =3)
}