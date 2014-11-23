project_tidydata
================

Coursera - Data Science Track - Getting and Cleaning Data - course project

The purpose is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

Submitted for peer-evaluation a link to this Github repository with the R script for performing the data analysis. 

Files deposited in this repo
----------------------------
1. R script called run_analysis.R that does the following (when run with the data sets saved in the ./data subdirectory),
   * Merges the training and the test sets to create one data set.
   * Extracts only the measurements on the mean and standard deviation for each measurement. 
   * Uses descriptive activity names to name the activities in the data set.
   * Appropriately labels the data set with descriptive variable names. 
   * From the above data set, creates a second, independent tidy data set with the average of each variable for each activity (6 activities) and each subject (30 subjects).
2. CodeBook.md that describes the variables, the data, and any transformations or work that are performed to clean up the data. 
3. README.md that explains how all of the scripts work and how they are connected. 

A file containing the tidy data set has been submitted directly to Coursera course project page.
------------------------------------------------------------------------------------------------
The .txt file can be read with the R code below.
    tidy_data <- read.table("tidy_data_by_JXieDS.txt", header = TRUE)
This tidy data set that meets the tidy data principles, e.g., each variable measured should be in one column and each different observation of that variable should be in a different row.
The numeric activity_labels are kept along with the descriptive activity names since the numeric labels could serve as a reference to the original data sets.  