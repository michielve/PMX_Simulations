##################################
## Model output tab
UIoutput <- function() {
  
  tagList(
  fluidRow(
    box(solidHeader = TRUE, status = "primary",collapsible = F,title="Pharmacokinetic profiles",width=8,
        plotOutput("PKplot"),  # PK profiles
        
        fluidRow(
          column(6,  HTML('<b>Show prediction interval:</b>')),
          column(6, 
                 selectInput('variability', label=NULL, c("10%-90%","5%-95%","25%-75%","No variability")))
        ),
        fluidRow(
          column(6,  HTML('<b>Concentration units:</b>')),
          column(6,  
                 selectInput('units', label=NULL, c("ug/L","mg/L","nM")))
        ),
        downloadButton("downloadData", "Download the simulated dataset (.csv)") # Download the simulated data
    ),
    
    
    ## Summary stats
    box(solidHeader = TRUE, status = "primary",collapsible = T,title="Summary statistics",width=4,
        tableOutput('sumstattable'))
  )
  
  
)
  
}


