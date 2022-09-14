## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(tidyverse)
library(here)

## Loading data to environment using read.csv ##
Group_4_data <- read.csv(here("DATA_copy", "exam_nontidy_Johannacopy.txt"))
view(Group_4_data)

##Separate columns
Group_4_data <- read_delim(here("DATA_copy", "exam_nontidy_Johannacopy.txt"), delim = "\t")

#separate pregnancy and age
Group_4_data <- 
  Group_4_data %>%
  separate(col = `pregnancy_num-age`,
           into = c("pregnancy_num", "age"),
           sep = "-")

# removing duplicated columns
Group_4_data <-
  Group_4_data %>%
    distinct()

#separate hospital and subject
Group_4_data <- 
  Group_4_data %>%
  separate(col = subject,
           into = c("hospital", "subject"),
           sep = "-")

##Change column names that contain spaces or start with numbers (or characters?)
Group_4_data <- 
Group_4_data %>% 
  rename(id = `subject`,
    insulin_microiu_ml = `insulin microiu ml`,
         diabetes_5y = `5y diabetes`,
         measured_variable = `measured variable`,
         value = `.value`
         )

##Set the order of columns as required (id-hospital-age, the rest)
Group_4_data <- 
  Group_4_data %>% 
  select(id, hospital, age, everything()) ##select() picks variables based on their names, everything() selects all variables

##Arrange ID column of your dataset in order of increasing number
Group_4_data <- 
  Group_4_data %>% 
  mutate_at(c("id"), as.numeric) #change characters to numeric otherwise the order is 1 10 11 2 21 22

Group_4_data <- 
  Group_4_data %>% 
  arrange(Group_4_data, id)

##Join additional data
Group_4_additional <- read.csv(here("DATA_copy", "exam_joindata_Johannacopy.txt"))
view(Group_4_additional)

##Separate additional data columns
Group_4_additional <- read_delim(here("DATA_copy", "exam_joindata_Johannacopy.txt"), delim = "\t")

#Make additional id column numeric
Group_4_additional <-
  Group_4_additional %>%
  mutate(id = as.numeric(id))

##Join additional dataset to main dataset
Complete_data <-
  Group_4_data %>%
  left_join(Group_4_additional, by = "id")
