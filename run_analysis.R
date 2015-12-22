#You should create one R script called run_analysis.R 
#that does the following. 

#Download and unzip if necessary
file_name="fuci_har_data.zip"
url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(file_name)){
    download.file(url,file_name)
}

if (!file.exists("UCI HAR Dataset")) { 
    unzip(file_name) 
}

#1. Merges the training and the test sets to create one data set.

if (!exists("dt_x_test")){dt_x_test=read.table( "UCI HAR Dataset/test/X_test.txt")}
if (!exists("dt_y_test")){dt_y_test=read.table( "UCI HAR Dataset/test/y_test.txt")}
if (!exists("dt_subject_test")){dt_subject_test=read.table( "UCI HAR Dataset/test/subject_test.txt")}
if (!exists("dt_x_train")){dt_x_train=read.table( "UCI HAR Dataset/train/X_train.txt")}
if (!exists("dt_y_train")){dt_y_train=read.table( "UCI HAR Dataset/train/y_train.txt")}
if (!exists("dt_subject_train")){dt_subject_train=read.table( "UCI HAR Dataset/train/subject_train.txt")}
if (!exists("activity_labels")){activity_labels=read.table( "UCI HAR Dataset/activity_labels.txt")}
if (!exists("features")){features=read.table( "UCI HAR Dataset/features.txt")}

#Renaming Columns
names(dt_x_test)=features[,"V2"]
names(dt_x_train)=features[,"V2"]
names(dt_y_test)="labels"
names(dt_y_train)="labels"
names(dt_subject_test)="subject"
names(dt_subject_train)="subject"

#Bind Rows
dt_x=rbind(dt_x_test,dt_x_train)
dt_y=rbind(dt_y_test,dt_y_train)
dt_subject=rbind(dt_subject_test,dt_subject_train)

#Bind Columns
dt_har=cbind(dt_y,dt_subject,dt_x)

#2. Extracts only the measurements on the mean and standard 
#   deviation for each measurement. 
dt_har_compact=dt_har[grepl("label|subject|mean|std",names(dt_har))]

#3. Uses descriptive activity names to name the activities in 
#   the data set
dt_har_descr=merge(activity_labels,dt_har_compact,by.x = "V1",by.y = "labels")

#4. Appropriately labels the data set with descriptive variable 
#   names. 
names(dt_har_descr)[1:2]=c("labels","activities")

#5. From the data set in step 4, creates a second, independent 
#   tidy data set with the average of each variable for each 
#   activity and each subject.
library(dplyr)
har_gb<-group_by(dt_har_descr,activities,subject)
tidy_har <- har_gb %>% summarise_each(funs(mean))

#Write table back
write.table(tidy_har, row.name=FALSE, "tidy.txt")
