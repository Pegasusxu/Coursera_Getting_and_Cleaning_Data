Getting and Cleaning Data Course Project

Goals: create one R script called run_analysis.R that does the following
	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names. 
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

What my run_analysis.R does:
Step 1:
	1. Read measurement files (X_train.txt, X_test.txt), subject files (subject_train.txt, subject_test.txt) and activity files (y_train.txt, y_test.txt) from unzipped folder of provided data ¡°getdata-projectfiles-UCI HAR Dataset.zip¡±
	2. Combine train dataset and test dataset, and add subject and activities accordingly to the merged dataset. Give proper column names for this combined data frame
Step2:
	1. Based on the column names of the feature measurements, keep only columns with ¡°mean¡± and ¡°std (standard deviation)¡±
	2. Further remove columns with ¡°meanFreq¡± in the variable names since these measurements are not the major concerns here
	3. Re-add Subject and Activity columns to the filtered measurements, leaving a new data frame of 68 columns
Step3:
	1. Read the descriptive activity names from activity_labels.txt
	2. Replace the activity numbers by the activity names in the MeanStd data frame
Step4:
	1. Make a character vector of column names from MeanStd data frame
	2. Remove all non-alphabetic characters from all the column names in the vector
	3. Re-name the columns of MeanStd by the new tidy less-confusing measurement names
	4. Export the new data frame out into a file named ¡°tidy_merged_data.txt¡± in the current working directory
Step 5:
	1. Aggregate the MeanStd data frame into a new data frame SecondDataSet, by averaging the measurement means and stds for each combination of subject and activity. 30 subject and 6 activities make 180 rows, while 66 measurements plus the Subject and Activity columns, making the new data frame a dimension of 180 X 68
	2. Export the new data frame out into a file named ¡°tidy_aggre_data.txt¡± in the current working directory

