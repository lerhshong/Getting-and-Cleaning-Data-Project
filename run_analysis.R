setwd("C:/Users/lerhshong/Desktop/For Elysium/Coursera/3. Getting and Cleaning Data/UCI HAR Dataset")
readdataset <- function(name){
        x <-"C:/Users/lerhshong/Desktop/For Elysium/Coursera/3. Getting and Cleaning Data/UCI HAR Dataset/"
        filepath <- paste(x,name, sep="")
        dataset <- read.table(filepath)
        return(dataset)
}
subject_test <- readdataset("test/subject_test.txt") # The persons in the test data set. 2947 rows.
X_test <- readdataset("test/X_test.txt") # Measurements for each activity # 561 variables
Y_test <- readdataset("test/Y_test.txt") # The type of activity. Based on activity labels

activity_labels <- read.table("activity_labels.txt") #This doesn't seem to be necessary.
features <- read.table("features.txt")

# Name the measurements in X_test
features$V2 <- as.character(features$V2)
names(X_test) <- features$V2

# Use activity labels instead of number code
activity_labels$V2 <- as.character(activity_labels$V2)
for (i in 1:6){
        Y_test[Y_test==i] <- activity_labels$V2[i]
        
}

# Obtain test dataset by merging test activity labels with test activity data and subjects
testdata <- cbind(Y_test,X_test)
names(testdata)[1] <- "Activity"
testdata <- cbind(subject_test,testdata)
names(testdata)[1] <- "Subject"


# Do all of the above for the training data
subject_train <- readdataset("train/subject_train.txt") # The persons in the training data set. 7352 rows
X_train <- readdataset("train/X_train.txt")
Y_train <- readdataset("train/Y_train.txt")

# Name the measurements in X_train
names(X_train) <- features$V2

# Use activity labels instead of number code
for (i in 1:6){
        Y_train[Y_train==i] <- activity_labels$V2[i]
        
}

# Obtain test dataset by merging test activity labels with test activity data
traindata <- cbind(Y_train,X_train)
names(traindata)[1] <- "Activity"
traindata <- cbind(subject_train,traindata)
names(traindata)[1] <- "Subject"

# Merge the datasets
dataset <- rbind(traindata,testdata)

# Now want only the columns that are means and standard deviations.
means <- grepl("mean[^F]",names(dataset))
stds <- grepl("std()",names(dataset))
activity <- grepl("Activity", names(dataset))
subject <- grepl("Subject",names(dataset))
dataset <- dataset[means | stds | activity | subject ]

# Clean the names
features <- names(dataset)
for (i in 1:length(features)){
        features[i] <- gsub("^t","time",features[i])
        features[i] <- gsub("^f","freq",features[i])
        features[i] <- gsub("\\()","",features[i])
        features[i] <- gsub("std","stddev",features[i])
        features[i] <- gsub("[Bb]ody[Bb]ody","Body",features[i])
        features[i] <- gsub("[Mm]ag","Magnitude",features[i])
        
}

names(dataset) <- features

# Produce a dataset that has average values per subject and average values per activity
library(dplyr)
groupdataset <- group_by(dataset, Subject, Activity)
groupdataset <- summarise_each(groupdataset,funs(mean))
