## reading the test data, activity and subject identifier

testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F)
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F)
run_analysis <- function () {
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F)

## reading the train data, activity and subject identifier
trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F)
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt", header=F)
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F)


## reading the activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=F)

#reading the features
features <- read.table("./UCI HAR Dataset/features.txt", header=F)

#Appropriately labels the data set with descriptive activity names.   -> requirement 4
testActivity$V1 <- factor(testActivity$V1,levels=activityLabels$V1,labels=activityLabels$V2)
trainActivity$V1 <- factor(trainActivity$V1,levels=activityLabels$V1,labels=activityLabels$V2)


##Uses descriptive activity names to name the activities in the data set  ->requirement  3
colnames(testData) <- features$V2
colnames(trainingData) <- features$V2
colnames(testActivity) <- c("Activity")
colnames(trainActivity) <- c("Activity")
colnames(testSubject) <- c("Subject")
colnames(trainSubject ) <- c("Subject")

## Merges the training and the test sets to create one data set.  ->requirement 1
 dataToCalculateMeanAndSd <- rbind(testData,trainingData)
 
##Extracts only the measurements on the mean and standard deviation for each measurement. ->requirement 2 
 mean <-sapply( dataToCalculateMeanAndSd,mean, na.rm=T)
 statndardDeviation <- -sapply( dataToCalculateMeanAndSd,sd, na.rm=T)

##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.   ->requirement 5

 testData <- cbind(testData,testActivity,testSubject)
 trainingData <- cbind(trainingData,trainActivity,trainSubject)
 entireData <- rbind(testData ,trainingData)
 trainAndTestData <-  data.table(entireData)

cleanedData<-trainAndTestData[,lapply(.SD,mean),by="Activity,Subject"]
cleanedData







