housing.df <- read.csv("data/WestRoxbury.csv", header = TRUE)
dim(housing.df)
head(housing.df)

# Practice extracting subsets of the data
housing.df[1:10, 1] #10 rows of only the first column
housing.df[1:10, ] #10 rows of all columns
housing.df[5, c(2,4,8)] # show the fifth row of columns 2, 4, and 8
housing.df[5, 1:10] # show the fifth row of the first 10 columns
housing.df[, 2]# show the entire 2nd column
housing.df$TAX # show the entire 2nd column by indexing view column name
housing.df$TAX[1:10] # show the first 10 rows of the 2nd column indexing like before
mean(housing.df$TOTAL.VALUE) # find the mean of the first column
summary(housing.df) # show a statisical summary of all columns

# random sample
s <- sample(row.names(housing.df), 5)
housing.df[s,] # select 5 random indices of the set

# over sample houses with over 10 rooms
s <- sample(row.names(housing.df), 5, prob = ifelse(housing.df$ROOMS > 10, 0.9, 0.01))
housing.df[s,]

#use model.matrix() to convert categorical variables into dummy variables
xtotal <- model.matrix(~ 0 + BEDROOMS + REMODEL, data = housing.df)
xtotal <- as.data.frame(xtotal)
t(t(names(xtotal)))
head(xtotal)

#Deal with some missing values by inserting the median
rows.to.missing <- sample(row.names(housing.df),10)
housing.df[rows.to.missing,]$BEDROOMS <- NA # set the sample of records to have NA bedrooms
summary(housing.df$BEDROOMS) # we have 10 NA's in this set and a median of 3

housing.df[rows.to.missing,]$BEDROOMS <- median(housing.df$BEDROOMS, na.rm = TRUE) #replace with the median and remove NA's
summary(housing.df$BEDROOMS) # 0 NA's after replacement
