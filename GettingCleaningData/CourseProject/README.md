#Getting and Cleaning Data - Course Project

##Description
Includes R code to analyze data for the Getting and Cleaning Data class on Coursera 

##Scripts
###run_analysis.R
####Description
This R script performs analysis on data in the /Data directory and outputs a tidy data set to the /Data directory. More specifically this script does the following:

- Merges training and test sets into one data set
- Applies descriptive labels to the data set
- Creates a second, “tidy” data set with the average of each variable for each activity and each subject
- Outputs the “tidy” data set to a text file named “CourseProjectTidy.txt” placed in the /Data directory

####Dependencies
This script requires the sqldf R package (see http://cran.r-project.org/web/packages/sqldf/index.html)

####Notes
See CodeBook.md for more details.


