library(rpart)
library(rpart.plot)
library(caret)
mower.df <- read.csv("data/RidingMowers.csv")

class.tree <- rpart(Ownership ~ ., data = mower.df, method = "class")
prp(class.tree, type = 1, extra = 1, split.font = 1, varlen = -10)

bank.df <- read.csv("data/UniversalBank.csv")
bank.df <- bank.df[, -c(1,5)] #Drop ID and Zip Code
bank.df <- bank.df %>% mutate(PersonalLoan = factor(PersonalLoan))
head(bank.df)

#partition
set.seed(1)
train.index <- sample(c(1:dim(bank.df)[1]), dim(bank.df)[1]*0.6)
bank.train <- bank.df[train.index, ]
bank.valid <- bank.df[-train.index, ] 

#classification tree
default.ct <- rpart(PersonalLoan ~ ., data = bank.train, method = "class")
prp(default.ct, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10)

deeper.ct <- rpart(PersonalLoan ~ ., data = bank.train, method = "class", cp = 0, minsplit = 1)
#size of the tree
length(deeper.ct$frame$var[deeper.ct$frame$var == "<leaf>"])
prp(deeper.ct, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10, box.col=ifelse(deeper.ct$frame$var =="<leaf>", 'gray', 'white'))

#evaluation
default.ct.point.pred.train <- predict(default.ct, bank.train,type = "class")
confusionMatrix(default.ct.point.pred.train, bank.train$PersonalLoan)

default.ct.point.pred.valid <- predict(default.ct, bank.valid, type = "class")
confusionMatrix(default.ct.point.pred.valid, bank.valid$PersonalLoan)

deeper.ct.point.pred.train <- predict(deeper.ct, bank.train,type = "class")
confusionMatrix(deeper.ct.point.pred.train, bank.train$PersonalLoan)

deeper.ct.point.pred.valid <- predict(deeper.ct, bank.valid, type = "class")
confusionMatrix(deeper.ct.point.pred.valid, bank.valid$PersonalLoan)

