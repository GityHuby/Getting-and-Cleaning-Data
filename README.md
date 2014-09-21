==================================================================
Script to clean Human Activity Recognition dataset
==================================================================

(lines 2-5):
The script requires two pre-requisites to run successfully:
1. Install "plyr" pack	age
2. The UCI HAR Dataset to be present in the present directory.

(lines 9-25):
Read the trainning and test set from the HAR dataset and provide 
appropriate column names to them. Use column bind to bind the 
feature-Outcome relation. Use row bind to bind the two sets namely 
test set and training set and get them to single dataframe namely fullSet. 

(ines 29-37):
Read the feature.txt from the HAR dataset to extract the list of
features. Select only the features that has "mean()" in the featureList(the
code do not select meanFreq(), etc). Also, select only the features that 
has "std()" in the featureList. Arrange both the mean & std features
and select the column that has "Subject", all the mean-std columns and "Activity"

(lines 39-46):
Use the activity_labels.txt file to get the list of activity which is used to
provide descriptive names to the activites in the dataset.Also, appropriately 
label the feature names for the respective columns.

(lines 48-51):
The ddply() function is used to regroup the dataset based on Subject-Activity
pair and correspondingly find the average of each feature variable for each
activity and each subject.

(lines 53-56):
Finaly, the tidy dataset is written as a text file using write.table.
