# run_analysis.R
# Robert Stober
# Getting and Cleaning data Course Project

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each 
# measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

# download the dataset if it doesn't already exist
datafile <- "uci.har.dataset.zip"
if (!file.exists(datafile)) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile=datafile, mode="wb")
}

datadir <- "UCI HAR Dataset"
# unzip the dataset if datadir doesn't exist
if (!file.exists(datadir)) {
    unzip(datafile)
}

# set the working directory to datadir
setwd(datadir)

# build list of labels for all 561 columns in the dataset
feature.labels <- readLines("features.txt")

# reduce feature.labels to include only the labels for columns representing mean 
# and std deviation.
feature.labels <- grep("mean|std", feature.labels, perl=TRUE, value=TRUE)

# replace spaces in labels with hyphens
feature.labels <- gsub("\\s", "-", feature.labels)

# add the two columns names for the subject-id and the activity-id
feature.labels <- c("subject", "activity", feature.labels)

#
# Read in and prepare the test dataset
#

# read in the activities
test.activities <- readLines("./test/y_test.txt")

# read in the subjects
test.subjects <- readLines("./test/subject_test.txt")

# read in the test data set set
test.df <- read.table("./test/X_test.txt")

# bind the test.subjects and test.activities vector to the 
# test.df data frame
test.df <- cbind(test.subjects, test.activities, test.df)

# assign feature labels to each column
names(test.df) <- feature.labels

# drop all the columns that don't represent mean or standard deviation measurements
test.df <- test.df[, feature.labels]

#
# Read in and prepare the training dataset
#

# read in the activities
train.activities <- readLines("./train/y_train.txt")

# read in the subjects
train.subjects <- readLines("./train/subject_train.txt")

# read in the test data set set
train.df <- read.table("./train/X_train.txt")

# bind the train.subjects and train.activities vectors to the 
# train.df data frame
train.df <- cbind(train.subjects, train.activities, train.df)

# assign feature labels to each column
names(train.df) <- feature.labels

# drop all the columns that don't represent mean or standard deviation measurements
train.df <- train.df[, feature.labels]

#
# merge the test and training data frames
#

merged.df <- rbind(test.df, train.df)

#
# produce the tidy data set
#

# take the mean of all columns grouped by subject and activity
tidy.df <- aggregate(merged.df[, 3:length(feature.labels)], 
    list(merged.df$subject,merged.df$activity), mean)

# restore the columns names that aggregate changed.
names(tidy.df)[1] <- "subject"
names(tidy.df)[2] <- "activity"

# Now convert the factor columns to numeric so we can order the 
# tidy data frame by them
tidy.df$subject <- as.numeric(as.character(tidy.df$subject))
tidy.df$activity <- as.numeric(as.character(tidy.df$activity))

# order the tidy.df data frame by subject, then activity.
tidy.df <- tidy.df[with(tidy.df, order(subject,activity)), ]

# Now the data set is tidy and ready to be written out.

# change to the project directory
setwd("..")

# write the data file ready for upload
write.table(tidy.df, "tidy.txt", sep="\t", row.names=FALSE)
