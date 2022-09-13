## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(tidyverse)

## Loading data to environment using read.csv ##

Group_4_data <- read.csv(here("data", "exam_nontidy - kopia.txt"))
view(Group_4_data)

## Loading data to environment using read.csv ##

Group_4_data <- read_delim(here("data", "exam_nontidy - kopia.txt"), delim = "\t")

#separate pregnancy and age
Exam_data_1 <- 
Exam_data_1 %>%
  separate(col = `pregnancy_num-age`,
           into = c("pregnancy_num", "age"),
           sep = "-")

#separate hospital and subject
Exam_data_1 <- 
Exam_data_1 %>%
  separate(col = subject,
           into = c("hospital", "subject"),
           sep = "-")
