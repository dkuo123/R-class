complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  df = data.frame("id" = integer(), "nobs" = integer())
  for(f in id) {
    fname <- sprintf("%s/%03d.csv", directory, f)
    x <- read.csv(fname)
    y <- complete.cases(x)
    ##df[nrow(df)+1,] = c(f, sum(!is.na(y)&y))
    df[nrow(df)+1,] = c(f, sum(y, na.rm = TRUE))
  }
  df
}
