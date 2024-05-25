library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

filtered_data <- long_data %>%
  filter(year >= 1985)

ggplot(filtered_data, aes(x = factor(year), y = total_prison_pop, fill = race)) +
  geom_bar(stat = 'identity', position = position_dodge()) +
  scale_fill_manual(values = c("AAPI" = "#1f77b4", "Black" = "#ff7f0e", "Latinx" = "#2ca02c", "Native" = "#d62728", "White" = "#9467bd")) +
  labs(title = 'Total Prison Population by Race and Year',
       x = 'Year', y = 'Total Prison Population') +
  scale_y_continuous(labels = comma) +  # Format y-axis labels
  scale_x_discrete(breaks = seq(1985, max(filtered_data$year), by = 10)) + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
