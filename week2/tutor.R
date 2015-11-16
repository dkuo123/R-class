dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")
list.files("diet_data")
andy <- read.csv("diet_data/Andy.csv")
head(andy)
length(andy$Day)
dim(andy)
str(andy)
summary(andy)
names(andy)
andy[1, "Weight"]


system.time(andy[which(andy$Day == 30), "Weight"])
system.time(andy[which(andy[,"Day"] == 30), "Weight"])
system.time(subset(andy$Weight, andy$Day==30))

files <- list.files("diet_data")
files
files_full <- list.files("diet_data", full.names=TRUE)
files_full

andy_david <- rbind(andy, read.csv(files_full[2]))
head(andy_david)
tail(andy_david)

day_25 <- andy_david[which(andy_david$Day == 25), ]
day_25


dat <- data.frame()
for (i in 1:5) {
  dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)
?median
median(dat$Weight)
median(dat$Weight, na.rm=TRUE)


weightmedian <- function(directory, day)  {
  files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
  dat <- data.frame()                             #creates an empty data frame
  for (i in 1:length(files_list)) {                                
    #loops through the files, rbinding them together 
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  dat_subset <- dat[which(dat[, "Day"] == day),]  #subsets the rows that match the 'day' argument
  median(dat_subset[, "Weight"], na.rm=TRUE)      #identifies the median weight 
  #while stripping out the NAs
}

weightmedian(directory = "diet_data", day = 20)
weightmedian("diet_data", 4)
weightmedian("diet_data", 17)


summary(files_full)
tmp <- vector(mode = "list", length = length(files_full))
summary(tmp)

for (i in seq_along(files_full)) {
  tmp[[i]] <- read.csv(files_full[[i]])
}
str(tmp)
output <- do.call(rbind, tmp) ##rbind a list of data frame into ONE data frame.
str(output)

tmp2 <- lapply(files_full, read.csv)
str(tmp2)

x = list(a=matrix(1:4,2,2), b=matrix(1:6,3,2))
x
lapply(x, function(v) {v[,1]}) # unnamed function, like lambda, pull out first column of v

sapply(x, function(v) {v[,1]}) # return a list of vector. same as lapply here
x <-list(a = 1:4, b = rnorm(10), c = rnorm(20,1))
lapply(x,mean) # return list of vector, each has one element
sapply(x, mean) # collapse list of vector(with only one element) into one vector


