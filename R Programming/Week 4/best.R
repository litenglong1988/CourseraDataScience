best<-function(state, outcome){
    meas<- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    if(sum(meas$State==state)==0){
        stop("invalid state")
    } else if(outcome!="heart attack" &
                  outcome!="heart failure" &
                  outcome!="pneumonia" ){
        stop("invalid outcome")
    } else{
        a<-if(outcome=="heart attack"){
            11
        } else if(outcome=="heart failure"){
            17
        } else if(outcome=="pneumonia"){
            23
        }
        meas<-meas[meas$State==state,]
        meas<-meas[!is.na(as.numeric(meas[,a])),]
        b<-which.min(meas[,a])
        meas[b,2]
    }
}