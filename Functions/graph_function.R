graph_function <- function(df,inp){


# If no data is simulated, do not create anything
if (is.null(df)) return()




df$DOSE <- paste(df$DOSE,dose_units(inp$units))

p1lin<- ggplot(df, aes(x=time,y=Median_C,color=DOSE)) +
  
  
  ## Add ribbon for variability including the residual error
  geom_ribbon(aes(ymin=Low_percentile, ymax=High_percentile, x=time), alpha = 0.15, linetype=0)+
  
  ## Add median line
  geom_line(size=2) +
  
  
  # Set axis and theme
  ylab(paste("Concentration (",inp$units,")",sep=""))+
  xlab("Time after dose (h)")+
  theme_bw()+
  
  # Remove legend
  theme(legend.position="none")+ scale_color_brewer(palette="Spectral")


## Same figure on log scale
p1log<-p1lin + scale_y_log10() + annotation_logticks(sides = "l")  +theme(legend.position="right")



plot_combine <- plot_grid(p1lin,p1log,ncol=2,rel_widths = c(1,1.2))

return(plot_combine)
}