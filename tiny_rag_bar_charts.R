# Load libraries
library(tidyverse)
library(patchwork)
library(ggh4x)
# Read in functions
source("rag_bars_function.R")

# USER: ENTER FILE NAME AND SELECT LEVEL OF DATA
file_name = "reporter_level_template.csv"
data_level = "reporter"
# data_level = "aggregated"

# Read data
data_file <- read.csv(paste("./input/", file_name, sep = ""))
# If the data is at reporter level, aggregate it first
if (data_level == "reporter") {
  # Make data tidy
  data_file <- data_file %>%
    pivot_longer(cols = c("red", "amber", "green"), names_to = "rag", values_to = "count")
}
# Calculate counts per colour
rag_data <- data_file %>%
  subset(total > 0) %>%
  group_by(component, sub_component, rag) %>%
  summarise(count = sum(count))
# Set levels
rag_data$rag <- factor(rag_data$rag, levels = c("green", "amber", "red"))

# Create outputs:
# 1. Individual charts at sub-component level
# 2. Rows of charts for each component

# Set output folder if it doesn't already exist
dir.create(file.path(".", "./output"), showWarnings = FALSE)

# Create individual graphs at sub-component level
# Make folder
dir.create(file.path(".", "./output/individual"), showWarnings = FALSE)
# Get list of sub-components
unique_sub <- unique(rag_data$sub_component)
# Iterate to create individual graphs
for (i in unique_sub) {
  # Subset data by sub-component
  sub_data <- subset(rag_data, sub_component == i)
  # Create and save graphs
  temp_plot = rag_bars_ind(sub_data)
  ggsave(temp_plot, path = "./output/individual/", file = paste0("plot_", i,".png"), width = 2, height = 2, units = "cm")
}

# Create a row of graphs for each level 2
# Make folder
dir.create(file.path(".", "./output/rows"), showWarnings = FALSE)
# Get list of components
unique_comp <- unique(rag_data$component)
# Iterate over each component
for (comp_name in unique_comp) {
  # Subset data by component
  comp_data <- subset(rag_data, component == comp_name)
  comp_num = n_distinct(comp_data$sub_component)
  temp_plot <- rag_bars_row(comp_name, comp_data) +
    # Set size of entire panel so each row is of variable width
    force_panelsizes(total_width = unit(comp_num * 1.5, "cm"), total_height = unit(2, "cm"))
  ggsave(temp_plot, path = "./output/rows/", file = paste0("row_", comp_name,".png"), height = 3, width = (comp_num * 1.5) + 2, units = "cm")
}