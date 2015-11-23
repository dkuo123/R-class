setwd("~/R/R-class/week3/rprog_data_ProgAssignment3-data")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)
fn <- names(outcome)
#make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset)
fn[11]
outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])