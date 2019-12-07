############################################################
## Calculate the prediction interval based on user input
pi_function <- function(df,inp){
  
  # Set the probabilities to calculate based on user selection
  if(inp$variability =="10%-90%"){
    minprobs=0.1
    maxprobs=0.9
  }
  if(inp$variability =="5%-95%"){
    minprobs=0.05
    maxprobs=0.95
  }
  if(inp$variability =="25%-75%"){
    minprobs=0.25
    maxprobs=0.75
  }
  if(inp$variability =="No variability"){
    minprobs=0.5 # Set to median
    maxprobs=0.5 # Set to median
  }
  
  
  ## Calculate summary statistics
  sum_stat <- df %>%
    group_by(time,DOSE) %>%
    summarise(Median_C=median(DV),
              Low_percentile=quantile(DV, probs=minprobs),
              High_percentile=quantile(DV, probs=maxprobs)
    )  
  
  return(sum_stat)
}