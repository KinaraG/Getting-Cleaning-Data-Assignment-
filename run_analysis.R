install.packages("data.table")
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
unzip("UCI HAR Dataset.zip", exdir = getwd())

features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

x_train <- read.table('./UCI HAR Dataset/train/X_train.txt', header=FALSE)
y_train <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
subject_train <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

train_data <-  data.frame(subject_train, y_train, x_train)
names(train_data) <- c(c('subject', 'activity'), features)

x_test <- read.table('./UCI HAR Dataset/test/X_test.txt', header=FALSE)
y_test <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
subject_test <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

test_data <-  data.frame(subject_test, y_test, x_test)
names(test_data) <- c(c('subject', 'activity'), features)

# 1. Merges the training and the test sets to create one data set.

Merged_data <- rbind(train_data,test_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

meanstd <- grep('mean|std', features)
TidyData <- Merged_data [,c(1,2,meanstd+2)]

# 3. Uses descriptive activity names to name the activities in the data set.

activity <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity <- as.character(activity[,2])
TidyData$activity <- activity [TidyData$activity]

# 4. Appropriately labels the data set with descriptive variable names.

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Data <- aggregate(TidyData[,3:81], by = list(activity = TidyData$activity, subject = TidyData$subject),FUN = mean)
write.table(x = TidyData, file = "TidyData.txt", row.names = FALSE)


str(Data)
Data
