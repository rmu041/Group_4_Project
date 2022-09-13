## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(tidyverse)
library(here)

## Loading data to environment using read.csv ##

<<<<<<< HEAD
Group_4_data <- read.csv(here("data", "exam_nontidy - Copy.txt"))
view(Group_4_data)
=======
Group_4_data <- read_delim(here("data", "exam_nontidy - kopia.txt"), delim = "\t")
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
