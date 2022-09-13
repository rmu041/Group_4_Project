## Pivoting columns with values from various measurements
Group_4_data <- Group_4_data %>% 
  pivot_wider(names_from = "measured variable",
              values_from = "value")
