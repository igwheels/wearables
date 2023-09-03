## Instructions: This project leverages the script run_analysis.R to do the following:
    
        1) Merge training and test sets to create one data set.
        
        2) Extract only the measurements on the mean and standard deviation for each measurement.
        
        3) Use descriptive activity names to name the activities in the data set.
        
        4) Appropriately label the data set with descriptive variable names.
        
        5) From the data in step 4, create a second, independent tidy data set with the average of each variable for each
        activity and each subject.

## Process

    - All the steps/transformations required by the assignment listed above take place in run_analysis.R.
    
    - The script follows the following flow:
    
        1. Setwd
        2. Load packages.
        3. Load feature names into a vector so they can be applied as column names later.
        4. Read in training subjects (participants in the study), training set, and training labels. Convert them all
        to tibbles for easy of use.
        5. Bind these three tibbles together into a "training" tibble.
        6. Exclude columns unrelated to mean and std, but retain Subject and Activity in the training tibble.
        (Instructions #2 above).
        7. Repeat the process in step 4-6 for the test subjects, set, and labels and bind these tibbles together into a
        testing tables.
        8. Merge the training and testing tibbles together into "mergeDF". (Instructions #1 above).
        9. Tidy the column names by removing special characters from the names. (Instructions #4 above).
        10. Replace the activity numbers with descriptive activity names. (Instructions #3 above.)
        11. Calculate the average of each variable in the merged data set, grouped by activity and subject.
        (Instructions #5 above.)
        12. Export the grouped averages to an output folder with the filename called "average.csv".