###########################################
###  Function to create the PK profiles in ggplot
graph_function <- function(df,inp){

# If no data is simulated, do not create anything
if (is.null(df)) return()

## Add the dose units to the dose column
df$DOSE <- paste(df$DOSE,dose_units(inp$units))


# Create plot
p1lin <- ggplot(df, aes(x=time,y=Median_C,color=DOSE)) +
  ## Add ribbon for variability
  geom_ribbon(aes(ymin=Low_percentile, ymax=High_percentile, x=time), alpha = 0.15, linetype=0)+
  
  ## Add median line
  geom_line(size=2) +
  
  # Set axis and theme
  ylab(paste("Concentration (",inp$units,")",sep=""))+
  xlab("Time after dose (h)")+
  scale_x_continuous(expand=c(0,0))+
  # Set theme details
  theme_bw()+
  theme(legend.position="none", panel.grid.minor = element_blank())+  # Remove minor grid lines because of log y-axis
  scale_color_brewer(palette="Spectral")


## Same figure on log scale
p1log <- p1lin + 
  scale_y_log10() + 
  annotation_logticks(sides = "l")+
  theme(legend.position="right",legend.title = element_blank())


## Combine in 1 plot with different widths to include the legend
plot_combine <- plot_grid(p1lin,p1log,ncol=2,rel_widths = c(1,1.2))

return(plot_combine)
}