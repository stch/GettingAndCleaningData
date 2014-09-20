#1.Merges the training and the test sets to create one data set.
test.data <- read.table("UCI HAR Dataset/test/X_test.txt",colClasses = "numeric")
train.data <- read.table("UCI HAR Dataset/train/X_train.txt",colClasses = "numeric")
one.dataset <- rbind(test.data,train.data)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

one.means <- apply(one.dataset,2,mean)
one.sds <- apply(one.dataset,2,sd)

#4.Appropriately labels the data set with descriptive variable names. 

features.txt <- read.table("UCI HAR Dataset/features.txt")
dimnames(one.dataset)[[2]] <- features.txt[[2]]


#3.Uses descriptive activity names to name the activities in the data set
## matching labelnames by merge function destries sort order. so #3 is postponed. 
test.subj <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(test.subj)[[1]] <- "subject"
test.labl <- read.table("UCI HAR Dataset/test/Y_test.txt")
names(test.labl)[[1]] <- "label"
train.subj <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(train.subj)[[1]] <- "subject"
train.labl <- read.table("UCI HAR Dataset/train/Y_train.txt")
names(train.labl)[[1]] <- "label"
one.data <- rbind(cbind(test.subj,test.labl),cbind(train.subj,train.labl))
one.dataset <- cbind(one.data,one.dataset) # before maerge, bind labels and data. 

activities.txt <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activities.txt) <- c("label","label-name")
#one.dataset <- merge(activities.txt,one.dataset,by="label") #merging causes classes change to factor. and it fails #5. so maerging is done after #5 calculation.  


#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## combining list of dataframes to dataframe. 
lrbind <- function(dflist){
  ret <- dflist[[1]]
  for(df in dflist[2:length(dflist)]){
    ret <- rbind(ret,df)
  }
  ret
}


act.means <- lrbind(lapply(split(one.dataset,one.dataset$label),function(x){apply(x,2,mean)}))
act.means <- merge(activities.txt,act.means,by="label") #merging at #3 causes classes change to factor. 
write.table(act.means,"means_by_activity.txt",row.names=F)

sub.means <- lrbind(lapply(split(one.dataset,one.dataset$subject),function(x){apply(x,2,mean)}))
write.table(sub.means,"means_by_subject.txt",row.names=F)

