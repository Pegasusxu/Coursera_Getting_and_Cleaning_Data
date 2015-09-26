## Step.1: Merges the training and the test sets to create one data set
## Read all key train and test files from folder
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
## Merge x_train and x_test
MergedData <- rbind(x_train, x_test)
## Name the variables in the MergedData
features <- read.table("./UCI HAR Dataset/features.txt")
colnames(MergedData) <- features$V2
## Combine subject, activities and MergedData
TrainSubAct <- cbind(subject_train, y_train)
TestSubAct <- cbind(subject_test, y_test)
SubAct <- rbind(TrainSubAct, TestSubAct)
colnames(SubAct) <- c("Subject", "Activity")
MergedData <- cbind(SubAct, MergedData)

## Step.2: Extracts only the measurements on the mean and standard deviation 
## for each measurement
## Extract the measurements with "mean" and "std" in the column names
MeanStd <- MergedData[, grep("mean|std", colnames(MergedData))]
## Remove columns with "meanFreq" in the column names
MeanStd <- MeanStd[, -grep("meanFreq", colnames(MeanStd))]
## Re-combine Subject and Activity to the extracted measurements
MeanStd <- cbind(SubAct, MeanStd)

## Step.3: Uses descriptive activity names to name the activities in the data 
## set
## Read activity lables
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("Act_Num", "DesAct")
DesAct <- as.character(activity_labels$DesAct)
## Replace activity label numbers with activity names
MeanStd$Activity <- DesAct[MeanStd$Activity]

## Step.4: Appropriately labels the data set with descriptive variable names
MeanStdcolnames <- colnames(MeanStd)
## Remove all non-alphabetic characters from the variable names of MeanStd
colnames(MeanStd) <- gsub("[^[:alpha:]]", "", MeanStdcolnames)
## Export the first dataset
write.table(MeanStd, "tidy_merged_data.txt", row.name=FALSE)

## Step.5: From the data set in step 4, creates a second, independent tidy data
## set with the average of each variable for each activity and each subject
## Calculate the activity means for each combination of subject and activity
SecondDataSet <- aggregate(MeanStd[, 3:ncol(MeanStd)], by=list(Subject = 
                           MeanStd$Subject, Activity = MeanStd$Activity), mean)
## Export the second dataset
write.table(SecondDataSet, "tidy_aggre_data.txt", row.name=FALSE)
