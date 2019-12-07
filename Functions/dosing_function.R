###########################################
### Create dataframe with the doses based on user input
dosing_function <- function(admin_route,interval,dose,nsamples){
  ## oral - cmt 1
  if(admin_route =='Depot')
    ev1 <- as.data.frame(ev(ID=1:nsamples,ii=interval, cmt=1, addl=9999, amt=dose))
  
  ## IV bolus
  if(admin_route =='I.V. bolus')
    ev1 <- as.data.frame(ev(ID=1:nsamples,ii=interval, cmt=2, addl=9999, amt=dose))
  
  ## IV infusion - the rate of infusion will be added later in the run_simulation function
  if(admin_route =='I.V. Infusion')
    ev1 <- as.data.frame(ev(ID=1:nsamples,ii=interval, cmt=2, addl=9999, amt=dose)) 
  
  return(ev1)
}

