# Getting-and-Cleaning-Data-Project

To use, set working directory as UCI HAR dataset folder

The following steps were used to obtain the output:

1. Define a function, readdataset, that reads in all the separate files

2. Fix the test set
  * Assign column names from features.txt
  * Use labels for activity instead of number code from activity_label.txt
  * Obtain the test set by merging activity labels with test activity and subject

3. Fix the training set
  * Assign column names from features.txt
  * Use labels for activity instead of number code from activity_label.txt
  * Obtain the test set by merging activity labels with test activity and subject

4. Merge the datasets
5. Change names to be more descriptive
6. Group the dataset, then calculate means by subject and activity
7. Write an output file.
