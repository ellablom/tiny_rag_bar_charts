# Tiny RAG bar charts

A set of R scripts that automate the creation of small red-amber-green bar charts to quickly summarise reported data. Input data has three distinct dimensions: 1. individual reporters, 2. components, and 3. sub-components.

The scripts aggregate the red/amber/green responses per sub-component and display them in individual bar charts. The components are used to group the individual charts. Two input templates are available: one for data that is available at the level of the individual reporter and one where this data has already been aggregated. When running the scripts, please delete the input template you did not use.

**Outputs** consist of the following:
1. Individual charts that can be used as small visuals in a report
<img width="236" height="236" alt="image" src="https://github.com/user-attachments/assets/6633360a-bf8f-48fc-93cc-6649d8d425d5" />

2. Rows of charts, grouping all sub-components within a component
