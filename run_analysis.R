# Read the data from training and test sets and combine the two sets together 
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
data <- rbind(test_data, train_data)

# Read the subjects and combine the two sets together
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(test_subject, train_subject)
names(subject) <- "Subject"

# Read the labels of activities and combine
test_label <- read.table("UCI HAR Dataset/test/y_test.txt")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
label <- rbind(test_label, train_label)

# Read the name of measurements and assign to the data
measurement <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
names(data) <- measurement$V2

# Extract the data for the mean and standard deviation of the measurements
MeanStdCol <- grep("mean|std[^F]", measurement$V2)
MeanStdData <- data[,MeanStdCol]

# Convert the activity labels to activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_data <- as.data.frame(activities[label[,1],2])
names(activity_data) <- "Activity"

# Create the tidy dataset
TidyData <- cbind(subject,activity_data,MeanStdData)
write.table(TidyData, "tidy_data.txt", row.name = FALSE)

# Average the data for subjects and activities
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
        TidyMean[irow,2] <- activities$V2[a]
        part <- TidyData[TidyData$"Subject"==s & TidyData$"Activity"==activities[a,2],]
        TidyMean[irow, 3:n_measure] <- colMeans(part[,3:n_measure])
        irow = irow+1
    }
}

write.table(TidyMean, "tidy_data_mean.txt", row.name = FALSE)