run_simulation <- function(inp){
  
  
  ### Load in model code for mrgsolve once at start of app
  mod <- mread_cache("popPK")
  
  
  ## Specify the omegas and sigmas
  omega <- cmat(inp$etaka,
                0, inp$etacl,
                0,0,inp$etavd,
                0,0,0,inp$etavd2,
                0,0,0,0,inp$etavd3,
                0,0,0,0,0,inp$etaq1,
                0,0,0,0,0,0,inp$etaq2)
  
  sigma <- cmat(inp$sigmaprop,
                0,inp$sigmaadd)
  
  
  ###################################################
  ### Execute function for each dosing level
  dosing_vector <- as.numeric(unlist(strsplit(inp$dos,",")))
  
  
  
  for (dose in dosing_vector) {
    
    ## Simulate subjects with the values
    idata <- data_frame(ID=1:inp$nsamples)
    
    Administration <- dosing_function(inp$admin,inp$int,dose,inp$nsamples)
    
    data <- merge(idata,Administration,by="ID")
    
    
    ## IV infusion  - This calculates the rate automatically
    if(inp$admin =='I.V. Infusion'){
      data$rate <- data$amt/inp$dur
    }
    
    
    data$TVKA <- inp$ka
    data$TVCL <- inp$cl
    data$TVVC <- inp$vd
    data$TVVP1 <- inp$vd2
    data$TVVP2 <- inp$vd3
    
    data$TVQ1 <- inp$q1
    data$TVQ2 <- inp$q2
    
    
    ### SET inter compartmental rates to 0 to remove the compartments
    if(inp$cmt_structural =='1 CMT'){
      data$TVQ1 <- 0
      data$TVQ2 <- 0
    }
    if(inp$cmt_structural =='2 CMT'){
      data$TVQ2 <- 0
    }
    
    # Perform simulation
    df <- mod %>%
      data_set(data) %>%
      idata_set(idata) %>%
      omat(omega) %>%
      smat(sigma) %>%
      mrgsim(end=inp$sim_time,delta=inp$sim_time/120, obsonly=TRUE) %>% # Simulate 120 observations
      mutate(DOSE = dose) %>% # Add the current dose to the df
      as.data.frame()
      
    if(dose == dosing_vector[1]){
      df_all <- df
    }else{
      df_all <- rbind(df_all,df)
    }
  }
  
  
  return(df_all)
  
}