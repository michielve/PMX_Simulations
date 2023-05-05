################################################
## Main function to simulate the model
run_simulation <- function(inp,mod){
  
 
  ## Specify the omegas and sigmas as a matrix based on user input
  omega <- cmat(inp$etaka,
                0, inp$etacl,
                0,0,inp$etavd,
                0,0,0,inp$etavd2,
                0,0,0,0,inp$etavd3,
                0,0,0,0,0,inp$etaq1,
                0,0,0,0,0,0,inp$etaq2,
                0,0,0,0,0,0,0,inp$etaF)
  
  sigma <- cmat(inp$sigmaprop,
                0,inp$sigmaadd)
  
  
  ###################################################
  ### Repeat the simulation function for each dosing level
  
  # Split the user input on each comma and create a vector
  dosing_vector <- as.numeric(unlist(strsplit(inp$dos,",")))
  
  # For each dose
  for (dose in dosing_vector) {
    
    ## Simulate subjects with the values
    idata <- data_frame(ID=1:inp$nsamples)
    
    Administration <- dosing_function(inp$admin,inp$int,dose,inp$nsamples)
    
    data <- merge(idata,Administration,by="ID")
    
    ## IV infusion  - This calculates the administration rate
    if(inp$admin =='I.V. Infusion'){
      data$rate <- data$amt/inp$dur
    }
    
    ####################### 
    # Add the parameters to the dataset
    data$TVKA <- inp$ka
    data$TVCL <- inp$cl
    data$TVVC <- inp$vd
    data$TVVP1 <- inp$vd2
    data$TVVP2 <- inp$vd3
    data$TVQ1 <- inp$q1
    data$TVQ2 <- inp$q2
    data$TVF <- inp$bioF
    
    ### Set inter compartmental rates to 0 to remove the compartments from the simulation
    if(inp$cmt_structural =='1 CMT'){
      data$TVQ1 <- 0
      data$TVQ2 <- 0
    }
    if(inp$cmt_structural =='2 CMT'){
      data$TVQ2 <- 0
    }
    
    
    
    #########################
    # Perform simulation with mrgsolve
    df <- mod %>%
      data_set(data) %>%
     # idata_set(idata) %>%
      omat(omega) %>%
      smat(sigma) %>%
      mrgsim(start=inp$sim_start,end=(inp$sim_start+inp$sim_time),delta=inp$sim_time/200, obsonly=TRUE) %>% # Simulate 200 observations over the time frame specified
      mutate(DOSE = dose) %>% # Add the current dose to the df
      as.data.frame()
    
    
      
    #########################
    # Create a new object on the first iteration, add new results for each dosing level afterwards
    if(dose == dosing_vector[1]){
      df_all <- df
    }else{
      df_all <- rbind(df_all,df)
    }
  }
  
  return(df_all) # Return the simulation results
}