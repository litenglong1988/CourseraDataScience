complete<-function(directory, id = 1:332){
    nobs<-vector()
    for(i in id){
        x<-read.csv(paste(getwd(),directory,dir(paste(getwd(),directory,sep="/"))[i],sep="/"))
        Comp<-complete.cases(x)
        nobs[i]<-sum(Comp)
    }
    data.frame(id=id,nobs=nobs[id])

}

