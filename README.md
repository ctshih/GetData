---
title: "Course Project for Getting and Cleaning Data"
output: html_document
---

This is an R Markdown document for the course project of the coursera course "Getting and Cleaning Data". The purpose of this project is to collect, work with, and clean the dataset:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Assignment of the project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Procedure of the data processing

The R-script for the data processing is "run_analysis.R". The details of the script is describe in the following:

1. Read the data from training and test sets and combine the two sets together
```R
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
data <- rbind(test_data, train_data)
```
2. Read the subjects and combine the two sets together
```R
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(test_subject, train_subject)
names(subject) <- "Subject"
```

3. Read the labels of activities and combine
```R
test_label <- read.table("UCI HAR Dataset/test/y_test.txt")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
label <- rbind(test_label, train_label)
```

4. Read the name of measurements and assign to the data
```R
measurement <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
names(data) <- measurement$V2
```

5. Extract the data for the mean and standard deviation of the measurements
```R
MeanStdCol <- grep("mean|std[^F]", measurement$V2)
MeanStdData <- data[,MeanStdCol]
```

6. Convert the activity labels to activity names
```R
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_data <- as.data.frame(activities[label[,1],2])
names(activity_data) <- "Activity"
```

7. Create the tidy dataset
```R
TidyData <- cbind(subject,activity_data,MeanStdData)
write.table(TidyData, "tidy_data.txt", row.name = FALSE)
```

8. Average the data for subjects and activities

```R
i_subject <- unique(TidyData$"Subject")
n_subject <- length(i_subject)
n_activity <- length(activities$V2)
n_measure <- length(MeanStdCol)+2
n_data <- dim(TidyData)[1]
TidyMean <- TidyData[1:(n_subject*n_activity),]
names(TidyMean) <- names(TidyData)

irow <- 1
for (s in 1:n_subject){
    for (a in 1:n_activity){
        TidyMean[irow,1] <- i_subject[s]
        TidyMean[irow,2] <- activities[a,2]
        part <- TidyData[TidyData$"Subject"==s & TidyData$"Activity"==activities[a,2],]
        TidyMean[irow, 3:n_measure] <- colMeans(part[,3:n_measure])
        irow = irow+1
    }
}

write.table(TidyMean, "tidy_data_mean.txt", row.name = FALSE)
```