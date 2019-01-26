############################################################
#           MSCS 6520 - Business Analytics                 #
#           Module 2 - Exploratory Data Analysis    			 #
#                                                  				 #
#                                                          #
#                  	Author: Jean Azevedo                   #
#                   Marquette University                   #
############################################################

############################################################
# Disclaimer: this script is used to produce the examples  #
#  presented during the course  Business Analytics.        #
#   The author is not responsible in any way               #
#  for any problem encountered during this code execution. #
############################################################

############################################################
####                 Iris Example                       ####
############################################################
# Set your directory to the folder where you have downloaded the dataset

# To clean up the memory of your current R session run the following line

rm(list=ls(all=TRUE))

# Let's load our dataset

data=read.csv('data/iris.csv', header = T,sep=',')

# Now let's have a look at our variables and see some summary statistics

head(data)
nrow(data)
str(data) # The str() function shows the structure of your dataset and details the type of variables that it contains
summary(data) # The summary() function provides for each variable in your dataset the minimum, mean, maximum and quartiles


# Plot histograms for the variables 

hist(data$sepal.length) # Produce a histogram

hist(data$sepal.width) # Produce a histogram

hist(data$petal.length) # Produce a histogram

hist(data$petal.width) # Produce a histogram

#Using a different graph library

install.packages("ggplot2")

library(ggplot2)

ggplot(data = data,  aes(data$sepal.length)) + geom_histogram()

# Box Plots

plot(data$iris, data$sepal.length, main = "Sepal Lenght", xlab = "Iris", ylab ="Sepal Length")

plot(data$iris, data$sepal.width, main = "Sepal Width", xlab = "Iris", ylab ="Sepal Width")

plot(data$iris, data$petal.length, main = "Petal Length", xlab = "Iris", ylab ="Pedal Length")

plot(data$iris, data$petal.width, main = "Petal Width", xlab = "Iris", ylab ="Pedal Width")

# Scatter Plots

plot(data$sepal.length, data$sepal.width, 
     main = "Sepal Lenght v Width", 
     xlab = "Sepal length",
     ylab ="Sepal Width")

ggplot(data=data, aes(data$sepal.length,data$sepal.width)) + geom_point() 


install.packages("scatterplot3d")

library(scatterplot3d)

attach(data)

scatterplot3d(data$sepal.length,data$sepal.width,data$petal.length, main="3D Scatterplot")

