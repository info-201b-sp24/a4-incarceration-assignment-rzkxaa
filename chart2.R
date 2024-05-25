# Load necessary libraries
library(ggplot2)

# Remove rows with missing values in total_pop and total_prison_pop columns
prison_data_clean <- na.omit(prison_data[, c("year", "total_pop", "total_prison_pop")])

prison_data_clean <- prison_data_clean %>%
  mutate(prison_population_ratio = total_prison_pop / total_pop)

# Create the scatter plot for variable comparison with adjusted x-axis scale
variable_comparison_scatter <- ggplot(prison_data_clean, aes(x = total_pop, y = total_prison_pop)) +
  geom_point(color = "#4e79a7") +
  labs(title = "Comparison of Total Prison Population and Total Population",
       x = "Total Population", y = "Total Prison Population") +
  scale_x_continuous(labels = scales::comma, breaks = scales::pretty_breaks(n = 10)) + # Adjust x-axis scale
  theme_minimal()

# Display the chart
print(variable_comparison_scatter)
