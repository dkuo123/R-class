library(datasets)
data(iris)
?iris
iris
mean(iris$Sepal.Length)
mean(iris)
which(iris$Species == 'virginica')
iris[which(iris$Species == 'virginica')]
iris[which(iris$Species == 'virginica'), 'Sepal.Length']
#what is the mean of 'Sepal.Length' for the species virginica? (Please only enter the numeric result and nothing else.)
mean(iris[which(iris$Species == 'virginica'), 'Sepal.Length'])
summary(iris)
names(iris)
iris[1,Species]
iris[1,'Species']
mean(iris)
colMeans(iris)
#what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
colMeans(iris[,1:4])
apply(iris[,1:4],2,mean)
library(datasets)
data(mtcars)
?mtcars
head(mtcars)
#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
tapply(mtcars$mpg, mtcars$cyl, mean)
sapply(mtcars, cyl, mean)
lapply(mtcars, mean)
split(mtcars, mtcars$cyl)
t <- tapply(mtcars$hp, mtcars$cyl, mean)