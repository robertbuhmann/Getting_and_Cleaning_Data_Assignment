# Getting_and_Cleaning_Data_Assignment

Tidied data are contained in the files "tidy_train.csv" and tidy_test.csv"; information on variables for these files is contained within "codebook.txt"

The code contained within "run_analysis.R" will organize the data test and train datasets, which are part of the human activity recognition dataset, as per the assignment instructions.

Running the code in run_analysis.R will require loading and installing  the "dplyr" package. Users should load the .txt files referenced in the code from their specific directory. Names of the .txt files refrenced in tidy_code have not been changed following their download from the source.

After reading in the relevant data files the code will bind the dataframes containing the participant id, activity id and variable values to create a single test and train dataframes.

The code will then search for variables containing "mean" or "std" and select these variables to create a new dataframe.

The code will then re-code activity id's into their relevant names (e.g. 1 will be changed to "Walking"

Unnecessary characters will then be removed from the test and train data frames to create clean variable names.

Finally, test and train dataframes containing the mean for each variable grouped by activity label and participant ID will be created, resulting in tidy test and train datasets containing one observation per person for each activity.
