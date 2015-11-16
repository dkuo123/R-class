pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
    data <-vector("numeric")    
    for(fid in id) {
      ##fname <- paste(directory, "/", fid, ".csv", sep = "")
      fname <- sprintf("%s/%03d.csv", "specdata", fid)
      x <-read.csv(fname)
      #data <- c(data, x$pollutant)    # can't use x$pollute
      data <-c(data, x[,pollutant])
    }
          
    ##mean(data[!is.na(data)])
    mean(data, na.rm = TRUE)
}

