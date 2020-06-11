---
title: "Code Book"
output: html_document
---


The ```run.analysis.R``` prepares data with below steps:

### **Download the dataset**

* Zip file was downloaded and extracted under ``` UCI HAR Dataset``` folder

### **Assigning Vaiables**

* `features.txt`
  * Assigned Variable = features
  * Rows = 561
  * Columns = 2
  * contains features collected from acceloremeter and gyroscope 3-axial raw signals    tAcc-XYZ and tGyro-XYZ.
* `activity_labels.txt`
  * Assigned Variable = activity 
  * Rows = 6
  * Columns = 2
  * List of activities volunteers performed with respective codes
* `test/subjects_test.txt`
  * Assigned Variable = subject_test
  * Rows = 2947
  * Columns = 1
  * Contains data of 30% (9/30) of the volunteers 
* `test/X_test.txt`
  * Assigned Variable = x_test
  * Rows = 2947
  * Columns = 561
  * Recorded features test data
* `test/y_test.txt`
  * Assigned Variable = y_test
  * Rows = 2947
  * Columns = 1
  * Test data of activities 
* `test/subject_train.txt`
  * Assigned Variable = subject_train
  * Rows = 7352 
  * Columns = 1
  * Contains data of 70% (21/30) of the volunteers 
* `test/X_train.txt`
  * Assigned Variable = x_train
  * Rows = 7352
  * Columns = 561
  * Recorded features train data
* `test/y_train.txt`
  * Assigned Variable = y_train
  * Rows = 7352
  * Columns = 1
  * Train data of activities 
  
### **Merging train & test data and create one single dataset**

* `train_data`
  * Rows = 7352
  * Columns = 563
  * A data frame made by combining `subject_train`, `y_train` and `x_train` 
* `test-data`
  * Rows = 2947
  * Columns = 563
  * A data frame made by combining `subject_test`, `y_test` and `x_test`
* `Merged_data`
  * Rows = 10299
  * Columns = 563
  * Combined `train_data` and `test_data` usind `rbind()`
  
### **Extracting measurements on the mean and standard deviation for each measurement**

* Stored features containing `mean` and `std` into `meanstd`
  * length = 79
* Subsetting `Merged_data` by selecting only first two columns `subject`, `activity`and taking all the columns of `meanstd`
* Resultant dataframe is a `TidyData`

### **Provided names of the activities from activity data set**

Numbers in `Activity` column of `TidyData` replaced with corresponding activity names taken from second column of the `activity` variable 

### **Labelling of the dataset with appropriate variable names**

* `Acc` into `Accelerometer`
* `Gyro` into `Gyroscope`
* `BodyBody` into `Body`
* `Mag` into `Magnitude`
* Starts with `t` into `Time`
* Starts with `f` into `Frequency`
* `tBody` into `TimeBody`
* Ending with `-mean()` into `Mean`
* Ending with `-std()` into `STD`
* Ending with `-freq()` into `Frequency`
* `angle` with `Angle`
* `gravity` with `Gravity`

### **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**

`FinalData` created by summarizing `TidyData` taking means of each variable for each activity and each subject and stored into `FinalData.txt` file.
