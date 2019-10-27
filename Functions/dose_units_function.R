
################# Set the dose units
dose_units <- function(C_units){
  ## Set dose units
  if(C_units == "ug/L"){
    dose_units <- "ug"
  }
  if(C_units == "mg/L"){
    dose_units <- "mg"
  }
  if(C_units == "nM"){
    dose_units <- "nmol"
  }
  return(dose_units)
  
}