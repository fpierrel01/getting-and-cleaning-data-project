---
#title: "CodeBook"
author: "Fred Pierre-Louis"
date: "January 26, 2016"
output: html_document
---
According to the information provided in this course, a full description of the data used in this project can be found at The UCI Machine Learning Repository.


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Attribute Information.


#Step 1
Read the X training and test sets
        x_train <- read.table("train/X_train.txt")
        x_test <- read.table("test/X_test.txt")
Read the Y training and test sets
        y_train <- read.table("train/Y_train.txt")
        y_test <- read.table("test/Y_test.txt")
Read the Subject training and test sets
        subject_train <- read.table("train/subject_train.txt")
        subject_test <- read.table("test/subject_test.txt")
Merge the X, Y, and Subject training sets with the corresponding X, Y, and Subject test sets
        x_data <- rbind(x_train, x_test)
        y_data <- rbind(y_train, y_test)
        subject_data <- rbind(subject_train, subject_test)
Read the Features data
        features <- read.table("features.txt")
#Step 2
Extract only columns with mean() and std() in their names
        mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])        
Create a subset for the desired columns
        x_data <- x_data[, mean_and_std_features]
correct the column names
        names(x_data) <- features[mean_and_std_features, 2] 
#Step 3
read the activity_labels data set
        activities <- read.table("activity_labels.txt")
update values with correct activity names
        y_data[, 1] <- activities[y_data[, 1], 2]
#Step 4
Appropriately label the data set with descriptive variable names
        names(y_data) <- "activity"
        names(subject_data) <- "subject"
bind all the data in a single data set
        new_dataset <- cbind(x_data, y_data, subject_data)
#Step 5
Create a second, independent tidy data set with the average of each variable for each activity
and each subject
        new_avg_dataset <- ddply(new_dataset, .(subject, activity), function(x) colMeans(x[, 1:66]))

        write.table(new_avg_dataset, "new_avg_dataset.txt", row.name=FALSE)