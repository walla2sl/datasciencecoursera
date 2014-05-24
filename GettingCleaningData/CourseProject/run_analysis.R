library(sqldf)
working_dir = getwd()
data_dir = "/Data/UCI HAR Dataset"

# Load Activity Labels
dt_activity_labels <- read.table(paste(working_dir, data_dir, "/activity_labels.txt", sep=""), header=FALSE)

# Load Features
dt_features <- read.table(paste(working_dir, data_dir, "/features.txt", sep=""), header=FALSE)
  
# Load Training Data Sets
dt_X_train <- read.table(paste(working_dir, data_dir, "/train/X_train.txt", sep=""), header=FALSE)
dt_y_train <- read.table(paste(working_dir, data_dir, "/train/y_train.txt", sep=""), header=FALSE)
dt_subject_train <- read.table(paste(working_dir, data_dir, "/train/subject_train.txt", sep=""), header=FALSE)

# Load Test Data Sets
dt_X_test <- read.table(paste(working_dir, data_dir, "/test/X_test.txt", sep=""), header=FALSE)
dt_y_test <- read.table(paste(working_dir, data_dir, "/test/y_test.txt", sep=""), header=FALSE)
dt_subject_test <- read.table(paste(working_dir, data_dir, "/test/subject_test.txt", sep=""), header=FALSE)

# Merge Train and Test Data Sets
dt_X <- sqldf("SELECT * FROM dt_X_train UNION ALL SELECT * FROM dt_X_test")
rm(dt_X_train, dt_X_test)

dt_y <- sqldf("SELECT * FROM dt_y_train UNION ALL SELECT * FROM dt_y_test")
rm(dt_y_train, dt_y_test)

dt_subject <- sqldf("SELECT * FROM dt_subject_train UNION ALL SELECT * FROM dt_subject_test")
rm(dt_subject_train, dt_subject_test)

# Add feature labels to dt_X
setnames(dt_X, colnames(dt_X),as.vector(dt_features[,2]))

# Remove non-mean/standard deviation columns
dt_X<-dt_X[, grep("mean\\(\\)|std\\(\\)", colnames(dt_X))]

# Set descriptive column names
dt_y["row_key"]<-c(1:nrow(dt_y))
dt_subject["row_key"]<-c(1:nrow(dt_subject))
colnames(dt_y)<-c("activity_key", "row_key")
colnames(dt_activity_labels)<-c("activity_key","activity_name")
colnames(dt_subject)<-c("subject_id","row_key")

# Create single, merged data set with descriptive column names
dt_merged <- sqldf("SELECT dt_subject.subject_id, dt_activity_labels.activity_name FROM dt_subject, dt_activity_labels, dt_y
                   WHERE dt_subject.row_key = dt_y.row_key AND
                   dt_y.activity_key = dt_activity_labels.activity_key")
dt_merged <- cbind(dt_merged, dt_X)

# Clean up
rm(dt_activity_labels, dt_features, dt_subject, dt_X, dt_y)

# Create second, tidy data set averaging each X variable by subject_id and activity_name
dt_merged_averaged <- ddply(dt_merged, .(subject_id, activity_name), numcolwise(mean))

# Write output to text file
write.table(dt_merged_averaged, paste(working_dir, "/Data/CourseProjectTidy.txt", sep=""), sep=" ")