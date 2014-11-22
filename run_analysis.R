#read the data
test_data <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\test\\x_test.txt")
test_subject <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\test\\subject_test.txt")
test_activity <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\test\\y_test.txt")

#train the data
train_data <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\train\\x_train.txt")
train_subject <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\train\\subject_train.txt")
train_activity <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\train\\y_train.txt")

#bind all of the columns
BigDataTableTest <- cbind(test_subject, test_activity, test_data)
BigDataTableTrain <- cbind(train_subject, train_activity, train_data)

#merge all of the data into one big table by stacking row of training and test data
BigDataTable <- rbind(BigDataTableTest, BigDataTableTrain)

#read activity and match it to replace number values with activity names
Activity <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\activity_labels.txt")
> BigDataTable[,2] <- Activity[match(BigDataTable[,2], Activity[,1]),2]

#add descriptive names to the dataset 
Features <- read.table("E:\\Dropbox\\Coursera\\_Signature Track Data Science\\Getting and Cleaning Data\\Data for project\\features.txt")
features_names <- as.vector(Features[,2])
features_names2 <- c("Subject","Activity", features_names)
names(BigDataTable) <- features_names2

#subtract the original measurements on mean and SD
NameColumnKeep <- c(features_names2[1],features_names2[2],
                    features_names2[3],features_names2[4],features_names2[5],
                    features_names2[6],features_names2[7],features_names2[8],
                    features_names2[43],features_names2[44],features_names2[45],
                    features_names2[46],features_names2[47],features_names2[48],
                    features_names2[123],features_names2[124],features_names2[125],
                    features_names2[126],features_names2[127],features_names2[128])
BigDataTable <- BigDataTable[NameColumnKeep]

#create a 2nd tidy data set with the average of each variable for each activity and subject
install.packages('plyr')
library('plyr')
BigDataTableTidy <- ddply(BigDataTable, .(Subject, Activity), numcolwise(mean))
write.table(BigDataTableTidy, file = "BigDataTableTidy.txt")