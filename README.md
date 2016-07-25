# UCI HAR Dataset cleaning

This R script is for cleaning the UCI HAR Dataset for the Coursera **Getting and Cleaning Data course**: https://class.coursera.org/getdata-013/.

## How the script works

First of all, this script load test and training data and store them in R objects. Both training data and test data are are combined. We applies column labels describing the the observations. We replace the activity ID by the corresponding description. We selects only the means and stds columns. And finally grouping a new data set by activity and subject ID and compute the mean of each variable.
