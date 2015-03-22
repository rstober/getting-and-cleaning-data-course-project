# getting-and-cleaning-data-course-project
This is the repository for the Getting and Cleaning Data course project.

# Contents

## run_analysis.R
This is an R script that downloads, merges, and aggregates the test and training Samsung data sets.

### Download and unzip the data set.
* Downloads the complete data set if it doesn't already exist in the working directory.
* Unzips the data set if the unzipped directory doesn't exist.

### Build the list of column names
* Reads in the features.txt file to obtain the column labels for all 561 columns in the data set. The columns names are stored in a variable called feature.labels. The column names are identical in both the test and training data files.
* Reduces feature.labels to include only the labels for columns representing mean and std deviation.
* Replaces spaces in feature.labels with hyphens.

### Reads in and prepare the data sets.
The following operations are performed on both the test and training data sets.
* Reads in the activities from the activities files (./test/y_test.txt and ./train/y_train.txt, respectively).
* Reads in the subjects from the subjects files (./test/subject_test.txt and ./train/subject_test.txt, respectively).
* Reads in the test data set from the data files (./test/X_test.txt and ./train/X_train.txt, respectively). The result is two data frames, test.df and train.df.
* Binds the subjects and activities vectors to the test.df and train.df data frames.
* Assign feature labels to each column.
* Drop all the columns that don't represent mean or standard deviation measurements.


# add the two columns names for the subject-id and the activity-id
##codebook.txt
##README.md

# Procedure
