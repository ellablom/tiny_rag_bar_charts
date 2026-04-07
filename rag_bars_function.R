# Function to add line breaks to labels
line_break <- function(x,...){
  gsub('\\s','\n',x)
}

# Function to make individual bar charts
rag_bars <- function(data) {
  # Make graph
  ggplot(data, aes(x = rag, y = count, fill = rag)) +
    geom_bar(stat = "identity") +
    # Set colours 
    scale_fill_manual(values = c("red" = "#D2222D",
                                       "amber" = "#FFBF00",
                                       "green" = "#238823")) +
    # Remove unwanted elements
    theme(legend.position = "none", 
          panel.grid = element_blank(),
          panel.background = element_blank(),
          axis.title.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text.x = element_blank(),
          # Format ticks and text elements
          axis.ticks.y = element_line(size = .1),
          axis.text.y = element_text(size = 5),
          plot.caption = element_text(vjust = 7.5, hjust = 0, size = 5),
          strip.background = element_blank()
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
    # Remove axes and add margin
    theme(axis.title.y = element_blank(),
          plot.margin = margin(0, 0, -.2, 0, "cm"),
          strip.text.x = element_text(size = 5)
    ) +
    # Add annotation
    labs(caption = paste("Observations:", total_values))
}

# Function to make a row of faceted bar charts
rag_bars_row <- function(comp_name, comp_data){
  comp_num = n_distinct(comp_data$sub_component)
  rag_bars(comp_data) +
    theme(strip.text.x = element_text(size = 5)
          ) +
    # Facet wrap
    facet_wrap(~sub_component, ncol = comp_num, labeller = label_wrap_gen(width = 10)) +
    # Include system name
    ylab(line_break(comp_name)) +
    theme(axis.title.y = element_text(size = 7, face = "bold"))
}