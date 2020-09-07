library(dplyr)

# Set routes
featurePath <- "C:/Users/browm/Documents/CourseraGit/GettingAndCleaningData/Week4/UCI HAR Dataset/"
trainPath <- "C:/Users/browm/Documents/CourseraGit/GettingAndCleaningData/Week4/UCI HAR Dataset/train/"
testPath <- "C:/Users/browm/Documents/CourseraGit/GettingAndCleaningData/Week4/UCI HAR Dataset/test/"
exportPath <- featurePath

# Getting feature list & activity labels
features <- read.table(paste(featurePath,"features.txt",sep = ""),header = FALSE, sep = " ")
activity_labels <- read.table(paste(featurePath,"activity_labels.txt",sep = ""),header = FALSE, sep = " ")


# Getting train files
trainX <- read.table(paste(trainPath, "X_train.txt",sep="") ,header = FALSE)
trainY <- read.table(paste(trainPath, "y_train.txt",sep="") ,header = FALSE)
trainSubject <- read.table(paste(trainPath, "subject_train.txt",sep="") ,header = FALSE)


# Getting test files
testX <- read.table(paste(testPath, "X_test.txt",sep="") ,header = FALSE)
testY <- read.table(paste(testPath, "y_test.txt",sep="") ,header = FALSE)
testSubject <- read.table(paste(testPath, "subject_test.txt",sep="") ,header = FALSE)


# Add column names to datasets
# X
colnames(trainX) <- features[,2] -> colnames(testX)
# Y
colnames(trainY) <- "activityId" -> colnames(testY)
# subject
colnames(trainSubject) <- "subjectId" -> colnames(testSubject) 
# labels
colnames(activity_labels) <- c("activityId","activityType")


# Bind columns of train datasets
trainMerged <- cbind(trainY, trainSubject, trainX)
# Bind columns of test datasets
testMerged <- cbind(testY, testSubject, testX)
# Bind rows of the previous both datasets
dfTrainTest <- rbind(trainMerged, testMerged)


# Subset data with mean & std
meanStd <- grepl("^activityId|^subjectId|mean|std",colnames(dfTrainTest)) 
dfMeanStd <- dfTrainTest[, meanStd]


# Merge activity labels with the dataset
namedDfMeanStd = merge( activity_labels,dfMeanStd, by='activityId')


# Create new tidy dataset with the average of each variable for each activity and each subject
tbl_df <- as_tibble(namedDfMeanStd)
tbl_df2 <- tbl_df %>%
  group_by(activityId,subjectId,activityType) %>%
  summarise_all(mean)


# Generate new tidy file
write.table(tbl_df2,file = paste(exportPath,"newTidySet.txt",sep=""),row.names = FALSE)
 

