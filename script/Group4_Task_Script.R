## Group 4 task ##

## Creating a script for group 4 task ##

## Loading necessary packages ##
library(tidyverse)
library(here)

#Day 5----

##Loading data----
Group_4_data <- read_delim(here("data", "exam_nontidy - copy.txt"), delim = "\t")

##Separate columns----
Group_4_data <- 
  Group_4_data %>%
  separate(col = `pregnancy_num-age`,
           into = c("pregnancy_num", "age"),
           sep = "-")

##separate hospital and subject
Group_4_data <- 
  Group_4_data %>%
  separate(col = subject,
           into = c("hospital", "subject"),
           sep = "-")

## Removing duplicates----
Group_4_data <-
  Group_4_data %>%
  distinct()

## Pivoting columns with values from various measurements----
Group_4_data <- Group_4_data %>% 
  pivot_wider(names_from = "measured_variable",
              values_from = "value")

#Day 6----

## Remove  columns from your dataframe: choleste, sibling ----
Group_4_data <- 
  Group_4_data %>% 
  select(-c(sibling, choleste))

## Variable type changes ----
Group_4_data <- 
  Group_4_data %>%
  mutate(pregnancy_num = as.numeric(pregnancy_num),
         age = as.numeric(age),
         id = as.numeric(id))

##Change column names that contain spaces or start with numbers (or characters?)----
Group_4_data <- 
Group_4_data %>% 
  rename(id = `subject`,
    insulin_microiu_ml = `insulin microiu ml`,
         diabetes_5y = `5y diabetes`,
         measured_variable = `measured variable`,
         value = `.value`
         )

## Create set of columns for: glucose_mg_dl>120, insulin in units pmol/L ----
## diabetes_5y as 0/1, multiplication of age and pregnancy_num
Group_4_data <-
  Group_4_data %>% 
  mutate(glucose_mg_dl_classifier = if_else(glucose_mg_dl >= 120, "High", "Low")) %>% 
  mutate(insulin_microiu_pmol_l = insulin_microiu_ml*6.945) %>% 
  mutate(diabetes_5y_classifier = if_else(diabetes_5y == "pos", "1","0")) %>% 
  mutate(multiply_age_pregnancy = age*pregnancy_num) %>% 
  select(id,hospital,age,everything()) %>% 
  arrange(id)

##Read,join additional dataset to your main dataset----
Joining_data <- read_delim(here("data", "exam_joindata_copy_1.txt"), delim = "\t")

##Joining datasets----
Group_4_joined_data <-
  Group_4_data %>%
  left_join(Joining_data, by = "id")


##Explore data again after adjustments ----
summary(Group_4_data)
glimpse(Group_4_data)
skimr::skim(Group_4_data)
naniar::gg_miss_var(Group_4_data)
naniar::gg_miss_var(Group_4_data, facet = five_year_diabetes_classifier)

##Comment on missing data?----
#PROVIDE ANSWER HERE

##Stratify data by categorical column: min,max,mean,sd----
Group_4_joined_data %>% 
  group_by(glucose_mg_dl_classifier) %>% 
  summarise(max(bmi, na.rm = T), min(bmi, na.rm = T), mean(bmi, na.rm = T), sd(bmi, na.rm = T))



#Day 7----

