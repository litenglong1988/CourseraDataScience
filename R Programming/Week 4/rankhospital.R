rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
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
        meas[,a]<-as.numeric(meas[,a])
        meas<-meas[!is.na(meas[,a]),]
        b<-order(meas[,a],meas[,2])
        if(num=="best") meas[b[1],2]
        else if(num=="worst") meas[b[length(b)],2]
        else if(num>length(b)) print("NA")
        else {
            num <- as.numeric(num)
            meas[b[num],2]
        }
    }
}
