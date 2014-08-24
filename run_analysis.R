# run_analysis.R
# Course Project for Getting and Cleaning Data course
# Uses the Human Activity Recognition Using Smartphones Dataset
# Creates a tidy data set from data collected from accelerometers from the Samsung Galaxy smartphone.
# The dataset used in this code is from the following source:
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# Step 1. Merge the training and test sets into one data set
# Read the data

# the test set: subjects, observations, and activity codes
subjects.test <- read.table("test/subject_test.txt")
X.test <-  read.table("test/X_test.txt")
activities.test <-  read.table("test/y_test.txt")

# the train set: subjects, observations, and activity codes
subjects.train <- read.table("train/subject_train.txt")
X.train <-  read.table("train/X_train.txt")
activities.train <-  read.table("train/y_train.txt")

# Merge the training and the test sets to create one data set
# add a column for the subjects and one for the activity labels
# rename the column names for subjects and activity so they are unique for the merge
colnames(subjects.test) <- "subjects"
colnames(activities.test) <- "activity.numcode"
colnames(subjects.train) <- "subjects"
colnames(activities.train) <- "activity.numcode"
X.test <- cbind(X.test, subjects.test)
X.test <- cbind(X.test, activities.test)
X.train <- cbind(X.train, subjects.train)
X.train <- cbind(X.train, activities.train)

# Merge the test and train sets together (Step 1 in the assignment instructions)
# yields dataset with 10299 observations of 563 variables
ds <- merge(X.test, X.train, all=TRUE)

# Add a column with descriptive activity names for the activities in the data set (Step 3 in the assignment instructions)
activity.labels <- read.table("activity_labels.txt")
activity <- activity.labels[testds$activity.numcode,2]
ds <- cbind(ds,activity)

# replace the column names for the 561 variables V1, V2, V3, ... V561 with their actual
# names in the data set
# This is Step 4 in the project instructions: Appropriately label the data set with descriptive variable names
variable.names <- read.table("features.txt")
colnames(ds) <- variable.names[,2]
colnames(ds)[562] <- "subjects"
colnames(ds)[563] <- "activity"

# Extract the measurements on the mean and standard deviation for each measurement
# by selecting only columns that include "mean" or "std" in their title
# and subsetting based on those columns. This is Step 2 in the project instructions.

# This version includes all instances of mean and std in the variable name (86 names). 
# A shorter list can be obtained by limiting the grep to just [Mm]ean() and [Ss]td() but 
# based on this thread it seems that there is no definitive answer and we can choose
# https://class.coursera.org/getdata-006/forum/thread?thread_id=248
meanstd <- grep('mean*|std*',variable.names$V2, ignore.case=TRUE, value=TRUE)
mean.std.measures <- ds[, colnames(ds) %in% meanstd]

# Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
# This is Step 5 in the project instructions
# should be 30 subjects x 6 activites, 180 rows 
# Take the average of each variable for each subject for each activity: lying, standing, etc.
library(plyr)
library(reshape2)
# get the subject labels and activity names for the id.vars in the melt function
subjects <- unique(ds$subjects)
activity <- unique(ds$activity)

# reshape the data to get a df that has rows for each subject(30) with each activity (6) = 180
melted <- melt(ds, id.vars=c("subjects", "activity"))
tidyData <- ddply(melted, c("activity", "subjects"), summarise, mean = mean(value))

# make a .txt file with write.table() and set the option to NOT write the line numbers
write.table(tidyData,"tidyData.txt", row.names=FALSE)
