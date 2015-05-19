---
title: "README"
output: html_document
---

##Introduction

This document describes the *run_analysis.R* script

*run_analysis.R* is a single script designed to consolidate test data from the [*Human Activity Recognition Using Smartphones*](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) dataset.  It will:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


## Deriving the Data
The script makes these transforms, cleans up after itself, and 
writes a file called *tidy_data.txt* to the working directory.

1. Loads into data tables:  activity_labels.txt, features.txt, test/X_test.txt, test/y_test.txt, 
test/subject_test.txt, train/X_train.txt, train/y_train.txt, 
train/subject_train.txt
2. Renames columns in the data sets to assist indexing
3. Renames columns in test_x and train_x data frames with the feature_name from features.txt
4. Appends subject ID and Activity ID columns to test_x and train_x
5. Merges test_x and train_x data into a single data frame
6. Builds a vector out of the column indices for all columns whose names contain "Mean", "mean",
"Std", or "std", and then adds two columns to allow for 'feature_id' and 'subject'
7. Extracts only those columns with a matching index number in that vector
8. Performs a left outer join with activities to bring the activity name into the table and then deletes the superfluous activity_id column
9. Deletes temporary tables 
10. Generates a new table summarizing column values as averages, summarized by Activity and Subject.
11. Writes a space-delimited text file called tidy_data.txt
to the working directory

##Assumptions
The script assumes that the UCI HCR dataset has been downloaded and extracted from .zip
to a directory called ~/datacourse/GettingAndCleaning/Project/.  It sets the working directory 
within (~/datacourse/GettingAndCleaning/Project/UCI HAR Dataset).  You will probably
need to adjust this path before running the script.

##Technical Environment

This script has been developed using RStudio 0.98.1103 on Mac OS X 10.10

###R Version
R version 3.1.3 (2015-03-09) -- "Smooth Sidewalk"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin13.4.0 (64-bit)

###Additional Packages
The script requires the dplyr package and was built using version 0.4.1


##Credits
***
Human Activity Recognition Using Smartphones Dataset
Version 1.0

***
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.

Smartlab - Non Linear Complex Systems Laboratory

DITEN - Universit? degli Studi di Genova.

Via Opera Pia 11A, I-16145, Genoa, Italy.

activityrecognition@smartlab.ws

www.smartlab.ws

==================================================================