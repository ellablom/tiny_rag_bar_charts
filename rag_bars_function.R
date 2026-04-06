# Function to make individual bar charts
rag_bars <- function(data) {
  # Make graph
  ggplot(data, aes(x = rag, y = count, fill = rag), group = 1) +
    geom_bar(stat = "identity") +
    # Set colours 
    scale_fill_manual(values = c("red" = "#D2222D",
                                       "amber" = "#FFBF00",
                                       "green" = "#238823")) +
    # Remove unwanted elements
    theme(legend.position = "none", 
          strip.text.x = element_blank(),
          panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text.x = element_blank(),
          plot.margin = margin(0, 0, -.2, 0, "cm"),
          # Format ticks and text elements
          axis.ticks.y = element_line(size = .1),
          axis.text.y = element_text(size = 5),
          plot.caption = element_text(vjust = 7.5, hjust = 0, size = 5)
    ) +
    # Format y axis labels
    scale_y_continuous(breaks = seq(0, 20, by = 5), limits = c(0, 20))
}

# Function to make individual bar charts with added totals annotation
rag_bars_ind <- function(data) {
  # Calculate total values
  total_values <- sum(data$count)
  # Make plots
  rag_bars(data) +
    # Add annotation
    labs(caption = paste("Observations:", total_values))
}