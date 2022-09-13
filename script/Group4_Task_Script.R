## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(tidyverse)
library(here)

## Loading data to environment using read.csv ##

<<<<<<< HEAD
Group_4_data <- read.csv(here("DATA_copy", "exam_nontidy_Johannacopy.txt"))
view(Group_4_data)

##Separate columns
Group_4_data <- read_delim(here("DATA_copy", "exam_nontidy_Johannacopy.txt"), delim = "\t")
>>>>>>> 280eb053db99e36dd04492e04ff716f427b50fec

#separate pregnancy and age
Group_4_data <- 
  Group_4_data %>%
  separate(col = `pregnancy_num-age`,
           into = c("pregnancy_num", "age"),
           sep = "-")

<<<<<<< HEAD
Group_4_data <- read_delim(here("data", "exam_nontidy - Copy.txt"), delim = "\t")

# removing duplicated columns
Group_4_data <-
  Group_4_data %>%
    distinct()


=======
#separate hospital and subject
Group_4_data <- 
  Group_4_data %>%
  separate(col = subject,
           into = c("hospital", "subject"),
           sep = "-")
>>>>>>> 280eb053db99e36dd04492e04ff716f427b50fec

##Change column names that contain spaces or start with numbers (or characters?)
Group_4_data <- 
Group_4_data %>% 
  rename(insulin_microiu_ml = `insulin microiu ml`,
         diabetes_5y = `5y diabetes`,
         measured_variable = `measured variable`,
         value = `.value`
         )

##Set the order of columns as required
