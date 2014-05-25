Code Book for Getting and Cleaning Data Project - Data Science 
========================================================

## Class Project

In this code book, steps done for the data to transform it to the tidy data set are described.

Step 1 - all the files are loaded into the R, both the Test and Train samples
with appropriate naming convention, the data loaded into the R. we have the following raw dataset available at this stage:

**for test samples:**
* dataXTest
subject no. for each bservation
* dataSubjectTest

raw data for 128 element vector (all observations)
The body acceleration signal obtained by subtracting 
the gravity from the total acceleration.
* dataBodyAccXTest
* dataBodyAccYTest
* dataBodyAccZTest

The acceleration signal from the smartphone accelerometer 
X axis in standard gravity units 'g'. Every row shows a 128 element vector. 
* dataTotalAccXTest
* dataTotalAccYTest 
* dataTotalAccZTest

## transforming data
1. add the feature labels to column name

2. add the sample factor 

3. add the subject no

4. add activity no

**For Train Samples
all data for datasets, 2947 observation for 561 features
* dataXTrain

Activities are stored in this dataset for each observation
* dataYTrain 


subject no. for each observation
* dataSubjectTrain 

raw data for 128 element vector (all observations)
The body acceleration signal obtained by subtracting 
the gravity from the total acceleration. 
* dataBodyAccXTrain 
* dataBodyAccYTrain 
* dataBodyAccZTrain 

The angular velocity vector measured by the gyroscope 
for each window sample. The units are radians/second. 
* dataBodyGyroXTrain
* dataBodyGyroYTrain 
* dataBodyGyroZTrain 

The acceleration signal from the smartphone accelerometer 
X axis in standard gravity units 'g'. Every row shows a 128 element vector. 
* dataTotalAccXTrain
* dataTotalAccYTrain
* dataTotalAccZTrain 

## transforming data
modifying data to place them in one data frame
1. add the feature labels to column name

2. add the sample factor 

3. add the subject no

4. add activity no

## creating the answer to project questions

1. create all data frame, aggregate both test and sample into one dataset

2. selecting just mean and std columns
creating a subset of data and loop trough column names, 
if "mean" or "std" is included, this column will be seleted


3,4. adding descriptive labels of activities to the dataset 

5. create new tidy data set for average of each activity
to create this new dataset i have to insert the name of the columns manually
because tht ddply funstion in the applyr packages doesn't accept string as the input of this part of the function
and also there should be no wild charactes in the name of the columns

