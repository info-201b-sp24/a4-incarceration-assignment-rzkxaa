library(ggplot2)
library(dplyr)
library(maps)
library(scales)  # For comma formatting

# Load the prison population data
prison_data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")

# Check the structure of the prison data
str(prison_data)

# State abbreviation to full name conversion
state_abbreviations <- data.frame(
  full_name = tolower(state.name),
  abbreviation = state.abb,
  stringsAsFactors = FALSE
)

# Merge prison data with state names
prison_data <- prison_data %>%
  left_join(state_abbreviations, by = c("state" = "abbreviation"))

# Aggregate the prison population data by full state names (handling missing values)
state_aggregated_data <- prison_data %>%
  group_by(full_name) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE))

# Load the map data
map_data <- map_data("state")

# Merge the aggregated data with the map data using full state names
merged_data <- merge(map_data, state_aggregated_data, by.x = "region", by.y = "full_name", all.x = TRUE)

# Print a sample of the merged data to check for correctness
head(merged_data)

# Explore the range of prison populations
summary(merged_data$total_prison_pop) # Check minimum and maximum values


# Plot choropleth map with total prison population aggregated by state
ggplot(merged_data, aes(x = long, y = lat, group = group, fill = total_prison_pop)) +
  geom_polygon(color = "black", size = 0.2, alpha = 0.7) +  # Add transparency for better state border visibility
  scale_fill_continuous(
    name = "Total Prison Population",
    low = "lightblue",  # Lighter color for low values
    high = "red",
    na.value = "grey50",
    labels = comma
  ) +
  labs(title = "Total Prison Population by State") +
  theme_void()
