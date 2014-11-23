# DS Track: Getting and Cleaning Data
# Project work by Jun Xie
# Date submitted: 2014-11-22
# The purpose of this project is to demonstrate the ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

# Create one R script called run_analysis.R that does the following. 
# 1.  Merges the training and the test sets to create one data set.
# 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.  Uses descriptive activity names to name the activities in the data set
# 4.  Appropriately labels the data set with descriptive variable names. 
# 5.  From the data set in step 4, creates a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.


library(dplyr)
library(tidyr)

# Read in label and feature data

labels_file <- "./data/activity_labels.txt"
labels <- read.table(labels_file)
colnames(labels) <- c("activity_label", "activity")


features_file <- "./data/features.txt"
features <- read.table(features_file)
# feature_names <- features[, 2]

# Read in train data set
subject_train_file <- "./data/train/subject_train.txt"
subject_train <- read.table(subject_train_file)

X_train_file <- "./data/train/X_train.txt"
X_train <- read.table(X_train_file)

y_train_file <- "./data/train/y_train.txt"
y_train <- read.table(y_train_file)

# Read in test data set
subject_test_file <- "./data/test/subject_test.txt"
subject_test <- read.table(subject_test_file)

X_test_file <- "./data/test/X_test.txt"
X_test <- read.table(X_test_file)
                  
y_test_file <- "./data/test/y_test.txt"
y_test <- read.table(y_test_file)

# rbind subject
subjects <- rbind(subject_train, subject_test)
colnames(subjects) <- c("subject_id")

# rbind y
y_data <- rbind(y_train, y_test)
colnames(y_data) <- c("activity_label")
# y_activity <- merge(y_data, labels, by.x = "activity_label", by.y = "activity_label", all = FALSE)

# rbind X and select the mean() and std()
X_data <- rbind(X_train, X_test)
colnames(X_data) <- make.names(c(as.character(features[,2])), unique = TRUE)
X_data_mean <- select(X_data, contains("mean"))
X_data_std <- select(X_data, contains("std"))
X_data_select <- cbind(X_data_mean, X_data_std)

# cbind() subjects plus y_data plus X_data_select
project_dataset <- cbind(subjects, y_data, X_data_select )

# Attach activity (descriptions) to the labels to meet Requirement #3
project_dataset_labels <- merge(project_dataset, labels, by.x = "activity_label", by.y = "activity_label", all = FALSE, sort = FALSE)
project_dataset_labels <- project_dataset_labels[order(project_dataset_labels$activity_label, project_dataset_labels$subject_id),]

# 5.  From the project_dataset_labels, creates a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.

library(reshape2)             ## rshape2 is not used here but could be useful.
library(data.table)

# Convert data.frame into data.table
project_dataset_DT <- data.table(project_dataset_labels)
tidy_DT <- project_dataset_DT[, lapply(.SD, mean), by = c("activity", "subject_id")]


# write tidy data into a .txt file for peer grading
# write.table()
write.table(tidy_DT, file = "tidy_data_by_JXieDS.txt", sep = "\t", row.names = FALSE)

### The saved tidy dataset can be read by the code below (less "###")
###     tidy_data <- read.table("tidy_data_by_JXieDS.txt", header = TRUE)
