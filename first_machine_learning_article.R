library(readr)
library(dplyr)
library(randomForest)
library(caret)

set.seed(1234)

customer_data <- read_csv("repeat_customer.csv")
customer_data$gender <- as.factor(customer_data$gender)
customer_data$returned <- as.factor(customer_data$returned)

glimpse(customer_data)
dim(customer_data)

table(customer_data$returned)

train <- customer_data[1:200, ]
test <- customer_data[201:340, ]


rf_model <- randomForest(returned ~ ., 
                         data = train)

test$predicted <- predict(rf_model, test)

confusionMatrix(test$predicted, test$returned)
