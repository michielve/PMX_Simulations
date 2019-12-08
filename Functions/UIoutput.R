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
  ),
  
  fluidRow(
    box(solidHeader = TRUE, status = "success",collapsed=T,collapsible = T,title="Add user data",width=8,

    column(4,  HTML('<b>Include user data</b>
                                <br>Column headers should minimally include the following columns: <em>ID,CONCENTRATION,TIME</em><br>
                                A <em>DOSE</em> column can be added to stratify the data.<br>
                                ')),
    
    column(4,
           # Input: Select a file ----
           fileInput("file1", "Choose CSV File",
                     multiple = TRUE,
                     accept = c("text/csv",
                                "text/comma-separated-values,text/plain",
                                ".csv"))
    ),
    column(4,
           # Input: Select separator from user dataset ----
           radioButtons("sep", "Separator",
                        choices = c(Comma = ",",
                                    Semicolon = ";"),
                        selected = ",")
    )
  )
  

  
  
  
))
  
}


