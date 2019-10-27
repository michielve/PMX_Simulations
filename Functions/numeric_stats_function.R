numeric_stats_function <- function(df,inp){
  
  
  sumstat <- data.frame(Parameter=character(),
                        Dose=numeric(), 
                        Median=numeric(), 
                        Mean=numeric(), 
                        SD=numeric(), 
                        stringsAsFactors=FALSE) 
  
  
  ### Calculate Cmax and Tmax
  xx <- df %>% 
    group_by(ID,DOSE) %>% 
    summarize(Cmax= max(DV), 
              Tmax=time[which.max(DV)])  
  
  xx <- xx %>% 
    group_by(DOSE) %>%  
    summarize(cmax_median = median(Cmax),
              cmax_mean = mean(Cmax),
              cmax_sd = sd(Cmax),
              Tmax_median = median(Tmax),
              Tmax_mean = mean(Tmax),
              Tmax_sd = sd(Tmax)) 
  
  
  
  ## AUC calculations
  xx_auc <-  df %>% 
    group_by(ID,DOSE) %>%  
    summarize(AUC = auc(time,DV))
  
  xx_auc <- xx_auc %>% 
    group_by(DOSE) %>% 
    summarize(auc_median = median(AUC),
              auc_mean = mean(AUC),
              auc_sd = sd(AUC)) 
  
  
  for(i in 1:length(unique(xx$DOSE))){
    
    sumstat[(3*i-2),1] <- paste("Cmax (",inp$units,")",sep="")
    sumstat[(3*i-2),2] <- paste(unique(xx$DOSE)[i], dose_units(inp$units))
    sumstat[(3*i-2),3] <- round(xx[i,2],digits=2)
    sumstat[(3*i-2),4] <- round(xx[i,3],digits=2)
    sumstat[(3*i-2),5] <- round(xx[i,4],digits=2)
    
    sumstat[(3*i-1),1] <- "Tmax (h)"
    sumstat[(3*i-1),2] <- paste(unique(xx$DOSE)[i], dose_units(inp$units))
    sumstat[(3*i-1),3] <- round(xx[i,5],digits=2)
    sumstat[(3*i-1),4] <- round(xx[i,6],digits=2)
    sumstat[(3*i-1),5] <- round(xx[i,7],digits=2)
    
    sumstat[(3*i),1] <- "AUC 0-last"
    sumstat[(3*i),2] <- paste(unique(xx$DOSE)[i], dose_units(inp$units))
    sumstat[(3*i),3] <- round(xx_auc[i,2],digits=2)
    sumstat[(3*i),4] <- round(xx_auc[i,3],digits=2)
    sumstat[(3*i),5] <- round(xx_auc[i,4],digits=2)
    
    
  }
  
  
  return(sumstat)
  
  
}