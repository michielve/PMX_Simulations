###########################################
### Create dataframe with the doses

dosing_function <- function(admin_route,interval,dose,nsamples){
  ## oral
  if(admin_route =='Depot')
    ev1 <- as.data.frame(ev(ID=1:nsamples,ii=interval, cmt=1, addl=9999, amt=dose))
  
  ## IV bolus
  if(admin_route =='I.V. bolus')
    ev1 <- as.data.frame(ev(ID=1:nsamples,ii=interval, cmt=2, addl=9999, amt=dose))
  
  ## IV infusion
  if(admin_route =='I.V. Infusion')
    ev1 <- as.data.frame(ev(ID=1:nsamples,ii=interval, cmt=2, addl=9999, amt=dose)) 
  
  
  return(ev1)
}

