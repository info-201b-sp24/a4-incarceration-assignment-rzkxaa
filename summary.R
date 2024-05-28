library(dplyr)

# Read your data
prison_data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

# Compute summary statistics
total_states <- n_distinct(prison_data$state)
total_years <- n_distinct(prison_data$year)
total_records <- nrow(prison_data)
total_prison_pop <- sum(prison_data$total_prison_pop, na.rm = TRUE)
total_female_prison_pop <- sum(prison_data$female_prison_pop, na.rm = TRUE)
total_male_prison_pop <- sum(prison_data$male_prison_pop, na.rm = TRUE)

# Create a list of summary statistics
summary_stats <- list(
  total_states = total_states,
  total_years = total_years,
  total_records = total_records,
  total_prison_pop = total_prison_pop,
  total_female_prison_pop = total_female_prison_pop,
  total_male_prison_pop = total_male_prison_pop
)
