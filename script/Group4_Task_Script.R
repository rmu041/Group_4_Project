## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(here)
library(tidyverse)

## Loading data to environment using read.delim ##

Group_4_data <- read_delim(here("data", "exam_nontidy - kopia.txt"), delim = "\t")
view(Group_4_data)

## Pivoting columns with values from various measurements----
Group_4_data <- Group_4_data %>% 
  pivot_wider(names_from = "measured variable",
              values_from = "value")
