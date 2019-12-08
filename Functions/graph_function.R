###########################################
###  Function to create the PK profiles in ggplot
graph_function <- function(df,inp){

# If no data is simulated, do not create anything
if (is.null(df)) return()

## Add the dose units to the dose column
df$DOSE <- paste(df$DOSE,dose_units(inp$units))





##################################################
####### Check if user data is provided
userdata <- NULL
if(!is.null(inp$file1)){
  userdata <- read.csv(inp$file1$datapath,
                       header = T,
                       sep = inp$sep)
  # Set header to capitols
  colnames(userdata) <- toupper(colnames(userdata))
  if("DOSE" %in% colnames(userdata))
  {
    userdata$DOSE <- paste(userdata$DOSE,dose_units(inp$units))  # Add units to dose column
  }
}






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
  scale_color_brewer(palette="Set1")



####################### Include user data if available
if(!is.null(userdata) & 'ID' %in% colnames(userdata) & 'TIME' %in% colnames(userdata) & 'CONCENTRATION' %in% colnames(userdata)){
  if("DOSE" %in% colnames(userdata))
  {
    p1lin <- p1lin + 
      geom_point(data=userdata,aes(x=TIME,y=CONCENTRATION),size=2) + # With dose as column
      geom_line(data=userdata,aes(x=TIME,y=CONCENTRATION,group=ID),size=1) # With dose as column
  }else{
    p1lin <- p1lin + 
      geom_point(data=userdata,aes(x=TIME,y=CONCENTRATION,color='User data'),size=2)+
      geom_line(data=userdata,aes(x=TIME,y=CONCENTRATION,group=ID,color='User data'),size=1)
  }
}



## Same figure on log scale
p1log <- p1lin + 
  scale_y_log10() + 
  annotation_logticks(sides = "l")+
  theme(legend.position="right",legend.title = element_blank())


## Combine in 1 plot with different widths to include the legend
plot_combine <- plot_grid(p1lin,p1log,ncol=2,rel_widths = c(1,1.2))

return(plot_combine)
}