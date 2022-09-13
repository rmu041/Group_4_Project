## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(tidyverse)
library(here)

## Loading data to environment using read.csv ##

Group_4_data <- read.csv(here("data", "exam_nontidy - Copy.txt"))
view(Group_4_data)

## Loading data to environment using read.csv ##

Group_4_data <- read_delim(here("data", "exam_nontidy - Copy.txt"), delim = "\t")

# removing duplicated columns
Group_4_data <-
  Group_4_data %>%
    distinct()


