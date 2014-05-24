#Code Book
Contains a list of variables, data files, and transformations performed by run_analysis.R

##Variables and associated data transformations
working_dir - stores working directory

data_dir - relative path to the UCI HAR Dataset being analyzed

dt_activity_labels - stores activity label data read into R from activity_labels.txt

dt_features - stores feature data read into R from features.txt

dt_X_train - stores X training data read into R from X_train.txt

dt_y_train - stores y training data read into R from y_train.txt

dt_subject_train - stores subject training data read into R from subject_train.txt

dt_X_test - stores X test data read into R from X_test.txt

dt_y_test - stores y test data read into R from y_test.txt

dt_subject_test - stores subject test data read into R from subject_test.txt

dt_X - the merged result of dt_X_train and dt_X_test; column names are replaced with those found in dt_features; all columns except mean and standard deviation are dropped

dt_y - the merged result of dt_y_train and dt_y_test; activity_key in dt_y is replaced with activity_name from dt_activity_labels

dt_subject - the merged result of dt_subject_train and dt_subject_test

dt_merged - the merged result of dt_subject, dt_X, and dt_y, with descriptive column names. This includes only mean and standard deviation measures broken down by subject_id and activity_name

dt_merged_averaged - the result of taking the average of all measures in dt_merged, broken down by subject_id and activity_name

##Data Files
activity_labels.txt - list of activity ids with associated label (or name)

features.txt - list of all feature names

X_train.txt - X training data set

X_test.txt - X test data set

y_train.txt - y training data set

y_test.txt - y test data set

subject_train.txt - subject training data set

subject_test.txt - subject test data set

CourseProjectTidy.txt - output file of run_analysis.txt; includes mean and standard deviation of each measurement broken down by “subject_id” and “activity_name”





