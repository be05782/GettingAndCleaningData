#Code Book
## Files used
The files come from [This website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
Complete information about the data is available [here] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* X_train.txt and X_test.txt files contain +-10000 observations made on 30 subjects performing 6 activities 
Each observation consist of  561 measures  
* features.txt contains the name of the 561 measures
* Y_train.txt and Y.test.txt files contain the Id of the activities related to the observations
* activity_labels contains the description of each activity
* subject_train.txt and subject_test.txt contain the if of the subjects related to the objervations
* subdirectories Inertial Signals contain additional data not used to produce the data set.

## R program

* Step 1 : Merges the training and the test sets to create one data set.
This is done by rbind, cbind functions
* Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement.
This is done by selecting the columns that related to measures containing "std()" or "mean()" in the names (features)
* Step 3 : Uses descriptive activity names to name the activities in the data set
This is done by merging (activity labels)
* Step 4 : Appropriately labels the data set with descriptive variable names.
This is done by applying the name of the rows that were kep at step2
* Step p 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
This is done by using the function melt and dcast
Finally the ds produced in step 5 is written in a txt.file