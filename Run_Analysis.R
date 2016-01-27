
library(plyr)
#Step 1
# Read the X training and test sets
        x_train <- read.table("train/X_train.txt")
        x_test <- read.table("test/X_test.txt")
# Read the Y training and test sets
        y_train <- read.table("train/Y_train.txt")
        y_test <- read.table("test/Y_test.txt")
# Read the Subject training and test sets
        subject_train <- read.table("train/subject_train.txt")
        subject_test <- read.table("test/subject_test.txt")
# Merge the  X, Y, and Subject training sets with the corresponding X, Y, and Subject test sets        
        x_data <- rbind(x_train, x_test)
        y_data <- rbind(y_train, y_test)
        subject_data <- rbind(subject_train, subject_test)
# Read the Features data 
        features <- read.table("features.txt")
        
#Step 2
# Extract only columns with mean() and std() in their names
        mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])        
        
# Create a subset for the desired columns
        x_data <- x_data[, mean_and_std_features]

# correct the column names
        names(x_data) <- features[mean_and_std_features, 2] 

# Step 3
# read the activity_labels data set
        activities <- read.table("activity_labels.txt")

# update values with correct activity names
        y_data[, 1] <- activities[y_data[, 1], 2]
    
# Step 4
# Appropriately label the data set with descriptive variable names
        names(y_data) <- "activity"
        names(subject_data) <- "subject"

# bind all the data in a single data set
        new_dataset <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable for each activity
# and each subject
        new_avg_dataset <- ddply(new_dataset, .(subject, activity), function(x) colMeans(x[, 1:66]))

        write.table(new_avg_dataset, "new_avg_dataset.txt", row.name=FALSE)


        
        
        
        