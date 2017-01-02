# Getting and Cleaning Data course project

# load the dplyr package 
suppressPackageStartupMessages(library(dplyr))

# Load raw data files into data frames
features <- read.table("./data/features.txt", header=FALSE, quote="")
activities <- read.table("./data/activity_labels.txt", header=FALSE, quote="")
# the test data set
test_data <- read.table("./data/test/X_test.txt", header=FALSE, quote="")
test_labels <- read.table("./data/test/y_test.txt", header=FALSE, quote="")
test_subjects <- read.table("./data/test/subject_test.txt", header=FALSE, quote="")
# the training data set
train_data <- read.table("./data/train/X_train.txt", header=FALSE, quote="")
train_labels <- read.table("./data/train/y_train.txt", header=FALSE, quote="")
train_subjects <- read.table("./data/train/subject_train.txt", header=FALSE, quote="")

# add column names to test and training data sets based on features data frame
colnames(test_data) <- features[,2]
colnames(train_data) <- features[,2]

# add new activity and subject columns to both data sets
test_data$activity <- test_labels$V1
train_data$activity <- train_labels$V1
test_data$subject <- test_subjects$V1 
train_data$subject <- train_subjects$V1

# rbind fails due to duplicate column names
# before using rbind, first remove duplicate columns
test_data <- test_data[!duplicated(as.list(test_data))]
train_data <- train_data[!duplicated(as.list(train_data))]
# now use rbind to combine test and train data sets into a single data frame
data <- rbind(test_data, train_data)

# replace activity values to make them more descriptive
# based on values in the activities data frame
data$activity[data$activity == 1] <- "WALKING"
data$activity[data$activity == 2] <- "WALKING_UPSTAIRS"
data$activity[data$activity == 3] <- "WALKING_DOWNSTAIRS"
data$activity[data$activity == 4] <- "SITTING"
data$activity[data$activity == 5] <- "STANDING"
data$activity[data$activity == 6] <- "LAYING"

# remove the parentheses from column names 
n <- lapply(names(data), function(x) {gsub("\\(", "", x)})
n <- lapply(n, function(x) {gsub("\\)", "", x)})
names(data) <- n

# create a data frame tbl using the dplyr tbl_df function
data <- tbl_df(data)

# take subset of the data that only contains mean and sd variables
data <- select(data, subject, activity, contains("mean"), contains("std"))

# group data by subject, activity 
gdata <- group_by(data, subject, activity)
# calculate the mean for each variable in the dataset 
stats <- summarize_each(gdata, funs = c(AVG="mean"), vars = -c(activity, subject))
# convert stats data frame to dplyr tbl_df 
stats <- tbl_df(stats)

# remove unneeded objects 
rm(n, gdata, activities, features, test_data, test_labels, test_subjects)
rm(train_data, train_labels, train_subjects)

# write output datasets to csv files 
write.csv(data, file="data.csv")
write.csv(stats, file="stats.csv")











