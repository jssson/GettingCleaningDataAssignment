---
title: "CodeBook"
author: "Johannes Holzer"
date: "19. Dezember 2015"
output: html_document
---

#Getting and cleaning data course assignment

The R script called `run_analysis.R` that does the following:

1. It merges the training and the test sets to create one data set. Those are downloaded and unzipped if this is not existing yet in the directory. The column names are according to `features.txt`. The records are stored in the variable `dt_har`.
2. It extracts the measurements on the mean and standard deviation for each measurement. This is done with the command `grepl` and stored in `dt_har_compact`.
3. It uses descriptive activity names to name the activities in the data set. Those are matched according to `activity_labels.txt`. 
4. It appropriately labels the data set with descriptive variable names.  This is done with the command `names()`.
5. From the data set in step 4, it creates a second, independent tidy data set with the average of each variable for each activity and each subject. This is done with the `dplyr` package. First the data will be grouped by activities and subject. #Afterwards they are summarized with `mean` and stored in `tidy_har`. This data is written back into `tidy.txt`
