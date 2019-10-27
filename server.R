#### Load required libraries
library(shiny)
library(mrgsolve)
library(dplyr)
library(ggplot2)
library(flux)
library(rmarkdown)
library(cowplot)
#library(shinycssloaders)
library(RColorBrewer)
library(magrittr)
library(shinydashboard)

## Shiny server code
shinyServer(function(input, output) {



#######################################################################
################# Run mrgsolve simulation upon button click
DF_Simulation <- eventReactive(input$do, {
  simulated_Data <- run_simulation(input)
  simulated_Data
})

### Calculate prediction intervals based on user input
prediction_intervals <- reactive({
  df <-   pi_function(DF_Simulation(),input)
  df
})

############### Calculate summary statistics
sum_stats <- reactive({
  df <-   numeric_stats_function(DF_Simulation(),input)
  df
})







  
  

####################################################
################################### Output
lin_log_plots <- reactive({
  
graph_function(prediction_intervals(),input)
  
})


  ## PK plot 
  output$PKplot <- renderPlot({
    lin_log_plots()
  })
  
  
  
  


######################## Summary stats tables
  
output$sumstattable <- renderTable(sum_stats(),align='c',bordered = TRUE)
  
  
  
#####################################################################################  
# Downloadable csv of selected dataset ----
output$downloadData <- downloadHandler(
  filename = function() {
    paste("Simulated_dataset",input$cmp_name,".csv",sep="")
  },
  content = function(file) {
    write.csv(DF_Simulation(), file, row.names = FALSE)
  }
)












  
  
  #####################################################################################
  ############# Generate .pdf report in rmarkdown
  
  
  output$report <- downloadHandler(
    filename = function() {
      paste("PMX_popPK report -", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      
      
      
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      

      tempLogo <- file.path(tempdir(), "Logo.png")
      file.copy("./www/Logo.png", tempLogo, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params_for_rmd =  list(sumstat=sum_stats(),
                             graphs=lin_log_plots(),
                             set_title=input$title,
                             compound=input$cmp_name,
                             description=input$description,
                             dose_units=dose_units(input$units)
                             )
      
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params_for_rmd,
                        envir = new.env(parent = globalenv())
      )
    }    
      
      
      
  )
  
  
  

  
  
  
  
})
