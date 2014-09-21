
library(plyr);

if(!file.exists("./UCI HAR Dataset")){
    print("Unable to find UCI HAR Dataset in the present directory. Extract the Smartphone dataset to this directory..")}

#1. Merges the training and the test sets to create one data set.

            #Read the train set
trainX <- read.csv("UCI HAR Dataset/train/X_train.txt",sep="", header=FALSE);
trainY <- read.csv("UCI HAR Dataset/train/y_train.txt",sep="", header=FALSE);
colnames(trainY) <- "Activity";
trainSub <- read.csv("UCI HAR Dataset/train/subject_train.txt",sep="", header=FALSE);
colnames(trainSub) <- "Subject";
trainSet <- cbind(trainSub, trainX, trainY);

            #Read the test set
testX <- read.csv("UCI HAR Dataset/test/X_test.txt",sep="", header=FALSE);
testY <- read.csv("UCI HAR Dataset/test/y_test.txt",sep="", header=FALSE);
colnames(testY) <- "Activity";
testSub <- read.csv("UCI HAR Dataset/test/subject_test.txt",sep="", header=FALSE);
colnames(testSub) <- "Subject";
testSet <- cbind(testSub, testX, testY);
            #Combine both trainSet and testSet using rbind()
fullSet <- rbind(trainSet, testSet);

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
            #read the feature.txt to extract the list of features
featureList <- read.csv("UCI HAR Dataset/features.txt",sep="", header=FALSE);
            #Select only the features that has "mean()" in the featureList - Not selecting meanFreq()
allMean <-  grep("mean\\(\\)",featureList[,2]);
            #Select only the features that has "std()" in the featureList
allStd <- grep("std\\(\\)",featureList[,2]);
            #arrange both the above selected mean and std columns
meanStdArray <- sort(c(allMean, allStd));
            #Select the column that has Subject, all the mean-std columns, Activity(563rd), Use(564th)
selectedSet <- fullSet[,c(1,meanStdArray+1,563)];

#3. Uses descriptive activity names to name the activities in the data set
activityList <- read.csv("UCI HAR Dataset/activity_labels.txt",sep="", header=FALSE);
selectedSet$Activity <- factor(selectedSet$Activity, label=activityList$V2)

#4. Appropriately labels the data set with descriptive variable names. 
            #Selecting the names of the feature based on meanStdArray values
featureNames <- featureList[meanStdArray,2];
colnames(selectedSet) <- c("Subject",as.character(featureNames), "Activity");

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#for each activity and each subject.
            #Use ddply to create combination of Subject-Activity and find the mean of all the feature columns.
secondTidySet <- ddply(selectedSet, .(Subject, Activity), numcolwise(mean));

#6. Please upload the tidy data set created in step 5 of the instructions. Please upload your data set as a txt file
#created with write.table() using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this
#may cause errors saving your submission).
write.table(secondTidySet, file="tidyDataSet.txt", sep=" ", row.names=FALSE);


