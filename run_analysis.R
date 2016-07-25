# Load and merge "test" and "train" data
## Assign "test" data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
## Assign "train" data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
## Bind "test" data together
test <- cbind(x_test, y_test, subject_test)
## Bind train data together
train <- cbind(x_train, y_train, subject_train)
## Merge test and train data rows together
m <- rbind(test, train)

# Add columns label to the variables
## Load features
features <- read.table("UCI HAR Dataset/features.txt")
## Removed non unnecessary chars
features <- gsub("\\(\\)", "", as.character(features$V2))
## Transform '-' by '.' for readability
features <- gsub('-', '.', features)
## add the new named columns
colnames(m) <- c(features, "activity", "subject_id")

# Extracts only the measurements on the mean and standard deviation for each measurement
m <- m[, grep("mean\\.|mean$|std\\.|std$|activity|subject_id", colnames(m))]

# Replace a descriptive activities in data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
for (i in 1:6) {
  m$activity[m$activity == i] <- as.character(activities$V2[[i]])
}

# We use dplyr library to compute grouping and summarize the observations 
library(dplyr)
## Nice way to compute the grouped observations
averages <- m %>% group_by(activity, subject_id) %>% summarise_each(funs(mean))

# The results are stored in averages.txt file.
write.table(averages,"averages.txt", row.names = FALSE)
