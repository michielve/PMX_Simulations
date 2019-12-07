######################################
## Calculate the summary statistics
numeric_stats_function <- function(df,inp){
  
  ### Calculate Cmax and Tmax
  ind_cmax_tmax <- df %>% 
    group_by(ID,DOSE) %>% 
    summarize(Cmax= max(DV), 
              Tmax=time[which.max(DV)])  
  
  # Average per DOSE
  cmax_tmax <- ind_cmax_tmax %>% 
    group_by(DOSE) %>%  
    summarize(cmax_median = median(Cmax),
              cmax_mean = mean(Cmax),
              cmax_sd = sd(Cmax),
              Tmax_median = median(Tmax),
              Tmax_mean = mean(Tmax),
              Tmax_sd = sd(Tmax)) 
  
  
  
  ## Calculate the AUC - linear trapezoid rule from flux package
  ind_auc <-  df %>% 
    group_by(ID,DOSE) %>%  
    summarize(AUC = auc(time,DV))
  
  auc_summary <- ind_auc %>% 
    group_by(DOSE) %>% 
    summarize(auc_median = median(AUC),
              auc_mean = mean(AUC),
              auc_sd = sd(AUC)) 
  
  
  ##########################################
  ## Initialize an empty dataframe
  sumstat <- data.frame(Parameter=character(),
                        Dose=numeric(), 
                        Median=numeric(), 
                        Mean=numeric(), 
                        SD=numeric(), 
                        stringsAsFactors=FALSE)
  
  ## Fill in the table for every simulated dose (3 rows of results per dose)
  for(i in 1:length(unique(cmax_tmax$DOSE))){
    
    sumstat[(3*i-2),1] <- paste("Cmax (",inp$units,")",sep="")
    sumstat[(3*i-2),2] <- paste(unique(cmax_tmax$DOSE)[i], dose_units(inp$units))
    sumstat[(3*i-2),3] <- round(cmax_tmax[i,2],digits=2)
    sumstat[(3*i-2),4] <- round(cmax_tmax[i,3],digits=2)
    sumstat[(3*i-2),5] <- round(cmax_tmax[i,4],digits=2)
    
    sumstat[(3*i-1),1] <- "Tmax"
    sumstat[(3*i-1),2] <- paste(unique(cmax_tmax$DOSE)[i], dose_units(inp$units))
    sumstat[(3*i-1),3] <- round(cmax_tmax[i,5],digits=2)
    sumstat[(3*i-1),4] <- round(cmax_tmax[i,6],digits=2)
    sumstat[(3*i-1),5] <- round(cmax_tmax[i,7],digits=2)
    
    sumstat[(3*i),1] <- paste("AUC 0-",inp$sim_time,sep="")
    sumstat[(3*i),2] <- paste(unique(cmax_tmax$DOSE)[i], dose_units(inp$units))
    sumstat[(3*i),3] <- round(auc_summary[i,2],digits=2)
    sumstat[(3*i),4] <- round(auc_summary[i,3],digits=2)
    sumstat[(3*i),5] <- round(auc_summary[i,4],digits=2)
    
  }
  
  
  return(sumstat)
  
  
}