# Getting-and-Cleaning-Data-Project

To use, set working directory as UCI HAR dataset folder

The following steps were used to obtain the output:
1. Define a function, readdataset, that reads in all the separate files

2. Fix the test set
2.1 Assign column names from features.txt
2.2 Use labels for activity instead of number code from activity_label.txt
2.3 Obtain the test set by merging activity labels with test activity and subject

3. Fix the training set
3.1 Assign column names from features.txt
3.2 Use labels for activity instead of number code from activity_label.txt
3.3 Obtain the test set by merging activity labels with test activity and subject

4. Merge the datasets
5. Change names to be more descriptive
6. Group the dataset, then calculate means by subject and activity
7. Write an output file.
