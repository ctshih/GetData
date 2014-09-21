---
title: "CodeBook"
output: html_document
---
The processed data are saved in the file `tidy_data_mean.txt`. Use the command 
```R
TidyDataMean <- read.table("tidy_data_mean.txt", header = TRUE)
``` 
to read the data in R. The colomns in the data frame are:

1. First Column (Subject): numeric ID of the subjects.
2. Second Column (Activity): recorded activities, including walking, walking up- and down-stairs, sitting, standing, and laying.
3. The remaining columns: mean and standard deviations for the measurements:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag
