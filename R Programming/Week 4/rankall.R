rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    meas<- read.csv("outcome-of-care-measures.csv",colClasses = "character")
    if(outcome!="heart attack" &
       outcome!="heart failure" &
       outcome!="pneumonia" )
        {
        stop("invalid outcome")
    } else{
        a<-if(outcome=="heart attack"){
            11
        } else if(outcome=="heart failure"){
            17
        } else if(outcome=="pneumonia"){
            23
        }
        states<-unique(meas$State)
        disp<-data.frame()
        for(i in 1:length(states)){
            meas.state<-meas[meas$State==states[i],]
            meas.state[,a]<-as.numeric(meas.state[,a])
            meas.state<-meas.state[!is.na(meas.state[,a]),]
            b<-order(meas.state[,a],meas.state[,2])
            if(num=="best") hosp<-meas.state[b[1],2]
            else if(num=="worst") hosp<-meas.state[b[length(b)],2]
            else if(num>length(b)) hosp<-"<NA>"
            else {
                num <- as.numeric(num)
                hosp<-meas.state[b[num],2]
            }
            disp[i,1]<-hosp
            disp[i,2]<-states[i]
        }
    }
    d<-order(disp[,2],disp[,1])
    disp<-disp[d,]
    colnames(disp)<-c("hospital","state")
    rownames(disp)<-states
    disp
}