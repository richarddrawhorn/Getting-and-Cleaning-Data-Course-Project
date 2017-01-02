# Getting-and-Cleaning-Data-Course-Project
This is the final project for the Coursera course "Getting and Cleaning Data". 

1. The raw data can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the data files into a folder named "data" in your desired project directory. 
3. Start R and set the working directory to your project directory that contains the raw data folder. 
4. Run the attached R script "run_analysis.r". 

The R script contains detailed comments, but here is a general description of how it works. 

1. The "test" and "train" raw data are first loaded into data frames, and the column names set to those defined in the "features" data frame. 
2. New columns for "activity" and "subject" are added to both the "test" and "train" data frames, and populated with data from the "activity" and "subjects" data frames.
3. Duplicate columns are removed from both "test" and "train" data frames, and they are then combined into a single master data frame named "data". 
4. Descriptive activity names are added to "data" to replace the integer values. 
5. Parenthesis characters are removed from the column names to improve readability. 
6. "data" is converted to a "tbl_df" using the dplyr package, and a subset is extracted that contains only the "mean" and "standard deviation" variables. 
7. The data are grouped by "activity" and "subject", and the average is calculated for each variable. 


