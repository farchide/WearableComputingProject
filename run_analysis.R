library(plyr)

#features name and number
features <- read.table("./UCI HAR Dataset/features.txt",header=F)

#activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=F)

###############
#Test subjects#
###############
#all data for datasets, 2947 observation for 561 features
#features are indicators of the observations
dataXTest <- read.table("./UCI HAR Dataset/test/X_test.txt",header=F)

#Activities are stored in this dataset for each observation
dataYTest <- read.table("./UCI HAR Dataset/test/y_test.txt",header=F)


#subject no. for each observation
dataSubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=F)

#raw data for 128 element vector (all observations)
#The body acceleration signal obtained by subtracting 
#the gravity from the total acceleration. 
dataBodyAccXTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",header=F)
dataBodyAccYTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",header=F)
dataBodyAccZTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",header=F)

#The angular velocity vector measured by the gyroscope 
#for each window sample. The units are radians/second. 
dataBodyGyroXTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",header=F)
dataBodyGyroYTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",header=F)
dataBodyGyroZTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",header=F)

#The acceleration signal from the smartphone accelerometer 
#X axis in standard gravity units 'g'. Every row shows a 128 element vector. 
dataTotalAccXTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",header=F)
dataTotalAccYTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt",header=F)
dataTotalAccZTest <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt",header=F)

#modifying data to place them in one data frame
#1. add the feature labels to column name
colnames(dataXTest) <- features[,2]

#2. add the sample factor 
test <- rep("test",times=2947)
sample <- matrix(test,nrow=2947,ncol=1)
dataXTestAll <- cbind(dataXTest,sample)

#3.add the subject no
dataXTestAll <- cbind(dataSubjectTest,dataXTestAll)
colnames(dataXTestAll)[1] <- "subject"


#4. add activity no
dataXTestAll <- cbind(dataYTest,dataXTestAll)
colnames(dataXTestAll)[1] <- "activity"


###############
#Train subjects#
###############
#all data for datasets, 2947 observation for 561 features
#features are indicators of the observations
dataXTrain <- read.table("./UCI HAR Dataset/train/X_train.txt",header=F)

#Activities are stored in this dataset for each observation
dataYTrain <- read.table("./UCI HAR Dataset/train/y_train.txt",header=F)


#subject no. for each observation
dataSubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=F)

#raw data for 128 element vector (all observations)
#The body acceleration signal obtained by subtracting 
#the gravity from the total acceleration. 
dataBodyAccXTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt",header=F)
dataBodyAccYTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",header=F)
dataBodyAccZTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",header=F)

#The angular velocity vector measured by the gyroscope 
#for each window sample. The units are radians/second. 
dataBodyGyroXTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",header=F)
dataBodyGyroYTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",header=F)
dataBodyGyroZTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",header=F)

#The acceleration signal from the smartphone accelerometer 
#X axis in standard gravity units 'g'. Every row shows a 128 element vector. 
dataTotalAccXTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt",header=F)
dataTotalAccYTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt",header=F)
dataTotalAccZTrain <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt",header=F)

#modifying data to place them in one data frame
#1. add the feature labels to column name
colnames(dataXTrain) <- features[,2]

#2. add the sample factor 
train <- rep("train",times=7352)
sample <- matrix(train,nrow=7352,ncol=1)
dataXTrainAll <- cbind(dataXTrain,sample)

#3.add the subject no
dataXTrainAll <- cbind(dataSubjectTrain,dataXTrainAll)
colnames(dataXTrainAll)[1] <- "subject"


#4. add activity no
dataXTrainAll <- cbind(dataYTrain,dataXTrainAll)
colnames(dataXTrainAll)[1] <- "activity"

########################
#create all data frame #
########################
allData <- rbind(dataXTestAll,dataXTrainAll)

########################
#just mean and std #####
########################
subsetdata <- allData[,1:2]
j<-3
for(i in 3:564)
{
  if (grepl(pattern="mean",x=colnames(allData)[i]) | grepl(pattern="std",colnames(allData)[i]) )
  {
    subsetdata <- cbind(subsetdata,allData[,i])
    colnames(subsetdata)[j] <- colnames(allData)[i]
    j<-j+1
    
  }
}

####################
#descriptive labels#
####################
subsetdata$activity <- as.numeric(subsetdata$activity)
for (i in 1:10299)
{
  if(subsetdata$activity[i] =="1") subsetdata$activity[i] ="WALKING"
  if(subsetdata$activity[i] =="2") subsetdata$activity[i] ="WALKING_UPSTAIRS"
  if(subsetdata$activity[i] =="3") subsetdata$activity[i] ="WALKING_DOWNSTAIRS"
  if(subsetdata$activity[i] =="4") subsetdata$activity[i] ="SITTING"
  if(subsetdata$activity[i] =="5") subsetdata$activity[i] ="STANDING"
  if(subsetdata$activity[i] =="6") subsetdata$activity[i] ="LAYING"
}

#######################
#new data set for average of each activity
#######################
for (i in 3:81)
{
  colnames(subsetdata)[i] <- gsub("[[:punct:]]", "",colnames(subsetdata)[i])
}

newTidyDataset <- ddply(subsetdata,.(subject,activity),summarize,
                    tBodyAccmeanX=mean(tBodyAccmeanX),
                    tBodyAccmeanY=mean(tBodyAccmeanY),
                    tBodyAccmeanZ=mean(tBodyAccmeanZ),
                    tBodyAccstdX=mean(tBodyAccstdX),
                    tBodyAccstdY=mean(tBodyAccstdY),
                    tBodyAccstdZ=mean(tBodyAccstdZ),
                    tGravityAccmeanX=mean(tGravityAccmeanX),
                    tGravityAccmeanY=mean(tGravityAccmeanY),
                    tGravityAccmeanZ=mean(tGravityAccmeanZ),
                    tGravityAccstdX=mean(tGravityAccstdX),
                    tGravityAccstdY=mean(tGravityAccstdY),
                    tGravityAccstdZ=mean(tGravityAccstdZ),
                    tBodyAccJerkmeanX=mean(tBodyAccJerkmeanX),
                    tBodyAccJerkmeanY=mean(tBodyAccJerkmeanY),
                    tBodyAccJerkmeanZ=mean(tBodyAccJerkmeanZ),
                    tBodyAccJerkstdX=mean(tBodyAccJerkstdX),
                    tBodyAccJerkstdY=mean(tBodyAccJerkstdY),
                    tBodyAccJerkstdZ=mean(tBodyAccJerkstdY),
                    tBodyAccMagmean=mean(tBodyAccMagmean),
                    tBodyAccMagstd=mean(tBodyAccMagstd),
                    tGravityAccMagmean=mean(tGravityAccMagmean),
                    tGravityAccMagstd=mean(tGravityAccMagstd),
                    tBodyAccJerkMagmean=mean(tBodyAccJerkMagmean),
                    tBodyAccJerkMagstd=mean(tBodyAccJerkMagstd),
                    tBodyGyroMagmean=mean(tBodyGyroMagmean),
                    tBodyGyroMagstd=mean(tBodyGyroMagstd),
                    tBodyGyroJerkMagmean=mean(tBodyGyroJerkMagmean),
                    tBodyGyroJerkMagstd=mean(tBodyGyroJerkMagstd),
                    fBodyAccmeanX=mean(fBodyAccmeanX),
                    fBodyAccmeanY=mean(fBodyAccmeanY),
                    fBodyAccmeanZ=mean(fBodyAccmeanZ),
                    fBodyAccstdX=mean(fBodyAccstdX),
                    fBodyAccstdY=mean(fBodyAccstdY),
                    fBodyAccstdZ=mean(fBodyAccstdZ),
                    fBodyAccmeanFreqX=mean(fBodyAccmeanFreqX),
                    fBodyAccmeanFreqY=mean(fBodyAccmeanFreqY),
                    fBodyAccmeanFreqZ=mean(fBodyAccmeanFreqZ),
                    fBodyAccJerkmeanX=mean(fBodyAccJerkmeanX),
                    fBodyAccJerkmeanY=mean(fBodyAccJerkmeanY),
                    fBodyAccJerkmeanZ=mean(fBodyAccJerkmeanZ),
                    fBodyAccJerkstdX=mean(fBodyAccJerkstdX),
                    fBodyAccJerkstdY=mean(fBodyAccJerkstdY),
                    fBodyAccJerkstdZ=mean(fBodyAccJerkstdZ),
                    fBodyAccJerkmeanFreqX=mean(fBodyAccJerkmeanFreqX),
                    fBodyAccJerkmeanFreqY=mean(fBodyAccJerkmeanFreqY),
                    fBodyAccJerkmeanFreqZ=mean(fBodyAccJerkmeanFreqZ),
                    fBodyGyromeanX=mean(fBodyGyromeanX),
                    fBodyGyromeanY=mean(fBodyGyromeanY),
                    fBodyGyromeanZ=mean(fBodyGyromeanZ),
                    fBodyGyrostdX=mean(fBodyGyrostdX),
                    fBodyGyrostdY=mean(fBodyGyrostdY),
                    fBodyGyrostdZ=mean(fBodyGyrostdZ),
                    fBodyGyromeanFreqX=mean(fBodyGyromeanFreqX),
                    fBodyGyromeanFreqY=mean(fBodyGyromeanFreqY),
                    fBodyGyromeanFreqZ=mean(fBodyGyromeanFreqZ),
                    fBodyAccMagmean=mean(fBodyAccMagmean),
                    fBodyAccMagstd=mean(fBodyAccMagstd),
                    fBodyAccMagmeanFreq=mean(fBodyAccMagmeanFreq),
                    fBodyBodyAccJerkMagmean=mean(fBodyBodyAccJerkMagmean),
                    fBodyBodyAccJerkMagstd=mean(fBodyBodyAccJerkMagstd),
                    fBodyBodyAccJerkMagmeanFreq=mean(fBodyBodyAccJerkMagmeanFreq),
                    fBodyBodyGyroMagmean=mean(fBodyBodyGyroMagmean),
                    fBodyBodyGyroMagstd=mean(fBodyBodyGyroMagstd),
                    fBodyBodyGyroMagmeanFreq=mean(fBodyBodyGyroMagmeanFreq),
                    fBodyBodyGyroJerkMagstd=mean(fBodyBodyGyroJerkMagstd),
                    fBodyBodyGyroJerkMagmean=mean(fBodyBodyGyroJerkMagmean),
                    fBodyBodyGyroJerkMagmeanFreq=mean(fBodyBodyGyroJerkMagmeanFreq),
                    tBodyGyromeanX=mean(tBodyGyromeanX),
                    tBodyGyromeanY=mean(tBodyGyromeanY),
                    tBodyGyromeanZ=mean(tBodyGyromeanZ),
                    tBodyGyrostdX=mean(tBodyGyrostdX),
                    tBodyGyrostdY=mean(tBodyGyrostdY),
                    tBodyGyrostdZ=mean(tBodyGyrostdZ),
                    tBodyGyroJerkmeanX=mean(tBodyGyroJerkmeanX),
                    tBodyGyroJerkmeanY=mean(tBodyGyroJerkmeanY),
                    tBodyGyroJerkmeanZ=mean(tBodyGyroJerkmeanZ),
                    tBodyGyroJerkstdX=mean(tBodyGyroJerkstdX),
                    tBodyGyroJerkstdY=mean(tBodyGyroJerkstdY),
                    tBodyGyroJerkstdZ=mean(tBodyGyroJerkstdZ)
                    
                    )


