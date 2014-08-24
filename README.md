GettingandCleaningDataProject
=============================

Repository for the course project for the Getting and Cleaning Data course in the John's Hopkins Data Science specialization.  
It contains the following files:  

* **README.md**     

* **CodeBook.md** : The code book for this project. It provides details on the raw data, how the data is put together, the variables, and the transformations on the data to create the tidy data set tidyData.txt for this project
* **run_analysis.R** : R script that does the following tasks for the course project:  
  1. Merges the training and the test sets to create one data set
  2. Extracts the measurements on the mean and standard deviation for each measurement
  3. Uses descriptive activity names for the activities in the data set
  4. Labels the data set with descriptive variable names
  5. Creates a tidy data set (tidyData.txt) with the average of each variable for each activity and each subject  

  **Note that the script does not perform these tasks in the order described in the project assignment. The descriptive names for the activities and the variables are added to the data set (Steps 3 and 4) before the mean and standard deviation measures are extracted (Step 2).**
* **tidyData.txt** : the tidy data set created for this project. This file is also directly uploaded to the coursera homework site.
* **dataconfig.png** An image from David Hood in his David's Course Project FAQ (https://class.coursera.org/getdata-006/forum/thread?thread_id=43) showing how some of the data files fit together, used in CodeBook.md
