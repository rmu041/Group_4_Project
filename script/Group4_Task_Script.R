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

##Change column names that contain spaces or start with numbers (or characters?)----
Group_4_data <- 
<<<<<<< HEAD
  Group_4_data %>% 
  rename(id = `subject`,
         insulin_microiu_ml = `insulin microiu ml`,
         diabetes_5y = `5y diabetes`,
         measured_variable = `measured variable`,
         value = `.value`
  )
=======
Group_4_data %>% 
  rename(id = `subject`,
    insulin_microiu_ml = `insulin microiu ml`,
         diabetes_5y = `5y diabetes`,
         measured_variable = `measured variable`,
         value = `.value`
         )
>>>>>>> 5e9f7a508ef54c3ee5f0b3dad523b851f20d8c8d

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
Joining_data <- read_delim(here("data", "exam_joindata - copy.txt"), delim = "\t")

##Joining datasets----
Group_4_joined_data <-
  Group_4_data %>%
  left_join(Joining_data, by = "id")


##Explore data again after adjustments ----
summary(Group_4_joined_data)
glimpse(Group_4_joined_data)
skimr::skim(Group_4_joined_data)
naniar::gg_miss_var(Group_4_joined_data)
naniar::gg_miss_var(Group_4_joined_data, facet = diabetes_5y_classifier)

##Comment on missing data?----
#PROVIDE ANSWER HERE

##Stratify data by categorical column: min,max,mean,sd----
Group_4_joined_data %>% 
  group_by(glucose_mg_dl_classifier) %>% 
  summarise(max(bmi, na.rm = T), min(bmi, na.rm = T), mean(bmi, na.rm = T), sd(bmi, na.rm = T))



#Day 7----
#Does the level of glucose and insulin depend on each other?
Glucose_insulin_plot <-
  ggplot(Group_4_joined_data) +
  aes(x = glucose_mg_dl,
      y = insulin_microiu_pmol_l) +
  geom_point() +
  xlab("Glucose level (mg/dL)") +
  ylab("Insulin microIU/mL") +
  labs(title = "Glucose and insulin at 2 hours",
       caption = "data source: Diabetes Prediction Dataset from the Pima Indian Tribe and the NIDDK")
Glucose_insulin_plot

# The plot illustrates the relationship between plasma glucose concentration serum insulin at 2 hours after administration of an oral glucose tolerance test. Visually, there seems to appear a tendency toward a higher insulin level with higher glucose level. There are many missing values for insulin (375 out of 768), which could lead to a skewed outcome.

#Does the level of glucose and insulin depend on each other, when stratifying by outcome (diabetes_5y)?
Glucose_insulin_plot_stratified <-
  ggplot(Group_4_joined_data) +
  aes(x = glucose_mg_dl,
      y = insulin_microiu_pmol_l) +
  geom_point() +
  facet_wrap(facets = vars(diabetes_5y_classifier)) +
  geom_smooth(method = "lm") +
  xlab("Glucose level (mg/dL)") +
  ylab("Insulin microIU/mL") +
  labs(title = "Glucose and insulin at 2 hours",
       caption = "data source: Diabetes Prediction Dataset from the Pima Indian Tribe and the NIDDK")
Glucose_insulin_plot_stratified
#As without the stratification, there is a tendency to higher insulin with higher glucose. However, there are fewer observations for those with diabetes vs those without, which makes the results for those with diabetes less reliable.


# Does the level of glucose and blood pressure depend on each other?
glucose_bp <-
  ggplot(Group_4_joined_data) +
  aes(x = glucose_mg_dl,
      y = dbp_mm_hg) +
  geom_point() +
  xlab("Glucose level (mg/dl)") +
  ylab("Blood pressure (mm/hg)") +
  labs(title = "Relationship between glucose level and blood pressure",
       caption = "data source: Diabetes Prediction Dataset from the Pima Indian Tribe and the NIDDK")
glucose_bp
# Visually, it does not look like there is a relationship between level of glucose and blood pressure

#Day 8 ----

#The primary analysis task is to classify in each participant whether diabetes developed within 5 years of data collection

#Does the outcome depend on hospital?

Outcome_hospital_dependence <- 
Group_4_joined_data %>% 
  aov(diabetes_5y_classifier~hospital, data = .) 

Outcome_hospital_dependence %>%
  broom::tidy()

#The anova test yields a p-value of 0.298, which indicates that the outcome does not depend on hospital.
