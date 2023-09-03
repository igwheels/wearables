setwd("~/R for DS/WearablesProject/UCI HAR Dataset")

## Load requisite packages

library(dplyr)
library(tidyr)

## Read in feature names

df <- read.table("features.txt", header = FALSE)
features <- df$V2

## Read in training subjects, convert to tibble, and assign meaningful column names

trainSubs <- read.table("./train/subject_train.txt", header = TRUE)
trainSubs <- as_tibble(trainSubs)
names(trainSubs) <- "Subject"

## Read in training set, convert to tibble, and assign meaningful column names

trainSet <- read.table("./train/X_train.txt", header = TRUE)
trainSet <- as_tibble(trainSet)
names(trainSet) <-  features

## Read in training labels and convert to tibble, and assign meaningful column names

trainLabels <- read.table("./train/y_train.txt", header = TRUE)
trainLabels <- as_tibble(trainLabels)
names(trainLabels) <- "Activity"

## Bind columns of trainSubs, trainSet, and trainLabels together

training <- bind_cols(trainSubs, trainLabels, trainSet)

## Exclude columns unrelated to mean and std, but retain Subject and Activity

training <- select(training, contains(c("Subject","Activity")) | contains(c("mean","std")))

## Read in testing subjects, convert to tibble, and assign meaningful column names

testSubs <- read.table("./test/subject_test.txt", header = TRUE)
testSubs <- as_tibble(testSubs)
names(testSubs) <- "Subject"

## Read in testing set, convert to tibble, and assign meaningful column names

testSet <- read.table("./test/X_test.txt", header = TRUE)
testSet <- as_tibble(testSet)
names(testSet) <-  features

## Read in testing labels and convert to tibble, and assign meaningful column names

testLabels <- read.table("./test/y_test.txt", header = TRUE)
testLabels <- as_tibble(testLabels)
names(testLabels) <- "Activity"

## Bind rows of testSubs, testSet, and testLabels together

testing <- bind_cols(testSubs, testLabels, testSet)

## Exclude columns unrelated to mean and std, but retain Subject and Activity

testing <- select(testing, contains(c("Subject","Activity")) | contains(c("mean","std")))

## Combine the training and testing data sets together

mergeDF <- bind_rows(training, testing)

## Assign tidy names to the columns of the full data set by removing special characters.

names(mergeDF) <- gsub("[[:punct:]]", "", names(mergeDF))

## Assign meaningful names to the activities

mergeDF <- mergeDF %>% 
    mutate(Activity = replace(Activity, Activity == 1, "WALKING")) %>% 
    mutate(Activity = replace(Activity, Activity == 2, "WALKING_UPSTAIRS")) %>% 
    mutate(Activity = replace(Activity, Activity == 3, "WALKING_DOWNSTAIRS")) %>% 
    mutate(Activity = replace(Activity, Activity == 4, "SITTING")) %>% 
    mutate(Activity = replace(Activity, Activity == 5, "STANDING")) %>% 
    mutate(Activity = replace(Activity, Activity == 6, "LAYING"))

## Calculate the average of each variable in the merged data set, grouped by activity and subject

averages <- mergeDF %>% 
    group_by(Subject, Activity) %>% 
    summarize(across(where(is.numeric), mean, na.rm = TRUE))

## Create output directory and write results of independent tidy data set to it

if(!file.exists("./output")){dir.create("./output")}
write_csv(averages, "./output/averages.csv")
