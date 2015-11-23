is.whole <- function(x) {
  is.numeric(x) && floor(x) == x
}

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  x <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  #outcome must be in c("heart attack", "heart failure", "pneumonia")
  c_idx <- grep (outcome, c("heart attack", "heart failure", "pneumonia"))
  if (length(c_idx) == 0)
    stop("invalid outcome")
  
  
  col = c(11, 17, 23)
  h <- x[, c(2,7, col[c_idx])]
  colnames(h) <- c("hospital", "state", "rate")
  h$rate <- suppressWarnings(as.numeric(h$rate)) 
  h <- h[with(h, order(state, as.numeric(rate),hospital)),]
  s <- split(h, h$state)
  getHS <- function(HS, num) {
    if (num == "best") {
      HS[1,1:2]
    }
    else if (num == "worst") {    
      NAs = which(is.na(HS$rate))
      if (length(NAs) == 0)
        tail(HS,1)[1:2]
      else
        HS[NAs[1]-1,1:2]
    }
    else if (is.whole(num)) {
      if (num > nrow(HS)) 
        c(NA, HS[1,2])
      else
        HS[num,1:2]
    }
    else {
      stop("invalid num")
    }   
  }
  k <- lapply(s, getHS, num)
  m <-do.call(rbind.data.frame, k)
  #m <-matrix(k,ncol=2, byrow=T)
  #dimnames(m) = list(m[,2], c("hospital", "state"))
  m
}