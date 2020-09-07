# CodeBook

## Data

The data used on this assignment represents the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The link to download the datasets is:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, it captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.


### Used Files

* features.txt          : List of all features
* activity_labels.txt   : Links the class labels with their activity name.
* X_train.txt           : Training set.
* y_train.txt           : Training labels.
* subject_train.txt     : Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* X_test.txt            : Test set.
* y_test.txt            : Test labels.
* subject_test.txt      : Each row identifies the subject who performed the activity for each window sample. Its values are: 2, 4, 9, 10, 12, 13, 18, 20, 24


## Applied transformations and used variables

1. Set the routes where the files are on each of the following variables:
* featurePath
* trainPath 
* testPath
* exportPath

2. Getting feature list & activity labels
On this step, the commands reads the feature file contained in the route within the variable **featurePath** and store it on the new variable **features**. It also reads the activity label file which resides on the same directory and store it on the new variable **activity_labels**.

3. Getting train files
On this step, the commands reads the train files and store their contents on these variables:
* **trainX**: content of X_train.txt 
* **trainY**: content of y_train.txt
* **trainSubject**: content of subject_train.txt 

4. Getting test files
Similar to the previous step, the commands reads the test files and store their contents on these variables:
* **testX**: content of X_train.txt 
* **testY**: content of y_train.txt
* **testSubject**: content of subject_train.txt 

5. Add column names to datasets
On this step, the commands assign the corresponding column names to the previous variables:
* **trainX** & **testX** using the second column of **features** 
* **trainY** & **testY** using the name activityId
* **trainSubject** & **testSubject** using the name subjectId
* Also the new variable **activity_labels** using activityId and activityType as the first and second column's names.

6. Unify columns of datasets
On this step, the commands binds the columns of the variables:
* **trainY**, **trainSubject**, **trainX** and store the result on **trainMerged**
* **testY**, **testSubject**, **testX** and store the result on **testMerged**
* Finally, binds the rows of the previous two variables and store the result on **dfTrainTest**

7. Subsetting the data
On this step, the commands generate a logical vector using the column names of **dfTrainTest**; TRUE when the name contains activityId, subjectId, mean or std. And storage it on **meanStd**.
Finally, using the last variable as filter for the columns, the commands subset **dfTrainTest** and store it on **dfMeanStd**.

8. Merge activity labels with the dataset
On this step, the commands merge the data on **activity_labels** with **dfMeanStd** using as pivot the column activityId and store the result on **namedDfMeanStd**

9. Create new tidy dataset with the average of each variable for each activity and each subject
On  this step, the commands groups the data on namedDfMeanStd using the columns activityId,subjectId,activityType and computes the mean of every other column per generated group storing the result on **tbl_df2**.

10. Generate new tidy file
On this last step, the command generate a new file containing the data stored on the variable **tbl_df2**.











