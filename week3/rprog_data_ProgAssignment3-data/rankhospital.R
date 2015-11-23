is.whole <- function(x) {
  is.numeric(x) && floor(x) == x
}

rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  x <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # state must be in sample file
  h_idx <- grep(state, x[,7])
  if (length(h_idx) == 0)
    stop("invalid state")
  
  #outcome must be in c("heart attack", "heart failure", "pneumonia")
  c_idx <- grep (outcome, c("heart attack", "heart failure", "pneumonia"))
  if (length(c_idx) == 0)
    stop("invalid outcome")
  
  
  col = c(11, 17, 23)
  h <- x[h_idx, c(2,col[c_idx])]
  colnames(h) <- c("name", "rate")
  h$rate <- suppressWarnings(as.numeric(h$rate)) 
  h <- h[with(h, order(as.numeric(rate),name)),]
  if (num == "best") {
    h[1,1]
  }
  else if (num == "worst") {
    NAs = which(is.na(h$rate))
    h[NAs[1]-1,1]
  }
  else if (is.whole(num)) {
    h[num,1]
  }
  else {
    stop("invalid num")
  }   
  
 
}