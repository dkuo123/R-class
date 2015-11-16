corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        x <-complete(directory)
        y <-x[x$nobs > threshold,]
        v <- c()
        for(f in y$id) {
          fname <- sprintf("%s/%03d.csv", directory, f)
          x <- read.csv(fname)
          c <- complete.cases(x)         
          p <- x[c,]
          v <- c(v,cor(p$sulfate, p$nitrate))
        }
        v
}

