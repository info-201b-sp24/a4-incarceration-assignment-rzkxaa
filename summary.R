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

# Total Population by Race
total_black_prison_pop <- sum(prison_data$black_prison_pop, na.rm = TRUE)
total_white_prison_pop <- sum(prison_data$white_prison_pop, na.rm = TRUE)
total_latinx_prison_pop <- sum(prison_data$latinx_prison_pop, na.rm = TRUE)
total_aapi_prison_pop <- sum(prison_data$aapi_prison_pop, na.rm = TRUE)

# Average Prison Population by County
avg_prison_pop_by_county <- prison_data %>%
  group_by(county_name) %>%
  summarize(avg_prison_pop = mean(total_prison_pop, na.rm = TRUE))

# Top 5 Counties by Total Prison Population
top_5_counties_by_prison_pop <- prison_data %>%
  group_by(county_name) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE)) %>%
  arrange(desc(total_prison_pop)) %>%
  slice(1:5)

# Change in Total Prison Population Over Time
change_in_prison_pop_over_time <- prison_data %>%
  group_by(year) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE))

# Total Urban vs. Rural Prison Population
total_urban_prison_pop <- prison_data %>%
  filter(urbanicity == "urban") %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE)) %>%
  pull(total_prison_pop)

total_rural_prison_pop <- prison_data %>%
  filter(urbanicity == "rural") %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE)) %>%
  pull(total_prison_pop)

# Create a list of summary statistics
summary_stats <- list(
  total_states = total_states,
  total_years = total_years,
  total_records = total_records,
  total_prison_pop = total_prison_pop,
  total_female_prison_pop = total_female_prison_pop,
  total_male_prison_pop = total_male_prison_pop,
  total_black_prison_pop = total_black_prison_pop,
  total_white_prison_pop = total_white_prison_pop,
  total_latinx_prison_pop = total_latinx_prison_pop,
  total_aapi_prison_pop = total_aapi_prison_pop,
  avg_prison_pop_by_county = avg_prison_pop_by_county,
  top_5_counties_by_prison_pop = top_5_counties_by_prison_pop,
  change_in_prison_pop_over_time = change_in_prison_pop_over_time,
  total_urban_prison_pop = total_urban_prison_pop,
  total_rural_prison_pop = total_rural_prison_pop
)

# Print the new summary statistics
print(summary_stats)
